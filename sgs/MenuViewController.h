//
//  MenuViewController.h
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuViewController : BaseViewController

@property (nonatomic, strong) NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
