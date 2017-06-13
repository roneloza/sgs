//
//  ArrowRightButton.m
//  sgs
//
//  Created by Rone Loza on 5/4/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "RightIconButton.h"

@implementation RightIconButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
}


- (void)setup {
    
    CGRect rect = self.bounds;
    rect.origin.x = 40;
    rect.size.height = 30.0f;
    rect.size.width = 30.0f;
    
    self.rightIconImageView = [[UIImageView alloc] initWithFrame:rect];
    self.rightIconImageView.userInteractionEnabled = NO;
    
    self.rightIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.rightIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightIconImageView.image = [UIImage imageNamed:@"ic_next"];
    
    [self addSubview:self.rightIconImageView];
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.rightIconImageView, @"rightIconImageView", nil];
    
    
    [self addConstraints:[[NSArray alloc] initWithObjects:[NSLayoutConstraint constraintWithItem:self.rightIconImageView
                                                                                       attribute:NSLayoutAttributeCenterY
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeCenterY
                                                                                      multiplier:1.f constant:0.f], nil]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightIconImageView(==20)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightIconImageView(==20)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightIconImageView]-20-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
}

@end
