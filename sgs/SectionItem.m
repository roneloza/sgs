//
//  SectionItem.m
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "SectionItem.h"

@implementation SectionItem

- (instancetype)initWithTitle:(NSString *)title selected:(BOOL)selected items:(NSArray *)items; {

    if ((self = [super initWithTitle:title selected:selected])) {
        
        _items = items;
    }
    
    return self;
}

@end
