//
//  CAAnimation+Blocks.m
//  NewsReport
//
//  Created by RLoza on 3/31/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "CAAnimation+Blocks.h"

@interface CAAnimationDelegate : NSObject<CAAnimationDelegate>

@property (nonatomic, copy) void (^completion)(BOOL);
@property (nonatomic, copy) void (^start)(void);

- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

@implementation CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.start != nil) {
        self.start();
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion != nil) {
        self.completion(flag);
    }
}

@end

@implementation CAAnimation (Blocks)

- (void)setCompletion:(void (^)(BOOL))completion
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).completion = completion;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.completion = completion;
        self.delegate = delegate;
    }
}

- (void (^)(BOOL))completion
{
    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).completion: nil;
}

- (void)setStart:(void (^)(void))start
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).start = start;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.start = start;
        self.delegate = delegate;
    }
}

- (void (^)(void))start
{
    return [self.delegate isKindOfClass:[CAAnimationDelegate class]]? ((CAAnimationDelegate *)self.delegate).start: nil;
}

+ (void)performPositionAnimationView:(__weak UIView *)view fromPosition:(CGPoint)from toPosition:(CGPoint)to duration:(CFTimeInterval)duration completion:(void (^)(void))completion   {
    
    [view.layer removeAllAnimations];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:from];
    positionAnimation.toValue = [NSValue valueWithCGPoint:to];
    positionAnimation.duration = duration;
    positionAnimation.removedOnCompletion = YES;
    positionAnimation.fillMode = kCAFillModeForwards;
    [positionAnimation setCompletion:^(BOOL finished) {
        
        if (finished) {
            
            if (completion) completion();
        }
    }];
    
    [view.layer addAnimation:positionAnimation forKey:@"position"];
    [view.layer setPosition:to];
}

+ (CABasicAnimation *)positionAnimationView:(__weak UIView *)view fromPosition:(CGPoint)from toPosition:(CGPoint)to duration:(CFTimeInterval)duration completion:(void (^)(void))completion   {
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:from];
    positionAnimation.toValue = [NSValue valueWithCGPoint:to];
    positionAnimation.duration = duration;
    positionAnimation.removedOnCompletion = YES;
    positionAnimation.fillMode = kCAFillModeForwards;
    [positionAnimation setCompletion:^(BOOL finished) {
        
        if (finished) {
            
            if (completion) completion();
        }
    }];
    
    [view.layer addAnimation:positionAnimation forKey:@"position"];
    [view.layer setPosition:to];
    
    return positionAnimation;
}

+ (void)rotateView:(UIView *__weak)view degrees:(float)degrees animation:(BOOL)animation {
    
    if (animation) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            view.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
            //[self.arrow setNeedsDisplay];//ios 4
        } completion:NULL];
    }
    else {
        
        view.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    }
}

@end
