//
//  SwitchTableViewCell.h
//  sgs
//
//  Created by Rone Loza on 5/10/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
