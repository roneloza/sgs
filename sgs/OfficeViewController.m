//
//  OfficeViewController.m
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "OfficeViewController.h"
#import "OfficeTableViewCell.h"
#import "PreferencesManager.h"
#import "NetworkManagerReachability.h"
#import "UIAlertViewManager.h"
#import "Constants.h"
#import "LocalizableManager.h"
#import "OfficeItem.h"
#import "DirectoryItem.h"
#import "ShareManager.h"
#import "CustomPageViewController.h"

#define kTableViewCellOfficeId @"OfficeTableViewCell"
#define kTableViewCellSocialHeight 161.0f

@interface OfficeViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation OfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleLocalizedString = @"title_offices_label";
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = UIEdgeInsetsZero;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

#pragma mark - FETCH Request

- (void)requestOfficeWithCompletion:(void(^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiOffice_ididioma,
                                  [country uppercaseString], kUrlPathParamApiOffice_idpais,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getOfficesWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getOfficesWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                    }
                }];
            }
            else {
                
                if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}

- (void)requestDirectoryWithCompletion:(void(^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamDirectory_ididioma,
                                  [country uppercaseString], kUrlPathParamDirectory_idpais,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getDirectoryWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getOfficesWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                    }
                }];
            }
            else {
                
                if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}

- (void)successRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak OfficeViewController *wkself = self;
    
    if (error) {
        
        if (error.code == kCFURLErrorUserCancelledAuthentication) {
            
        }
        else if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            wkself.data = data;
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself.tableView reloadData];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OfficeTableViewCell *cell = (OfficeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellOfficeId forIndexPath:indexPath];
    
    __weak Item *object = [self.data objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[OfficeItem class]]) {
        
        __weak OfficeItem *item = (OfficeItem *)object;
        
        cell.iconImageView.image = (item.imgoficina.length > 0 ? [UIImage imageWithData:[self dataFromBase64EncodedString:item.imgoficina]] : [UIImage imageNamed:@"ic_office_def"]);
        
        NSString *formattedText = [[NSString alloc] initWithFormat:
                                   @"%@\n"
                                   "%@\n"
                                   "%@\n"
                                   "%@\n"
                                   "%@\n"
                                   "%@ : %@\n",
                                   item.nombresede,
                                   item.direccionsede,
                                   item.ciudadsede,
                                   item.telefonosede,
                                   item.correosede,
                                   [[LocalizableManager localizedString:@"title_contact_label"] capitalizedString], item.contactosede];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithString:formattedText
                                                       attributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                                   [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                                                   [UIFont systemFontOfSize:14.0f], NSFontAttributeName, nil]];
        
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[formattedText rangeOfString:item.nombresede]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:[formattedText rangeOfString:item.nombresede]];
        
        cell.titleTextView.attributedText = [attributedString copy];
        
        CGSize size = CGSizeMake(198, 144);
        
        [cell.titleTextView sizeToFit];
        
        CGSize newSize = cell.titleTextView.frame.size;
        
        if (newSize.height > size.height) {
            
            item.height = [NSNumber numberWithFloat:(newSize.height - size.height)];
        }
        else {
            
            item.height = [NSNumber numberWithFloat:0];
        }
        
        NSArray *images = [[NSArray alloc] initWithObjects:@"ic_pin", @"ic_phone", @"ic_mail", nil];
        
        for (int i = 0; i < cell.buttons.count; i++) {
        
            __weak UIButton *button = [cell.buttons objectAtIndex:i];
            
            [button removeTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [button setImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:(UIControlStateNormal)];
            
            button.tag = indexPath.row;
        }
    }
    else if ([object isKindOfClass:[DirectoryItem class]]) {
        
        __weak DirectoryItem *item = (DirectoryItem *)object;
        
        cell.iconImageView.image = (item.fotopersona.length > 0 ? [UIImage imageWithData:[self dataFromBase64EncodedString:item.fotopersona]] : [UIImage imageNamed:@"ic_user_profile"]);
        
        NSString *formattedText = [[NSString alloc] initWithFormat:
                                   @"%@\n"
                                   "%@\n"
                                   "%@\n"
                                   "%@ %@ Anx. %@\n"
                                   "%@ %@\n"
                                   "%@\n",
                                   item.nombrepersona,
                                   item.nombresector,
                                   item.cargo,
                                   [[LocalizableManager localizedString:@"lbl_number_phone"] capitalizedString], item.telefonofijo, item.anexo,
                                   [[LocalizableManager localizedString:@"lbl_number_movil"] capitalizedString],item.telefonomovil,
                                   item.correo];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithString:formattedText
                                                       attributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                                   [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                                                   [UIFont systemFontOfSize:14.0f], NSFontAttributeName, nil]];
        
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[formattedText rangeOfString:item.nombrepersona]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:[formattedText rangeOfString:item.nombrepersona]];
        
        cell.titleTextView.attributedText = [attributedString copy];
        
        CGSize size = CGSizeMake(198, 144);
        
        [cell.titleTextView sizeToFit];
        
        CGSize newSize = cell.titleTextView.frame.size;
        
        if (newSize.height > size.height) {
            
            item.height = [NSNumber numberWithFloat:(newSize.height - size.height)];
        }
        else {
            
            item.height = [NSNumber numberWithFloat:0];
        }
        
        NSArray *images = [[NSArray alloc] initWithObjects:@"ic_phone", @"ic_mail", @"ic_wasap", nil];
        
        for (int i = 0; i < cell.buttons.count; i++) {
            
            __weak UIButton *button = [cell.buttons objectAtIndex:i];
            
            [button removeTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [button setImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:(UIControlStateNormal)];
            
            button.tag = indexPath.row;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak OfficeItem *item = [self.data objectAtIndex:indexPath.row];
    
    CGFloat heightForRow = ([item.height floatValue] > 0 ? (kTableViewCellSocialHeight + [item.height floatValue]) : kTableViewCellSocialHeight);
    
    return heightForRow;
}

#pragma mark - IBActions

- (IBAction)buttonPressed:(UIButton *)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    __weak OfficeTableViewCell *cell = (OfficeTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    __weak Item *object = [self.data objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[OfficeItem class]]) {
        
        __weak OfficeItem *item = (OfficeItem *)object;
        
        if ([cell.buttons indexOfObject:sender] == 0) {
            
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [[NSString alloc] initWithFormat:@"%@,%@", item.latitud, item.longitud], kSchemeGoogleMapsParam_center,
                                    @"14", kSchemeGoogleMapsParam_zoom,
                                    kSchemeGoogleMapsParam_mapmode_standard, kSchemeGoogleMapsParam_mapmode, nil];
            
            [[ShareManager class] openURLWithScheme:kSchemeGoogleMaps parameters:params];
        }
        else if ([cell.buttons indexOfObject:sender] == 1) {
            
            NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeTel, item.telefonosede];
            
            [[ShareManager class] openURLWithScheme:scheme parameters:nil];
        }
        else if ([cell.buttons indexOfObject:sender] == 2) {
            
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    item.contactosede, kSchemeMailParam_subject,
                                    item.contactosede, kSchemeMailParam_body, nil];
            
            NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeMail, item.correosede];
            
            [ShareManager openURLWithScheme:scheme parameters:params];
        }
    }
    else if ([object isKindOfClass:[DirectoryItem class]]) {
        
        __weak DirectoryItem *item = (DirectoryItem *)object;
        
        if ([cell.buttons indexOfObject:sender] == 0) {
            
            NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeTel, item.telefonomovil];
            
            [[ShareManager class] openURLWithScheme:scheme parameters:nil];
        }
        else if ([cell.buttons indexOfObject:sender] == 1) {
            
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    item.nombrepersona, kSchemeMailParam_subject,
                                    item.nombrepersona, kSchemeMailParam_body, nil];
            
            NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeMail, item.correo];
            
            [[ShareManager class] openURLWithScheme:scheme parameters:params];
        }
        else if ([cell.buttons indexOfObject:sender] == 2) {
            
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    item.nombrepersona, kSchemeWhatsAppParam_abid,
                                    @"", kSchemeWhatsAppParam_text,
                                    nil];
            
            [[ShareManager class] openURLWithScheme:[kSchemeWhatsApp stringByAppendingString:@"send"] parameters:params];
        }
    }
}

- (void)refreshBarButtonPressed:(id)sender {
   
    __weak OfficeViewController *wkself = self;
    
    if (wkself.isOfficeRequest) {
     
        [wkself requestOfficeWithCompletion:^(NSArray *data, NSError *error) {
            
            [wkself successRequestWithData:data error:error];
        }];
    }
    else {
        
        [wkself requestDirectoryWithCompletion:^(NSArray *data, NSError *error) {
            
             [wkself successRequestWithData:data error:error];
        }];
    }
}

@end
