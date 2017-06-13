//
//  NotificationTableViewController.h
//  sgs
//
//  Created by rone loza on 6/1/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSegmented;
- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender;

+ (NSString *)stringFormattedNotificationDateString:(NSString *)notificationDateString;

@end
