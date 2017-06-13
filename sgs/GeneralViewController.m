//
//  SocialTableViewController.m
//  sgs
//
//  Created by Rone Loza on 5/8/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "GeneralViewController.h"
#import "PreferencesManager.h"
#import "Constants.h"
#import "UIAlertViewManager.h"
#import "NetworkManagerReachability.h"
#import "LocalizableManager.h"
#import "SocialTableViewCell.h"
#import "SocialItem.h"
#import "SectionItem.h"
#import "TermsViewController.h"
#import "OfficeViewController.h"
#import "ShareManager.h"

#define kTableViewCellSocialId @"SocialTableViewCell"
#define kTableViewCellSocialHeight 50.0f
#define kTableViewCellSocialHeaderHeight1 44.0f
#define kTableViewCellSocialHeaderHeight2 24.0f

#define kSegueContactToOffice @"segue_contact_to_office"
#define kSegueContactToTerms @"segue_contact_to_terms"

@interface GeneralViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;

@end

@implementation GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleLocalizedString = @"tab_contacts_label";
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - FETCH Request

- (void)requestSocialWithCompletion:(void (^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiSocial_ididioma,
                                  [country uppercaseString], kUrlPathParamApiSocial_idpais,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getSocialWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getSocialWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                        
                    }
                }];
            }
            else  {
                
               if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}

- (void)successRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak GeneralViewController *wkself = self;
    
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
            
            SocialItem *office = [[SocialItem alloc] initWithTitle:@"title_offices_label" selected:YES];
            office.segueId = kSegueContactToOffice;
            office.imageName = @"ic_office";
            
            SectionItem *section1 = [[SectionItem alloc] initWithTitle:@"title_contactus_label" selected:NO items:[data arrayByAddingObject:office]];
            
            SocialItem *terms = [[SocialItem alloc] initWithTitle:@"lbl_navigation_title_terms" selected:YES];
            terms.segueId = kSegueContactToTerms;
            terms.imageName = @"ic_terms";
            
            SectionItem *section2 = [[SectionItem alloc] initWithTitle:@"title_sgsonline_label" selected:NO items:[[NSArray alloc] initWithObjects:terms, nil]];
            
            wkself.data = [[NSArray alloc] initWithObjects:section1, section2, nil];
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return (section == 0  ? kTableViewCellSocialHeaderHeight1 : kTableViewCellSocialHeaderHeight2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellSocialHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    __weak SectionItem *item = (SectionItem *)[self.data objectAtIndex:section];
    
    return [LocalizableManager localizedString:item.title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    __weak SectionItem *item = (SectionItem *)[self.data objectAtIndex:section];
    
    return item.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SocialTableViewCell *cell = (SocialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellSocialId forIndexPath:indexPath];
    
    __weak SectionItem *section = (SectionItem *)[self.data objectAtIndex:indexPath.section];
    
    __weak SocialItem *item = [section.items objectAtIndex:indexPath.row];
    
    cell.disclosureButton.hidden = !item.selected;
    
    cell.titleLabel.text = (item.nombreredsocial.length > 0 ? item.nombreredsocial : [[LocalizableManager localizedString:item.title] capitalizedString]);
    
   cell.iconImageView.image = (item.iconoredsocial.length > 0 ? [UIImage imageWithData:[self dataFromBase64EncodedString:item.iconoredsocial]] : (item.imageName.length > 0 ? [UIImage imageNamed:item.imageName] : [UIImage imageNamed:@"ic_social_default"]));
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak SectionItem *section = (SectionItem *)[self.data objectAtIndex:indexPath.section];
    
    __weak SocialItem *item = [section.items objectAtIndex:indexPath.row];
    
    if (item.selected) {
        
        [self performSegueWithIdentifier:item.segueId sender:indexPath];
    }
    else {
        
        [ShareManager openURLWithItem:item];
    }
}

#pragma mark - IBActions

- (void)refreshBarButtonPressed:(id)sender {
    
     __weak GeneralViewController *wkself = self;
    
    [wkself requestSocialWithCompletion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithData:data error:error];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSegueContactToTerms]) {
        
        __weak TermsViewController *vc = segue.destinationViewController;
        vc.hiddenNextButton = YES;
        
    }
    else if ([segue.identifier isEqualToString:kSegueContactToOffice]) {
        
        __weak OfficeViewController *vc = segue.destinationViewController;
        
        vc.isOfficeRequest = YES;
    }
}

@end
