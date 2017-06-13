//
//  ViewController.m
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "FirstViewController.h"
#import "AnimationManager.h"
#import "PreferencesManager.h"
#import "TitlePickerViewRow.h"
#import "UIAlertViewManager.h"
#import "NetworkManager.h"
#import "IdiomItem.h"
#import "LocalizableManager.h"
#import "Constants.h"
#import "PreferencesManager.h"

@interface FirstViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSArray *data;

@property(nonatomic, assign) BOOL viewDidAppear;

@end

@implementation FirstViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    for (NSString *font in [UIFont familyNames]) {
//        
//        NSLog(@"%@", font);
//    }
    
    __weak FirstViewController *wkself = self;
    
    CGFloat topPinY = (wkself.view.bounds.size.height / 2) - (wkself.logoView.bounds.size.height / 2);
    
    wkself.topPinConstraint.constant = topPinY;
    
    wkself.idiomPicker.alpha = 0.0f;
    wkself.nextButton.alpha = 0.0f;
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    [wkself requestGetIdiomsWithCompletion:^(NSArray *data, NSError *error) {
        
        [wkself handleRequestWithData:data error:error];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (!self.viewDidAppear) {
     
        [AnimationManager animateLogoView:self];
    }
    
    self.viewDidAppear = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
//    [self.displayLink invalidate];
//    self.displayLink = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)requestGetIdiomsWithCompletion:(void(^)(NSArray *data, NSError *error))completion {
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManager getIdiomsWithCompletion:^(NSArray *data, NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManager getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        completion(nil, error);
                    }
                    else {
                        
                        [NetworkManager getIdiomsWithCompletion:^(NSArray *data, NSError *error) {
                            
                            completion(data, error);
                        }];
                    }
                }];
            }
            else {
                
                completion(data, error);
            }
        }
        else {
            
            completion(data, error);
        }
    }];
}

- (void)handleRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak FirstViewController *wkself = self;
    
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
                
                [wkself.idiomPicker reloadAllComponents];
                
                NSString *idLang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
                
                NSString *idiom = (idLang.length > 0 ? idLang : @"es");
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K CONTAINS[cd] %@)",@"ididioma", idiom];
                
                __weak IdiomItem *item = [[data filteredArrayUsingPredicate:predicate] lastObject];
                
                if (item) {
                    
                    NSInteger row = [data indexOfObject:item];
                    
                    [wkself.idiomPicker selectRow:row inComponent:0 animated:NO];
                }
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

#pragma mark  - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.data.count;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//    __weak IdiomItem *item = [self.data objectAtIndex:row];
//    
//    return [item.nombreidioma uppercaseString];;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
     __weak IdiomItem *item = [self.data objectAtIndex:row];
    
    TitlePickerViewRow *countryPickerView = (view == nil) ? [[TitlePickerViewRow alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)] : (TitlePickerViewRow *)view;
    
    countryPickerView.titleLabel.text = [item.nombreidioma uppercaseString];
    
    return countryPickerView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    __weak IdiomItem *item = [self.data objectAtIndex:row];
//    
//    [PreferencesManager setPreferencesString:item.ididioma forKey:kPrefsKeyLang];
}

- (IBAction)nextButtonPress:(UIButton *)sender {
    
    NSInteger row = [self.idiomPicker selectedRowInComponent:0];
    
    __weak IdiomItem *item = [self.data objectAtIndex:row];
    
    [PreferencesManager setPreferencesString:item.ididioma forKey:kPrefsKeyLang];
    [PreferencesManager setPreferencesString:item.nombreidioma forKey:kPrefsKeyLangName];
}

@end
