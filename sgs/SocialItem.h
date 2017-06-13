//
//  SocialItem.h
//  sgs
//
//  Created by Rone Loza on 5/8/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 "idpais": null,
 "ididioma": null,
 "idredsocial": "01",
 "tiporedsocial": "Whatsapp",
 "iconoredsocial": "",
 "nombreredsocial": "Whatsapp SGS",
 "valor": "+51996651113"
 */
@interface SocialItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idredsocial;
@property (nonatomic, strong) NSString *tiporedsocial;
@property (nonatomic, strong) NSString *iconoredsocial;
@property (nonatomic, strong) NSString *nombreredsocial;
@property (nonatomic, strong) NSString *valor;

@end
