//
//  DetailInfoItem.h
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "idmenu": "M2017SGS00001",
 "idmenudetalle": "MD2017SGS00005",
 "iconooffline": null,
 "nombremenu": "Facturación",
 "descripcionoffline": "Facturación del mes de junio para Perú",
 "htmldetalle": "<div class=\"sgs\">HTML de prueba para el detalle de un registro de Menú</div>"
 }
 */
@interface DetailInfoItem : Item

@property(nonatomic, strong) NSString *idpais;
@property(nonatomic, strong) NSString *ididioma;
@property(nonatomic, strong) NSString *idusuario;
@property(nonatomic, strong) NSString *idmenu;
@property(nonatomic, strong) NSString *idmenudetalle;
@property(nonatomic, strong) NSString *iconooffline;
@property(nonatomic, strong) NSString *nombremenu;
@property(nonatomic, strong) NSString *descripcionoffline;
@property(nonatomic, strong) NSString *htmldetalle;

@property (nonatomic, strong) NSString *rowid;

@end
