//
//  ECTabBarViewController.h
//  sgs
//
//  Created by Rone Loza on 4/25/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController<UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *offlineLabel;

+ (void)requestNotificationUnReadWithCompletion:(void (^)(NSString *data , NSError *error))completion;

+ (void)successRequestWithTabBar:(UITabBarItem *)tabBarItem data:(NSString *)data error:(NSError *)error;

@end
