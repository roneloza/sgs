//
//  TabCollectionViewCell.m
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "TabCollectionViewCell.h"
#import "Constants.h"

@implementation TabCollectionViewCell

- (void)setSelected:(BOOL)selected {
    
    self.tabIndicatorView.backgroundColor = selected ? UIColorFromHex(kColorSGS, 1.0f) : UIColorFromHex(kColorWhiteOdd, 1.0f);
    self.tabLabel.textColor = selected ? UIColorFromHex(kColorSGS, 1.0f) : [UIColor darkGrayColor];
}

@end
