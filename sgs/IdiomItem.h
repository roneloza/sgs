//
//  IdiomItem.h
//  sgs
//
//  Created by Rone Loza on 4/26/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 [
 {
 "ididioma": "DA",
 "nombreidioma": "Danés"
 },
 {
 "ididioma": "EN",
 "nombreidioma": "Ingles"
 },
 {
 "ididioma": "ES",
 "nombreidioma": "Español"
 },
 {
 "ididioma": "QU",
 "nombreidioma": "Quechua"
 }
 ]
 */

@interface IdiomItem : Item

@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *nombreidioma;

@end
