//
//  MenuDetailInfoViewController.m
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "MenuDetailInfoViewController.h"
#import "LocalizableManager.h"
#import "MenuDetailItem.h"
#import "DetailInfoItem.h"
#import "Item.h"
#import "NetworkManagerReachability.h"
#import "UIAlertViewManager.h"
#import "PreferencesManager.h"
#import "Constants.h"

@interface MenuDetailInfoViewController ()

@property (nonatomic, strong) DetailInfoItem *data;
@end

@implementation MenuDetailInfoViewController

- (void)setupLabels {
    
    [super setupLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

#pragma mark - FETCH Data

+ (void)requestMenuDetailInfoWithItem:(MenuDetailItem *)item completion:(void(^)(DetailInfoItem *data, NSError *error))completion {
    
//    __weak MenuDetailInfoViewController *wkself = self;
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamMenuDetailInfo_ididioma,
                                  [country uppercaseString], kUrlPathParamMenuDetailInfo_idpais,
                                  userId, kUrlPathParamMenuDetailInfo_idusuario,
                                  item.idmenu,kUrlPathParamMenuDetailInfo_idmenu,
                                  item.idmenudetalle,kUrlPathParamMenuDetailInfo_idmenudetalle,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getMenuDetailInfoWithPostDict:postDataDict completion:^(DetailInfoItem *data, NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion )completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getMenuDetailInfoWithPostDict:postDataDict completion:^(DetailInfoItem *data , NSError *error) {
                            
                            if (completion )completion(data, error);
                        }];
                        
                    }
                }];
            }
            else {
                
                if (completion )completion(data, error);
            }
        }
        else {
            
            if (completion )completion(data, error);
        }
    }];
}

- (void)successRequestWithItem:(DetailInfoItem *)data error:(NSError *)error {
    
    __weak MenuDetailInfoViewController *wkself = self;
    
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
                
                [wkself.webView loadHTMLString:(wkself.data.htmldetalle.length > 0 ? wkself.data.htmldetalle : [[NSString alloc] initWithFormat:@"<div style='font-family:Arial;font-size:50;color:orange;'>%@</div>", [LocalizableManager localizedString:@"msg_not_html"]]) baseURL:nil];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
            
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

#pragma mark - IBActions

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak MenuDetailInfoViewController *wkself = self;
    
    [[MenuDetailInfoViewController class] requestMenuDetailInfoWithItem:(MenuDetailItem *)wkself.model completion:^(DetailInfoItem *data, NSError *error) {
        
        [wkself successRequestWithItem:data error:error];
    }];
}

@end
