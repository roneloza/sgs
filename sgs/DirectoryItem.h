//
//  DirectoryItem.h
//  sgs
//
//  Created by rone loza on 5/31/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "ididioma": null,
 "idpais": null,
 "nombrepersona": "Daniel Alberto Canario Suarez",
 "fotopersona": "",
 "nombresector": "Agrícola",
 "cargo": "Gerente de Cuentas",
 "correo": "daniboy@outlook.com",
 "telefonomovil": "955963156",
 "telefonofijo": "5852324",
 "anexo": "152/852",
 "whatsapp": "955963156"
 }
 */

@interface DirectoryItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *nombrepersona;
@property (nonatomic, strong) NSString *fotopersona;
@property (nonatomic, strong) NSString *nombresector;
@property (nonatomic, strong) NSString *cargo;
@property (nonatomic, strong) NSString *correo;
@property (nonatomic, strong) NSString *telefonomovil;
@property (nonatomic, strong) NSString *telefonofijo;
@property (nonatomic, strong) NSNumber *anexo;
@property (nonatomic, strong) NSString *whatsapp;

@end
