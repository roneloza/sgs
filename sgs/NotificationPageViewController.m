//
//  NotificationPageViewController.m
//  sgs
//
//  Created by rone loza on 6/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "NotificationPageViewController.h"
#import "NotificationItem.h"
#import "PreferencesManager.h"
#import "Constants.h"
#import "NetworkManagerReachability.h"
#import "UIAlertViewManager.h"
#import "NotificationDetailItem.h"
#import "LocalizableManager.h"
#import "NotificationTableViewController.h"

@interface NotificationPageViewController ()

@end

@implementation NotificationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak NotificationPageViewController *wkself = self;
    
    if ([wkself.model isKindOfClass:[NotificationItem class]]) {
        
        __weak NotificationItem *notificationItem = (NotificationItem *)wkself.model;
        
        NSString *dateString = [[NotificationTableViewController class] stringFormattedNotificationDateString:notificationItem.fecha];
        
        wkself.dateLabel.text = dateString;
        
        wkself.iconImageView.image = ([notificationItem.boollectura boolValue] ?
                                      (notificationItem.iconogris.length > 0 ?
                                       [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:notificationItem.iconogris]] :
                                       [UIImage imageNamed:@"ic_notification_read"]) :
                                      (notificationItem.icononaranja.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:notificationItem.icononaranja]] : [UIImage imageNamed:@"ic_notification_unread"]));
        
        wkself.alertImageView.image = [notificationItem.boolimportante boolValue] ? [UIImage imageNamed:@"ic_alert"] : nil;
        
        wkself.titlelabel1.text = notificationItem.titulo;
        wkself.titleLabel2.text = notificationItem.subtitulo1;
        wkself.titleLabel3.text = notificationItem.subtitulo2;
        
        [UIAlertViewManager progressHUDDismissWithCompletion:nil];
    }
    
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

@end
