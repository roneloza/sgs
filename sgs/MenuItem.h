//
//  MenuItem.h
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/****
 
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "idmenu": "MN0SGS00001",
 "nombremenu": "YouTube",
 "iconoblanco": "",
 "icononaranja": ""
 
 ****/
@interface MenuItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *idmenu;
@property (nonatomic, strong) NSString *nombremenu;
@property (nonatomic, strong) NSString *iconoblanco;
@property (nonatomic, strong) NSString *icononaranja;

@end
