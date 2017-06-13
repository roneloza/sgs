
//
//  BaseViewController.m
//  sgs
//
//  Created by Rone Loza on 4/25/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"
#import "Constants.h"
#import "LocalizableManager.h"
#import "BaseTabBarViewController.h"
#import "UINavigationController+Utils.h"
#import "NSData+Utils.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize titleLocalizedString;

- (NSData *)dataFromBase64EncodedString:(NSString *)base64EncodedString; {
    
    return [[NSData class] dataFromBase64EncodedString:base64EncodedString];
}

- (UIInterfaceOrientation)currentInterfaceOrientation {
    
//    self.interfaceOrientation
    return [[UIApplication sharedApplication] statusBarOrientation];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //[super viewDidAppear:animated];
    [super viewWillAppear:animated];
    
    [self setupLabels];
}

- (void)setupLabels {
    
//    if ([self.navigationController.backViewController conformsToProtocol:@protocol(DelegateLocalizedString)]) {
//        
//        UIViewController<DelegateLocalizedString> *del = (UIViewController<DelegateLocalizedString> *)self.navigationController.backViewController;
//        
//        self.navigationController.navigationBar.backItem.title = [[LocalizableManager localizedString:del.titleLocalizedString] capitalizedString];
//    }

    if ([self.navigationController.backViewController isKindOfClass:[BaseViewController class]]) {
        
        __weak BaseViewController *basevc = (BaseViewController *)self.navigationController.backViewController;
        
        self.navigationController.navigationBar.backItem.title = [[LocalizableManager localizedString:basevc.titleLocalizedString] capitalizedString];
    }
    
//    self.navigationController.navigationBar.topItem.title = [LocalizableManager localizedString:self.titleLocalizedString];
    self.title = [LocalizableManager localizedString:self.titleLocalizedString];
    
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

- (void)dispatchOnMainQueue:(void(^)(void))block {
    
    if ([NSThread isMainThread]) {
        
        if (block) block();
    }
    else {
        
        dispatch_async(dispatch_get_main_queue(), (block) ? block : nil);
    }
}

- (IBAction)refreshBarButtonPressed:(id)sender {
    
}

- (void)dealloc {
    
    AppDebugECLog(@"dealloc %@", NSStringFromClass([self class]));
}
@end
