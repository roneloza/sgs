//
//  TitlePickerViewRow.m
//  sgs
//
//  Created by Rone Loza on 4/25/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "TitlePickerViewRow.h"

@implementation TitlePickerViewRow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup {
    
    TitlePickerViewRow *nestedTutorialView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                                              owner:self
                                                                            options:nil] objectAtIndex:0];
    
    nestedTutorialView.frame = self.frame;
    
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
