//
//  DetailTableViewController.h
//  sgs
//
//  Created by rone loza on 5/30/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailTableViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBarButton;
- (IBAction)deleteBarButtonPressed:(UIBarButtonItem *)sender;
@end
