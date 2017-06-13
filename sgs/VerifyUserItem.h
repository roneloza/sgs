//
//  VerifyUserItem.h
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "clave": null,
 "result": "0",
 "mensaje": "",
 "htmldetalle": ""
 "boolaceptacion": true
 }
 */
@interface VerifyUserItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *clave;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *mensaje;
@property (nonatomic, strong) NSString *htmldetalle;

@property (nonatomic, strong) NSNumber *boolaceptacion;
@end
