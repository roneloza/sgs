//
//  SectionItem.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

@interface SectionItem : Item

/**
 *@brief NSArray of *Item
 **/
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithTitle:(NSString *)title selected:(BOOL)selected items:(NSArray *)items;
@end
