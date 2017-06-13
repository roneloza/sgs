//
//  DetailMenuViewController.h
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@class MenuItem;

@interface MenuDetailViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) MenuItem *item;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSegmented;

- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender;

//+ (NSString *)adjustPadTextInLabel:(UILabel *)label cols:(NSArray *)cols;
+ (void)generateLabelFromView:(UIView *)view cols:(NSArray *)cols font:(UIFont *)font textColor:(UIColor *)textColor;

@end
