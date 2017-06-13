//
//  CAAnimation+Blocks.h
//  NewsReport
//
//  Created by RLoza on 3/31/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Blocks)

@property (nonatomic, copy) void (^completion)(BOOL finished);
@property (nonatomic, copy) void (^start)(void);

- (void)setCompletion:(void (^)(BOOL finished))completion; // Forces auto-complete of setCompletion: to add the name 'finished' in the block parameter

+ (void)performPositionAnimationView:(__weak UIView *)view fromPosition:(CGPoint)from toPosition:(CGPoint)to duration:(CFTimeInterval)duration completion:(void (^)(void))completion;

+ (CABasicAnimation *)positionAnimationView:(__weak UIView *)view fromPosition:(CGPoint)from toPosition:(CGPoint)to duration:(CFTimeInterval)duration completion:(void (^)(void))completion;

@end
