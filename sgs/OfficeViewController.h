//
//  OfficeViewController.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface OfficeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 @brief NSArray * of Item
 **/
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) BOOL isOfficeRequest;

@end
