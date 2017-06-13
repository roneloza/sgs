//
//  SignViewController.m
//  sgs
//
//  Created by Rone Loza on 4/24/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "SignViewController.h"
#import "AnimationManager.h"
#import "Constants.h"
#import "LocalizableManager.h"
#import "UIAlertViewManager.h"
#import "PreferencesManager.h"
#import "NetworkManager.h"
#import "VerifyUserItem.h"
#import "CountryItem.h"
#import "BaseTabBarViewController.h"

@interface SignViewController()<UITextFieldDelegate>

@property(nonatomic, assign) BOOL viewDidAppear;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, assign) CGRect keyboardFrame;
@end

@implementation SignViewController

#pragma mark - Life Cicle

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.countryImageView.layer.cornerRadius = self.countryImageView.bounds.size.width * 0.5f;
    
    NSString *iconCuntry64 = [PreferencesManager getPreferencesStringForKey:kPrefUserCountryImageStringBase64];
    NSString *countryName = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountryName];
    
    self.countryImageView.image = (iconCuntry64.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:iconCuntry64]] : [UIImage imageNamed:@"ic_country_def"]);
    
    self.countryLabel.text = [countryName uppercaseString];
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
}

- (void)setupLabels {
    
    
    [self.nextButton setTitle:[LocalizableManager localizedString:@"lbl_button_enter"] forState:UIControlStateNormal];
    
    [self.chooseRegionButton setTitle:[LocalizableManager localizedString:@"lbl_button_change_region"] forState:UIControlStateNormal];
    
    NSDictionary *atrr = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, nil];
    
    self.userTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[LocalizableManager localizedString:@"lbl_placeholder_user"] attributes:atrr];
    
    self.passTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[LocalizableManager localizedString:@"lbl_placeholder_pass"] attributes:atrr];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.userTextField.delegate = self;
    self.passTextField.delegate = self;
    
    
    [self.userTextField becomeFirstResponder];
    
    self.viewDidAppear = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    self.userTextField.delegate = nil;
    self.passTextField.delegate = nil;
    
    self.passTextField.text = @"";
    self.userTextField.text = @"";
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (!self.viewDidAppear) {
        
        self.scrollView.contentInset = UIEdgeInsetsZero;
        self.scrollView.contentSize = self.scrollView.bounds.size;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.lockContextView.hidden = YES;
    self.passContentView.hidden = YES;
    self.nextButton.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
//    [self adjustingHeightShow:YES textField:textField keyboardFrame:self.keyboardFrame];
    
    self.textField = textField;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//     [self adjustingHeightShow:NO textField:textField keyboardFrame:self.keyboardFrame];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.scrollView endEditing:YES];
    
    if (textField == self.userTextField) {
        
        [self requestValidateUserName];
    }
    else if (textField == self.passTextField) {
        
        [self requestValidateUserPass];
    }
    
    return YES;
}

-(void)keyboardWillShow:(NSNotification *)notification {
    // Animate the current view out of the way
    
    __weak NSDictionary *userInfo = notification.userInfo;
    
    self.keyboardFrame = [(NSValue *)([userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey]) CGRectValue];
    
    [self adjustingHeightShow:YES textField:self.textField keyboardFrame:self.keyboardFrame];
    
//    [self adjustingHeightShow:YES notification:notification];
}

-(void)keyboardWillHide:(NSNotification *)notification {
    
    __weak NSDictionary *userInfo = notification.userInfo;
    
    self.keyboardFrame = [(NSValue *)([userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey]) CGRectValue];
    
    [self adjustingHeightShow:NO textField:self.textField keyboardFrame:self.keyboardFrame];
    
//    [self adjustingHeightShow:NO notification:notification];
}

- (void)adjustingHeightShow:(BOOL)show textField:(UITextField *)textField keyboardFrame:(CGRect)keyboardFrame {
    
    __weak SignViewController *wkself = self;
    
    wkself.scrollView.contentInset = UIEdgeInsetsZero;
    
//    __weak NSDictionary *userInfo = notification.userInfo;
//    
//    CGRect keyboardFrame = [(NSValue *)(userInfo[UIKeyboardFrameBeginUserInfoKey]) CGRectValue];
    
//    CGFloat changeInHeight = (CGRectGetHeight(keyboardFrame) + 40) * (show ? 1 : -1);
    
    CGRect convertRectkeyboard = keyboardFrame;
    convertRectkeyboard.origin.y = wkself.view.bounds.size.height - keyboardFrame.size.height;
    
    CGRect convertRectTextField = [textField convertRect:textField.bounds toView:self.view];
    
    CGFloat changeInHeight = 0;
    
    if ((convertRectTextField.origin.y + convertRectTextField.size.height) >= convertRectkeyboard.origin.y) {
        
        changeInHeight = (convertRectTextField.origin.y + convertRectTextField.size.height) - convertRectkeyboard.origin.y;
    }
    
//    changeInHeight = changeInHeight * (show ? 1 : -1);
    
    ////
    UIEdgeInsets contentInset = wkself.scrollView.contentInset;
    contentInset.bottom = changeInHeight;
    wkself.scrollView.contentInset = contentInset;
//    
//    UIEdgeInsets scrollContentInset = wkself.scrollView.scrollIndicatorInsets;
//    scrollContentInset.bottom = changeInHeight;
//    wkself.scrollView.scrollIndicatorInsets = scrollContentInset;
    
    [wkself.scrollView setContentOffset:CGPointMake(0, changeInHeight) animated:YES];
}

#pragma mark - Network

- (void)requestValidateUserName {
    
    __weak SignViewController *wkself = self;
    
    NSString *userName = (wkself.userTextField.text.length > 0 ? [wkself.userTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : @"");
    
    
    if (userName.length > 0) {
        
        
        NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
        NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
        
        NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [lang uppercaseString], kUrlPathParamApiUser_ididioma,
                                      [country uppercaseString], kUrlPathParamApiUser_idpais,
                                      userName, kUrlPathParamApiUser_idusuario,
                                      nil];
        
        //    wkself.userName = userName;
        
        [UIAlertViewManager progressHUShow];
        
        [NetworkManager validateUserNameWithPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem , NSError *error) {
            
            if (error) {
                
                if (error.code == kCFURLErrorUserCancelledAuthentication) {
                    
                    [NetworkManager getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                        
                        if (error) {
                            
                            if (error.code == kCFURLErrorNotConnectedToInternet) {
                                
                                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                            }
                            else {
                                
                                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                            }
                        }
                        else {
                            
                            [NetworkManager validateUserNameWithPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem, NSError *error) {
                                
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
                                    
                                    [wkself successRequestUserVerify:verifyUserItem];
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
                
                [wkself successRequestUserVerify:verifyUserItem];
            }
        }];
        
    }
    else {
        
         [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_checkLogins"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

- (void)requestValidateUserPass {
    
    __weak SignViewController *wkself = self;
    
    
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    
    NSString *userName = (wkself.userTextField.text.length > 0 ? [wkself.userTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : @"");
    
    NSString *userPass = (wkself.passTextField.text.length > 0 ? [wkself.passTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : @"");
    
    wkself.userName = userName;
    
    if (userName.length > 0 && userPass.length) {
        
        NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [lang uppercaseString], kUrlPathParamApiUserPass_ididioma,
                                      [country uppercaseString], kUrlPathParamApiUserPass_idpais,
                                      userName, kUrlPathParamApiUserPass_idusuario,
                                      userPass, kUrlPathParamApiUserPass_clave,
                                      nil];
        
        [UIAlertViewManager progressHUShow];
        
        [NetworkManager validateUserPassWithPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem , NSError *error) {
            
            if (error) {
                
                if (error.code == kCFURLErrorUserCancelledAuthentication) {
                    
                    [NetworkManager getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                        
                        if (error) {
                            
                            if (error.code == kCFURLErrorNotConnectedToInternet) {
                                
                                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                            }
                            else {
                                
                                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                            }
                        }
                        else {
                            
                            [NetworkManager validateUserPassWithPostDict:postDataDict completion:^(VerifyUserItem *verifyUserItem, NSError *error) {
                                
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
                                    
                                    [wkself successRequestPassUserVerify:verifyUserItem];
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
                
                [wkself successRequestPassUserVerify:verifyUserItem];
            }
        }];
    }
    else {
        
        [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_checkLogin"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

- (void)successRequestUserVerify:(VerifyUserItem *)verifyUserItem {
    
    __weak SignViewController *wkself = self;
    
    if (verifyUserItem) {
        
        if ([verifyUserItem.result isEqualToString:kUrlPathApiUserResponseCodeSuccess]) {
            
            [wkself dispatchOnMainQueue:^{
                
                wkself.lockContextView.hidden = NO;
                wkself.passContentView.hidden = NO;
                wkself.nextButton.hidden = NO;
                
                [AnimationManager animateOpacityWithView:wkself.lockContextView from:0.0f to:1.0f duration:0.5f completion:nil];
                [AnimationManager animateOpacityWithView:wkself.passContentView from:0.0f to:1.0f duration:0.5f completion:nil];
                [AnimationManager animateOpacityWithView:wkself.nextButton from:0.0f to:1.0f duration:0.5f completion:nil];
                
                [wkself.userButton setTintColor:UIColorFromHex(kColorSGS, 1.0f)];
                
                [wkself.passTextField becomeFirstResponder];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:verifyUserItem.mensaje cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil completion:^{
                
                [AnimationManager animateOpacityWithView:wkself.lockContextView from:1.0f to:0.0f duration:0.5f completion:nil];
                [AnimationManager animateOpacityWithView:wkself.passContentView from:1.0f to:0.0f duration:0.5f completion:nil];
                [AnimationManager animateOpacityWithView:wkself.nextButton from:1.0f to:0.0f duration:0.5f completion:^(BOOL finished) {
                    
                    wkself.lockContextView.hidden = YES;
                    wkself.passContentView.hidden = YES;
                    wkself.nextButton.hidden = YES;
                }];
                
                [wkself.userButton setTintColor:UIColorFromHex(kColorWhite, 1.0f)];
            }];
        }
    }
    else {
        
        [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
    }
}

- (void)successRequestPassUserVerify:(VerifyUserItem *)verifyUserItem {
    
    __weak SignViewController *wkself = self;
    
    if (verifyUserItem) {
        
        if ([verifyUserItem.result isEqualToString:kUrlPathApiUserResponseCodeSuccess]) {
            
            [PreferencesManager setPreferencesString:wkself.userName forKey:kPrefsKeyUserId];
            
            [wkself dispatchOnMainQueue:^{
                
                [PreferencesManager setPreferencesBOOL:YES forKey:kPrefUserLoged];
                [PreferencesManager setPreferencesBOOL:[verifyUserItem.boolaceptacion boolValue] forKey:kPrefsKeyUserTermnAccept];
                
                if ([verifyUserItem.boolaceptacion boolValue]) {
                    
                    [wkself presentingTabController];
                }
                else {
                    
                    [wkself performSegueWithIdentifier:@"segue_terms" sender:nil];
                    [wkself.passTextField resignFirstResponder];
                    
                }
                
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

#pragma mark - IBActions

- (IBAction)nextButtonPress:(UIButton *)sender {
    
    [self requestValidateUserPass];
}

- (IBAction)passwordEditChanged:(UITextField *)sender {
    
    NSString *text = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.lockButton setTintColor:UIColorFromHex(([text length] == 0 ? kColorWhite : kColorSGS), 1.0f)];
}

- (IBAction)showPassButtonPress:(UIButton *)sender {
    
    self.passTextField.secureTextEntry = !self.passTextField.secureTextEntry;
    [self.passTextField resignFirstResponder];
}

- (IBAction)chooseRegionButtonPress:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
