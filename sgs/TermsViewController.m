//
//  TermsViewController.m
//  sgs
//
//  Created by Rone Loza on 4/21/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "TermsViewController.h"
#import "LocalizableManager.h"
#import "NetworkManagerReachability.h"
#import "PreferencesManager.h"
#import "UIAlertViewManager.h"
#import "Constants.h"
#import "VerifyUserItem.h"
#import "BaseTabBarViewController.h"
#import "UINavigationController+Utils.h"
#import "SignViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.scrollView.bounces = NO;
    [self.navigationItem setHidesBackButton:!self.hiddenNextButton animated:NO];
    
    self.navigationItem.rightBarButtonItem = (!self.hiddenNextButton ? self.closeBarButton : nil);
    self.nextButton.hidden = self.hiddenNextButton;
    
    self.titleLocalizedString = @"lbl_navigation_title_terms";
    
    [UIAlertViewManager progressHUDSetMaskBlack];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self requestGetTerms];
}

- (void)setupLabels {
    
    [super setupLabels];
    
    [self.nextButton setTitle:[LocalizableManager localizedString:@"lbl_button_read_accept"] forState:UIControlStateNormal];
    [self.closeBarButton setTitle:[LocalizableManager localizedString:@"lbl_barbutton_close"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestGetTerms {
    
    __weak TermsViewController *wkself = self;
    
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiListTerms_ididioma,
                                  [country uppercaseString], kUrlPathParamApiListTerms_idpais,
                                  userId, kUrlPathParamApiListTerms_idusuario,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    Class objectClass = ([[wkself.navigationController backViewController] isKindOfClass:[SignViewController class]] ? [NetworkManager class] : [NetworkManagerReachability class]);
    
    [objectClass getListTermsPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [objectClass getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (error.code == kCFURLErrorNotConnectedToInternet) {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                        else {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                    }
                    else {
                        
                        [objectClass getListTermsPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem, NSError *error) {
                            
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
                                
                                [wkself successListTerms:verifyUserItem];
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
            
            [wkself successListTerms:verifyUserItem];
        }
    }];
}

- (void)requestAcceptTerms {
    
    __weak TermsViewController *wkself = self;
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [country uppercaseString], kUrlPathParamApiAcceptTerms_idpais,
                                  userId, kUrlPathParamApiAcceptTerms_idusuario,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    Class objectClass = ([[wkself.navigationController backViewController] isKindOfClass:[SignViewController class]] ? [NetworkManager class] : [NetworkManagerReachability class]);
    
    [objectClass acceptTermsPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [objectClass getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (error.code == kCFURLErrorNotConnectedToInternet) {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                        else {
                            
                            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                        }
                    }
                    else {
                        
                        [objectClass acceptTermsPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem, NSError *error) {
                            
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
                                
                                [wkself successAcceptTerms:verifyUserItem];
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
            
            [wkself successAcceptTerms:verifyUserItem];
        }
    }];
}

- (void)successListTerms:(VerifyUserItem *)verifyUserItem {
    
    __weak TermsViewController *wkself = self;
    
    if (verifyUserItem) {
        
//        if ([verifyUserItem.result isEqualToString:kUrlPathApiUserResponseCodeSuccess]) {
        
        [wkself dispatchOnMainQueue:^{
            
            [wkself.webView loadHTMLString:[[NSString alloc] initWithFormat:@"<div style=\"font-family:Arial;font-size:30px;color:orange;\">%@</div>",verifyUserItem.htmldetalle] baseURL:nil];
            
            [UIAlertViewManager progressHUDDismissWithCompletion:nil];
        }];
//        }
//        else {
//            
//            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:verifyUserItem.mensaje cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil completion:nil];
//        }
    }
    else {
        
        [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

- (void)successAcceptTerms:(VerifyUserItem *)verifyUserItem {
    
    __weak TermsViewController *wkself = self;
    
    if (verifyUserItem) {
        
        if ([verifyUserItem.result isEqualToString:kUrlPathApiUserResponseCodeSuccess]) {
            
            [PreferencesManager setPreferencesBOOL:YES forKey:kPrefsKeyUserTermnAccept];
            [PreferencesManager setPreferencesBOOL:YES forKey:kPrefUserLoged];
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself presentingTabController];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:verifyUserItem.mensaje cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil completion:nil];
        }
    }
    else {
        
        [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

- (void)presentingTabController {
    
//     __weak TermsViewController *wkself = self;
    
//    [wkself performSegueWithIdentifier:@"segue_home" sender:nil];
    
    BaseTabBarViewController *tabBarVC = (BaseTabBarViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeTabBarVC);
    
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    
    appDelegate.window.rootViewController = tabBarVC;
    [appDelegate.window makeKeyAndVisible];
}

#pragma mark - Navigation, IBActions

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextButtonPress:(UIButton *)sender {
    
    [self requestAcceptTerms];
}

- (IBAction)backButtonPress:(id)sender {
    
    [PreferencesManager setPreferencesBOOL:NO forKey:kPrefUserLoged];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
