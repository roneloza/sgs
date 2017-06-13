//
//  ColsTableViewController.h
//  sgs
//
//  Created by Rone Loza on 5/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface ColsTableViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;

/**
 *@breif NSArray of Item *
 **/
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) BOOL refreshParent;

/**
 *@brief NSArray of Item *
 **/
@property (nonatomic, strong) NSMutableArray *noCheckmarks;

- (void)updateSelectedColumns;

@property (nonatomic, strong) NSString *paramId;
@end
