//
//  ColumnsTitleView.m
//  sgs
//
//  Created by Rone Loza on 5/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ColumnsTitleView.h"

@implementation ColumnsTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup {
    
    ColumnsTitleView *nestedTutorialView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                                              owner:self
                                                                            options:nil] objectAtIndex:0];
    
    [self addSubview:nestedTutorialView];
}

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
}

@end
