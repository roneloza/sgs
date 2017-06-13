//
//  WebViewController.h
//  Pods
//
//  Created by rone loza on 5/31/17.
//
//

#import "BaseViewController.h"

@class NotificationDetailItem;

@interface WebViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *htmlBody;

+ (void)requestNotificationDetailWithNotificationId:(NSString *)notificationId completion:(void (^)(NotificationDetailItem *data , NSError *error))completion;
@end
