    //
//  ECTabBarViewController.m
//  sgs
//
//  Created by Rone Loza on 4/25/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "BaseViewController.h"
#import "LocalizableManager.h"
#import "ReachabilityManager.h"
#import "NetworkManagerReachability.h"
#import "PreferencesManager.h"
#import "UIAlertViewManager.h"
#import "Constants.h"

//dispatch_source_t CreateDispatchTimer(double interval, dispatch_queue_t queue, dispatch_block_t block)
//{
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    if (timer)
//    {
//        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
//        dispatch_source_set_event_handler(timer, block);
//        dispatch_resume(timer);
//    }
//    return timer;
//}

@interface BaseTabBarViewController ()

//@property (nonatomic, strong) dispatch_queue_t queue;

//- (void)startTimer;
//- (void)cancelTimer;

@property (nonatomic, weak) UIViewController *lastSelectedViewController;
@end

@implementation BaseTabBarViewController {
    
//    dispatch_source_t _timer;
}

#pragma mark - Timers

//- (void)startTimer
//{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    double secondsToFire = 1.000f;
//    
//    __weak BaseTabBarViewController *wkself = self;
//    
//    _timer = CreateDispatchTimer(secondsToFire, queue, ^{
//        // Do something
//        
//        [wkself updateUIReachability];
//    });
//}
//
//- (void)cancelTimer
//{
//    if (_timer) {
//        
//        dispatch_source_cancel(_timer);
//        // Remove this if you are on a Deployment Target of iOS6 or OSX 10.8 and above
////        dispatch_release(_timer);
//        _timer = nil;
//    }
//}

#pragma mark - Life Cycle

- (void)setup {
    // Add Observer
    
    __weak id wkself = self;
    
    [[ReachabilityManager class] addReachabilityChangedNotificationObserver:wkself selector:@selector(reachabilityDidChange:)];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)addOfflineLabel {
    
    if (!self.offlineLabel) {
        
        self.offlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.offlineLabel.userInteractionEnabled = NO;
        self.offlineLabel.textAlignment = NSTextAlignmentCenter;
        self.offlineLabel.text = [[LocalizableManager localizedString:@"lbl_title_offline_toast"] capitalizedString];
        self.offlineLabel.backgroundColor = [UIColor blackColor];
        self.offlineLabel.hidden = [[[[ReachabilityManager class] sharedManager] reachability] isReachable];
        self.offlineLabel.textColor = [UIColor whiteColor];
        
        [self.view addSubview:self.offlineLabel];
        
        [[self.view.subviews objectAtIndex:0] bringSubviewToFront:self.offlineLabel];
        
        self.offlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.offlineLabel, @"offlineLabel", nil];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[offlineLabel(==20)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[offlineLabel]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary]];
    }
}

- (void)reachabilityDidChange:(NSNotification *)notification {
    
    Reachability *reachability = (Reachability *)[notification object];
    
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    
//    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWiFi) {
        
        NSLog(@"Reachable via ReachableViaWiFi");
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        
        NSLog(@"Reachable via ReachableViaWWAN");
    }
    else {
        
        NSLog(@"Not Reachable");
    }
    
    __weak BaseTabBarViewController *wkself = self;
    __weak BaseNavigationViewController *nvc = wkself.selectedViewController;
    __weak BaseViewController *vc = (BaseViewController *)nvc.topViewController;
    
    if ([vc isKindOfClass:[BaseViewController class]]) {
        
        [vc dispatchOnMainQueue:^{
            
            wkself.offlineLabel.text = [[LocalizableManager localizedString:@"lbl_title_offline_toast"] capitalizedString];
            wkself.offlineLabel.hidden = reachability.isReachable;
        }];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.selectedIndex = 1;
    [self addOfflineLabel];
    
    __weak BaseTabBarViewController *wkself = self;
    
    wkself.delegate = wkself;
//    [wkself startTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
//    [self cancelTimer];
    
    __weak BaseTabBarViewController *wkself = self;
    
    [[ReachabilityManager class] removeReachabilityChangedNotificationObserver:wkself];
    
    wkself.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     __weak BaseTabBarViewController *wkself = self;
    
    [wkself.navigationController setNavigationBarHidden:YES];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[BaseTabBarViewController class] requestNotificationUnReadWithCompletion:^(NSString *data, NSError *error) {
        
        [[BaseTabBarViewController class] successRequestWithTabBar:[wkself.tabBar.items objectAtIndex:0] data:data error:error];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setupLabels];
}

- (void)setupLabels {
    
    UITabBarItem *tab1 = [self.tabBarController.tabBar.items objectAtIndex:0];
    tab1.title = [[LocalizableManager localizedString:@"tab_noti_label"] capitalizedString];
    
    UITabBarItem *tab2 = [self.tabBarController.tabBar.items objectAtIndex:1];
    tab2.title = [[LocalizableManager localizedString:@"tab_menu_label"] capitalizedString];
    
    UITabBarItem *tab3 = [self.tabBarController.tabBar.items objectAtIndex:2];
    tab3.title = [[LocalizableManager localizedString:@"tab_offline_label"] capitalizedString];

    UITabBarItem *tab4 = [self.tabBarController.tabBar.items objectAtIndex:3];
    tab4.title = [[LocalizableManager localizedString:@"tab_myprofile_label"] capitalizedString];
    
    UITabBarItem *tab5 = [self.tabBarController.tabBar.items objectAtIndex:4];
    tab5.title = [[LocalizableManager localizedString:@"tab_contacts_label"] capitalizedString];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    UIInterfaceOrientationMask supportedInterfaceOrientations = [self.selectedViewController supportedInterfaceOrientations];
    
    return supportedInterfaceOrientations;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    self.lastSelectedViewController = tabBarController.selectedViewController;
    
    return (self.lastSelectedViewController != viewController);
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (self.lastSelectedViewController != viewController) {
     
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            
            __weak UINavigationController *nvc = (UINavigationController *)viewController;
            
            if (nvc.viewControllers.count > 1) {
                
                [nvc popToRootViewControllerAnimated:NO];
            }
        }
    }
}

#pragma mark - Network

+ (void)requestNotificationUnReadWithCompletion:(void (^)(NSString *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamNotiUnread_ididioma,
                                  [country uppercaseString], kUrlPathParamNotiUnread_idpais,
                                  userId, kUrlPathParamNotiUnread_idusuario,
                                  nil];
    
    [NetworkManagerReachability getNotificationsUnReadWithPostDict:postDataDict completion:^(NSString *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getNotificationsUnReadWithPostDict:postDataDict completion:^(NSString *data , NSError *error) {
                            
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


+ (void)successRequestWithTabBar:(UITabBarItem *)tabBarItem data:(NSString *)data error:(NSError *)error {
    
    if (error) {
        
        if (error.code == kCFURLErrorUserCancelledAuthentication) {
            
        }
        else if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            if (![data isEqualToString:@"0"]) {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [tabBarItem setBadgeValue:data];
                });
            }
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

@end
