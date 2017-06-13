//
//  MenuDetailTableViewCell.h
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *iconImageContentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *rowLabel;
@property (weak, nonatomic) IBOutlet UIView *labelContentView;
@property (weak, nonatomic) IBOutlet UIView *separatorContentView;
@property (weak, nonatomic) IBOutlet UIImageView *alertImageView;
@property (weak, nonatomic) IBOutlet UIView *rowContentView;
@end
