//
//  ParamItem.h
//  sgs
//
//  Created by Rone Loza on 5/5/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
/**
 
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "idparametro": "4",
 "idparametrodetalle": "1",
 "nombre": "Acta de Aforo (Escaneados)",
 "boolseleccion": false
 },
 
 **/

@interface ParamItem : Item

@property(nonatomic, strong) NSString *idparametro;
@property(nonatomic, strong) NSString *idparametrodetalle;
@property(nonatomic, strong) NSString *nombre;
@property(nonatomic, strong) NSNumber *boolseleccion;

@end
