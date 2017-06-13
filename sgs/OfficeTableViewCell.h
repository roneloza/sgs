//
//  OfficeTableViewCell.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
//@property (weak, nonatomic) IBOutlet UIButton *mapButton;
//@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
//@property (weak, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@end
