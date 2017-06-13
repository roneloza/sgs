//
//  AppDelegate.m
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "PreferencesManager.h"
#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "ReachabilityManager.h"
#import "DataBaseManagerSqlite.h"
#import "DetailInfoItem.h"
#import "FileManager.h"

@interface AppDelegate ()

@property (nonatomic, weak) UIViewController *rootViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (![PreferencesManager existPreferencesForKey:kPrefUserUseMobileData]) {
     
        [PreferencesManager setPreferencesBOOL:YES forKey:kPrefUserUseMobileData];
    }
    
    if (![PreferencesManager existPreferencesForKey:kPrefUserUseAttachWifi]) {
        
        [PreferencesManager setPreferencesBOOL:YES forKey:kPrefUserUseAttachWifi];
    }
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    BOOL acceptTerms = [PreferencesManager getPreferencesBOOLForKey:kPrefsKeyUserTermnAccept];
    BOOL logged = [PreferencesManager getPreferencesBOOLForKey:kPrefUserLoged];
    
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    
    if (lang.length > 0 && (country.length <= 0)) {
        
        BaseNavigationViewController *navVC = (BaseNavigationViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeNavVC);
        
        UIViewController *cvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierCountryVC);
        UIViewController *fvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierFirstVC);
        
        NSArray *controllers = [[NSArray alloc] initWithObjects:fvc, cvc, nil];
        
        navVC.viewControllers = controllers;
        
        appDelegate.window.rootViewController = navVC;
    }
    else if (lang.length > 0 && country.length > 0 && !logged) {
        
        BaseNavigationViewController *navVC = (BaseNavigationViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeNavVC);
        
        UIViewController *signInVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierSigninVC);
        UIViewController *cvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierCountryVC);
        UIViewController *fvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierFirstVC);
        
        NSArray *controllers = [[NSArray alloc] initWithObjects:fvc, cvc, signInVC, nil];
        
        navVC.viewControllers = controllers;
        
        appDelegate.window.rootViewController = navVC;
    }
    else if (lang.length > 0 && country.length > 0 && logged && !acceptTerms) {
       
        BaseNavigationViewController *navVC = (BaseNavigationViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeNavVC);
        
        UIViewController *termsVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierTermsVC);
        UIViewController *signInVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierSigninVC);
        UIViewController *cvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierCountryVC);
        UIViewController *fvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierFirstVC);
        
        NSArray *controllers = [[NSArray alloc] initWithObjects:fvc, cvc, signInVC, termsVC, nil];
        
        navVC.viewControllers = controllers;
        
        appDelegate.window.rootViewController = navVC;
    }
    else if (lang.length > 0 && country.length > 0 && logged && acceptTerms) {
        
        BaseTabBarViewController *tabBarVC = (BaseTabBarViewController *)UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain,kStoryboardIdentifierHomeTabBarVC);
        
        appDelegate.window.rootViewController = tabBarVC;
    }
    
    [appDelegate.window makeKeyAndVisible];
    
    self.rootViewController = appDelegate.window.rootViewController;
    
    [[ReachabilityManager class] sharedManager];
    
    [DataBaseManagerSqlite createDataBase];
    
//    [DataBaseManagerSqlite createSchemeTableFromClassName:NSStringFromClass([DetailInfoItem class]) uniqueFields:[[NSArray alloc] initWithObjects:@"idmenu", @"idmenudetalle", nil]];

    [DataBaseManagerSqlite createSchemeTableFromClassName:NSStringFromClass([DetailInfoItem class]) uniqueFields:nil];
    
    NSURL *urlFile = [[FileManager class] appendPathComponentAtDocumentDirectory:kFolderNameAttachments];
    
    [[FileManager class] cleanupOldFilesAtURL:urlFile maxDirSize:kCacheMaxSize];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [self.rootViewController viewDidDisappear:YES];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self.rootViewController viewDidAppear:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
