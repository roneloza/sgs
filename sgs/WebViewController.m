//
//  WebViewController.m
//  Pods
//
//  Created by rone loza on 5/31/17.
//
//

#import "WebViewController.h"
#import "PreferencesManager.h"
#import "Constants.h"
#import "NotificationDetailItem.h"
#import "NotificationItem.h"
#import "UIAlertViewManager.h"
#import "NetworkManagerReachability.h"
#import "LocalizableManager.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    self.webView.backgroundColor = UIColorFromHex(kColorGrey, 1.0f);
    self.webView.opaque = NO;
    
    if (self.url) {
        
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
    }
    else {
        
        if (self.htmlBody) {
            
            [self.webView loadHTMLString:self.htmlBody baseURL:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (void)requestNotificationDetailWithNotificationId:(NSString *)notificationId completion:(void (^)(NotificationDetailItem *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamNotiUpdateRead_ididioma,
                                  [country uppercaseString], kUrlPathParamNotiUpdateRead_idpais,
                                  userId, kUrlPathParamNotiUpdateRead_idusuario,
                                  notificationId, kUrlPathParamNotiUpdateRead_idnotificacion,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getNotificationDetailWithPostDict:postDataDict completion:^(NotificationDetailItem *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getNotificationDetailWithPostDict:postDataDict completion:^(NotificationDetailItem *data , NSError *error) {
                            
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

- (void)successRequestNotificationUpdateWithData:(NotificationDetailItem *)data error:(NSError *)error {
    
    __weak WebViewController *wkself = self;
    
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
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself.webView loadHTMLString:data.htmldetalle baseURL:nil];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak WebViewController *wkself = self;
    
    if ([wkself.model isKindOfClass:[NotificationItem class]]) {
        
        __weak NotificationItem *notificationItem = (NotificationItem *)wkself.model;
        
        [[wkself class] requestNotificationDetailWithNotificationId:notificationItem.idnotificacion completion:^(NotificationDetailItem *data, NSError *error) {
            
            [wkself successRequestNotificationUpdateWithData:data error:error];
        }];
    }
}


@end
