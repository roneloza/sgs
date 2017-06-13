//
//  TabCollectionViewCell.h
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *tabLabel;
@property (weak, nonatomic) IBOutlet UIView *tabIndicatorView;
@end
