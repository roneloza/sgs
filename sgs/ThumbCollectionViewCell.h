//
//  ThumbCollectionViewCell.h
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *thumbNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;
@end
