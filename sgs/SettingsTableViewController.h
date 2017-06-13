//
//  SettingsViewController.h
//  sgs
//
//  Created by Rone Loza on 5/5/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsTableViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)switchValueChanged:(UISwitch *)sender;

@end
