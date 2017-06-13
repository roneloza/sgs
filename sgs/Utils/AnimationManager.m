//
//  AnimationManager.m
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "AnimationManager.h"
#import "FirstViewController.h"
#import "CAAnimation+Blocks.h"

@implementation AnimationManager

+ (void)animateLogoView:(__weak FirstViewController *)wkself {
    
    [wkself.logoView.layer removeAllAnimations];
    [wkself.idiomPicker.layer removeAllAnimations];
    [wkself.nextButton.layer removeAllAnimations];
    
    CGPoint from = wkself.logoView.layer.position;
    CGPoint to = wkself.logoView.layer.position;
    to.y = ktopPinConstraint + (wkself.logoView.bounds.size.height / 2);
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:from];
    positionAnimation.toValue = [NSValue valueWithCGPoint:to];
    positionAnimation.duration = 0.5f;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    positionAnimation.removedOnCompletion = YES;
    positionAnimation.fillMode = kCAFillModeForwards;
    
    [positionAnimation setCompletion:^(BOOL finished) {
        
        if (finished) {
            
            CABasicAnimation *alphaAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
            alphaAnimation1.fromValue = [NSNumber numberWithInteger:0.0f];
            alphaAnimation1.toValue = [NSNumber numberWithInteger:1.0f];
            alphaAnimation1.duration = 0.5f;
            alphaAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            alphaAnimation1.removedOnCompletion = YES;
            alphaAnimation1.fillMode = kCAFillModeForwards;
            
            [wkself.idiomPicker.layer addAnimation:alphaAnimation1 forKey:@"opacity"];
            [wkself.idiomPicker.layer setOpacity:1.0f];
            
            CABasicAnimation *alphaAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
            alphaAnimation2.fromValue = [NSNumber numberWithInteger:0.0f];
            alphaAnimation2.toValue = [NSNumber numberWithInteger:1.0f];
            alphaAnimation2.duration = 0.5f;
            alphaAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            alphaAnimation2.removedOnCompletion = YES;
            alphaAnimation2.fillMode = kCAFillModeForwards;
            
            [wkself.nextButton.layer addAnimation:alphaAnimation2 forKey:@"opacity"];
            [wkself.nextButton.layer setOpacity:1.0f];
            
            wkself.topPinConstraint.constant = ktopPinConstraint;
        }
    }];
    
    [wkself.logoView.layer addAnimation:positionAnimation forKey:@"position"];
    [wkself.logoView.layer setPosition:to];
    
}

+ (void)animateOpacityWithView:(UIView *)view from:(CGFloat)from to:(CGFloat)to duration:(double)duration completion:(void (^)(BOOL finished))completion {
    
    [view.layer setOpacity:from];
    
    [view.layer removeAllAnimations];
    
    CABasicAnimation *alphaAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation1.fromValue = [NSNumber numberWithDouble:from];
    alphaAnimation1.toValue = [NSNumber numberWithDouble:to];
    alphaAnimation1.duration = duration;
    alphaAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphaAnimation1.removedOnCompletion = YES;
    alphaAnimation1.fillMode = kCAFillModeForwards;
    
    if (completion)
        [alphaAnimation1 setCompletion:completion];
    
    [view.layer addAnimation:alphaAnimation1 forKey:@"opacity"];
    [view.layer setOpacity:to];
}

@end
