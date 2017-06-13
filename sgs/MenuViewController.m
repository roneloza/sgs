//
//  MenuViewController.m
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "MenuViewController.h"
#import "Constants.h"
#import "NetworkManagerReachability.h"
#import "PreferencesManager.h"
#import "LocalizableManager.h"
#import "UIAlertViewManager.h"
#import "MenuTableViewCell.h"
#import "MenuItem.h"
#import "MenuDetailViewController.h"

#define kTableViewCellIdentifierMenu @"MenuTableViewCell"
#define kTableViewCellHeight 70.0f

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    self.titleLocalizedString = @"tab_menu_label";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark - Network

- (void)requestMenu {
    
    __weak MenuViewController *wkself = self;
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiMenu_ididioma,
                                  [country uppercaseString], kUrlPathParamApiMenu_idpais,
                                  userId, kUrlPathParamApiMenu_idusuario,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getMenuWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (error.code == kCFURLErrorNotConnectedToInternet) {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                        else {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                    }
                    else {
                        
                        [NetworkManagerReachability getMenuWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
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
                                
                                [wkself successRequestWithData:data];
                            }
                        }];
                        
                    }
                    
                }];
            }
            else if (error.code == kCFURLErrorNotConnectedToInternet) {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
            else {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
        }
        else {
            
            [wkself successRequestWithData:data];
        }
    }];
}

- (void)successRequestWithData:(NSArray *)menu {
    
    __weak MenuViewController *wkself = self;
    
    if (menu) {
        
        wkself.data = menu;
        
        [wkself dispatchOnMainQueue:^{
            
            [wkself.tableView reloadData];
            
            [UIAlertViewManager progressHUDDismissWithCompletion:nil];
        }];
    }
    else {
        
        [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifierMenu forIndexPath:indexPath];
    
    __weak MenuItem *item = [self.data objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.titlelabel.text = item.nombremenu;
    cell.titlelabel.textColor = UIColorFromHex((indexPath.row % 2 == 0 ? kColorSGS : kColorWhite), 1.0f);
    
    cell.iconImageView.image = (indexPath.row % 2 == 0 ? (item.icononaranja.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:item.icononaranja]] : [UIImage imageNamed:@"ic_menu_orange"]) : (item.iconoblanco.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:item.iconoblanco]] : [UIImage imageNamed:@"ic_menu_white"]));
    
    // Configure the cell...
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_menu_detail"]) {
        
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            __weak MenuItem *item = [self.data objectAtIndex:indexPath.row];
            
            __weak MenuDetailViewController *vc = (MenuDetailViewController *)segue.destinationViewController;
            vc.item = item;
        }
        
    }
}

- (void)refreshBarButtonPressed:(id)sender {
    
    [self requestMenu];
}


@end
