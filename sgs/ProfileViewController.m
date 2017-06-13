//
//  ProfileViewController.m
//  sgs
//
//  Created by Rone Loza on 5/5/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ProfileViewController.h"
#import "LocalizableManager.h"
#import "Constants.h"
#import "PreferencesManager.h"
#import "BaseNavigationViewController.h"
#import "UIAlertViewManager.h"
#import "NetworkManagerReachability.h"
#import "UserProfileItem.h"

@interface ProfileViewController ()

@property (nonatomic, strong) UserProfileItem *data;
@end

@implementation ProfileViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    self.titleLocalizedString = @"tab_myprofile_label";
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

- (void)setupLabels {
    
    [super setupLabels];
    
    self.settingsLabel.text = [[LocalizableManager localizedString:@"tab_settings_label"] capitalizedString];
    [self.logoutButton setTitle:[[LocalizableManager localizedString:@"lbl_button_logout"] uppercaseString] forState:(UIControlStateNormal)];
    
    [self updateUserProfileUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - FETCH Data

- (void)requestUserProfileWithCompletion:(void (^)(UserProfileItem *data, NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamUserProfile_ididioma,
                                  [country uppercaseString], kUrlPathParamUserProfile_idpais,
                                  userId, kUrlPathParamUserProfile_idusuario,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getUserProfileWithPostDict:postDataDict completion:^(UserProfileItem *data, NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion)completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getUserProfileWithPostDict:postDataDict completion:^(UserProfileItem *data, NSError *error) {
                            
                            if (completion)completion(data, error);
                        }];
                        
                    }
                }];
            }
            else {
                
                if (completion)completion(data, error);
            }
        }
        else {
            
            if (completion)completion(data, error);
        }
    }];
}

- (void)successRequestWithData:(UserProfileItem *)data error:(NSError *)error {
    
    __weak ProfileViewController *wkself = self;
    
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
                
                [wkself updateUserProfileUI];
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        
    }
}

- (void)updateUserProfileUI {
    
    if (self.data) {
        
        self.fullNameLabel.text = self.data.nombreusuario;
        self.companyLabel.text = self.data.nombreempresa;
        
        NSString *detail = [[NSString alloc] initWithFormat:@"%@\n%@ %@\n%@ %@", self.data.correo,
                            [LocalizableManager localizedString:@"lbl_number_movil"], self.data.telefonomovil,
                            [LocalizableManager localizedString:@"lbl_number_phone"], self.data.telefonofijo];
        
        self.detailProfileTextView.text = detail;
        
        self.footerTextView.text = self.data.mensajeperfil;
        
        self.profileImageView.image = (self.data.fotousuario.length > 0 ? [UIImage imageWithData:[self dataFromBase64EncodedString:self.data.fotousuario]] : [UIImage imageNamed:@"ic_user_profile"]);
    }
}
 
#pragma mark - IBActions

- (IBAction)settingsButtonPressed:(UIButton *)sender {
    
}

- (IBAction)logoutButtonPressed:(id)sender {
    
    [PreferencesManager setPreferencesBOOL:NO forKey:kPrefUserLoged];
    [PreferencesManager setPreferencesBOOL:NO forKey:kPrefsKeyUserTermnAccept];
    
//    [PreferencesManager setPreferencesString:@"" forKey:kPrefsKeyLang];
//    [PreferencesManager setPreferencesString:@"" forKey:kPrefsKeyCountry];
    
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    
    BaseNavigationViewController *navVC = (BaseNavigationViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeNavVC);
    
    UIViewController *topVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierSigninVC);
    UIViewController *cvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierCountryVC);
    UIViewController *fvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierFirstVC);
    
    navVC.viewControllers = [[NSArray alloc] initWithObjects:fvc, cvc, topVC, nil];
    
    appDelegate.window.rootViewController = navVC;
    [appDelegate.window makeKeyAndVisible];
}

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak ProfileViewController *wkself = self;
    
    [wkself requestUserProfileWithCompletion:^(UserProfileItem *data, NSError *error) {
        
        [wkself successRequestWithData:data error:error];
    }];
}

@end
