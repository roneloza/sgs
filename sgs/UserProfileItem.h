//
//  UserProfileItem.h
//  sgs
//
//  Created by Rone Loza on 5/16/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "nombreusuario": "Rone Loza Huamán Huamán",
 "nombreempresa": "NOVIT S.A.C.",
 "correo": "Rone Lozahuaman@outlook.com",
 "telefonomovil": "954344780",
 "telefonofijo": "5852324",
 "fotousuario": "",
 "mensajeperfil": "El desapego no quiere decir que no debes poseer nada, el desapego quiere decir que nada te debe poseer a ti."
 }
 */
@interface UserProfileItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *nombreusuario;
@property (nonatomic, strong) NSString *nombreempresa;
@property (nonatomic, strong) NSString *correo;
@property (nonatomic, strong) NSString *telefonomovil;
@property (nonatomic, strong) NSString *telefonofijo;
@property (nonatomic, strong) NSString *fotousuario;
@property (nonatomic, strong) NSString *mensajeperfil;

@end
