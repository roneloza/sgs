//
//  AnimationManager.h
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstViewController;

@interface AnimationManager : NSObject

+ (void)animateLogoView:(__weak FirstViewController *)wkself;
+ (void)animateOpacityWithView:(UIView *)view from:(CGFloat)from to:(CGFloat)to duration:(double)duration completion:(void (^)(BOOL finished))completion;
@end
