//
//  ChooseCountryViewController.m
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ChooseCountryViewController.h"
#import "SignViewController.h"
#import "CountryPickerViewRow.h"
#import "LocalizableManager.h"
#import "UIAlertViewManager.h"
#import "NetworkManager.h"
#import "PreferencesManager.h"
#import "CountryItem.h"
#import "Constants.h"

@interface ChooseCountryViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSArray *data;
@end

@implementation ChooseCountryViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    [self requestGetCountries];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)setupLabels {
 
    [self.nextButton setTitle:[LocalizableManager localizedString:@"lbl_button_ok_next"] forState:UIControlStateNormal];
    [self.closeBarButton setTitle:[LocalizableManager localizedString:@"lbl_barbutton_close"]];
    
    [self.closeBarButton setTitle:[LocalizableManager localizedString:@"lbl_barbutton_close"]];
    
    [self.closeBarButton setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:@"Univers LT Std Regular" size:14.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
//    [self.navigationItem setTitle:[LocalizableManager localizedString:@"lbl_navigation_title_region"]];
    
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    navTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:[LocalizableManager localizedString:@"lbl_navigation_title_region"] attributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:@"Univers LT Std Regular" size:14.0f], NSFontAttributeName, nil]];
    
    [self.navigationItem setTitleView:navTitleLabel];
    
}

- (void)requestGetCountries {
    
    __weak ChooseCountryViewController *wkself = self;
    
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];

    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  lang, kUrlPathParamApiCountry_ididioma,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManager getCountriesWithPostDict:postDataDict completion:^(NSArray *data, NSError *error) {
        
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
                        
                        [NetworkManager getCountriesWithPostDict:postDataDict completion:^(NSArray *data, NSError *error) {
                            
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
                                    
                                    [wkself successRequestWithData:data];
                                }
                                else {
                                    
                                    [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                                }
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
            
            if (data) {
                
                [wkself successRequestWithData:data];
            }
            else {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
        }
    }];
}

- (void)successRequestWithData:(NSArray *)data {
    
    __weak ChooseCountryViewController *wkself = self;
    
    wkself.data = data;
    
    [wkself dispatchOnMainQueue:^{
        
        [wkself.idiomPicker reloadAllComponents];
        
        NSString *idCountry = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
        
        NSString *idiom = (idCountry.length > 0 ? idCountry : @"pe");
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K CONTAINS[cd] %@)",@"idpais", idiom];
        
        __weak CountryItem *item = [[data filteredArrayUsingPredicate:predicate] lastObject];
        
        if (item) {
         
//            [PreferencesManager setPreferencesString:item.idpais forKey:kPrefsKeyCountry];
//            [PreferencesManager setPreferencesString:item.dominioservicio forKey:kPrefsKeyHost];
//            [PreferencesManager setPreferencesString:item.iconopais forKey:kPrefUserCountryImageStringBase64];
//            [PreferencesManager setPreferencesString:item.nombrepais forKey:kPrefsKeyCountryName];
            
            NSInteger row = [data indexOfObject:item];
            
            [wkself.idiomPicker selectRow:row inComponent:0 animated:NO];
        }
        
        [UIAlertViewManager progressHUDDismissWithCompletion:nil];
    }];
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

#pragma mark  - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.data.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    CountryPickerViewRow *countryPickerView = (CountryPickerViewRow *)view;
    
    if(view == nil) {
        
        countryPickerView = [[CountryPickerViewRow alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
        
        countryPickerView.iconImageView.layer.cornerRadius = countryPickerView.iconImageView.bounds.size.width * 0.5f;
    }
    else {
        
    }
    
    __weak CountryItem *item = [self.data objectAtIndex:row];
    
    countryPickerView.titleLabel.text = [item.nombrepais uppercaseString];
    
    if (item.iconopais.length > 0) {
        
        countryPickerView.iconImageView.image = [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:item.iconopais]];
    }
    
    return countryPickerView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    __weak CountryItem *item = [self.data objectAtIndex:row];
//    
//    [PreferencesManager setPreferencesString:item.idpais forKey:kPrefsKeyCountry];
//    [PreferencesManager setPreferencesString:item.dominioservicio forKey:kPrefsKeyHost];
//    [PreferencesManager setPreferencesString:item.iconopais forKey:kPrefUserCountryImageStringBase64];
//    [PreferencesManager setPreferencesString:item.nombrepais forKey:kPrefsKeyCountryName];
}

- (IBAction)nextButtonPress:(UIButton *)sender {
    
    NSInteger row = [self.idiomPicker selectedRowInComponent:0];
    
    __weak CountryItem *item = [self.data objectAtIndex:row];
    
    [PreferencesManager setPreferencesString:item.idpais forKey:kPrefsKeyCountry];
    [PreferencesManager setPreferencesString:item.dominioservicio forKey:kPrefsKeyHost];
    [PreferencesManager setPreferencesString:item.iconopais forKey:kPrefUserCountryImageStringBase64];
    [PreferencesManager setPreferencesString:item.nombrepais forKey:kPrefsKeyCountryName];
}

- (IBAction)backButtonPress:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_signin"]) {
        
        __weak CountryItem *item = [self.data objectAtIndex:[self.idiomPicker selectedRowInComponent:0]];
        
        __weak SignViewController *vc = (SignViewController *)segue.destinationViewController;
        vc.countryItem = item;
    }
}

@end
