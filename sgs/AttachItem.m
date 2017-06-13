//
//  AttachItem.m
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "AttachItem.h"
#import "LocalizableManager.h"

@implementation AttachItem

- (void)setTipoadjunto:(NSString *)tipoadjunto {

    NSString *type = (([tipoadjunto caseInsensitiveCompare:@"png"] == NSOrderedSame ||
                       [tipoadjunto caseInsensitiveCompare:@"jpg"] == NSOrderedSame ||
                       [tipoadjunto caseInsensitiveCompare:@"jpge"] == NSOrderedSame ) ? [[LocalizableManager localizedString:@"lbl_image"] capitalizedString]: tipoadjunto);
    
    _tipoadjunto = type;
    
}

@end
