//
//  SocialTableViewCell.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *disclosureButton;
@end
