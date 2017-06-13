//
//  MenuDetailItem.h
//  sgs
//
//  Created by Rone Loza on 4/28/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/******
 
 {
 "idpais": null,
 "ididioma": null,
 "valorbusqueda": null,
 "pagina": 0,
 "idusuario": null,
 "idmenu": "",
 "idmenudetalle": "",
 "booladjunto": false,
 "boolimportante": false,
 "columna01": " Codigo",
 "columna02": "Equipo",
 "columna03": "Herramienta",
 "columna04": "Automovil",
 "columna05": "Ciudad",
 "columna06": "Nombre",
 "columna07": "Plomero",
 "columna08": "Oficina",
 "columna09": "Jugueria",
 "columna10": "Sucursal",
 "columna11": "Tonelada",
 "columna12": "Equipo",
 "columna13": "Tamaño",
 "columna14": "Color",
 "columna15": "Camara",
 "columna16": "Empresa",
 "columna17": "Lugar",
 "columna18": "Tipo",
 "columna19": "Dirección",
 "columna20": "Marca",
 "result": "",
 "mensaje": ""
 }
 
 ******/

@interface MenuDetailItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *valorbusqueda;
@property (nonatomic, strong) NSNumber *pagina;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *idmenu;
@property (nonatomic, strong) NSString *idmenudetalle;
@property (nonatomic, strong) NSNumber *booladjunto;
@property (nonatomic, strong) NSNumber *boolimportante;

@property (nonatomic, strong) NSString *columna01;
@property (nonatomic, strong) NSString *columna02;
@property (nonatomic, strong) NSString *columna03;
@property (nonatomic, strong) NSString *columna04;
@property (nonatomic, strong) NSString *columna05;
@property (nonatomic, strong) NSString *columna06;
@property (nonatomic, strong) NSString *columna07;
@property (nonatomic, strong) NSString *columna08;
@property (nonatomic, strong) NSString *columna09;
@property (nonatomic, strong) NSString *columna10;
@property (nonatomic, strong) NSString *columna11;
@property (nonatomic, strong) NSString *columna12;
@property (nonatomic, strong) NSString *columna13;
@property (nonatomic, strong) NSString *columna14;
@property (nonatomic, strong) NSString *columna15;
@property (nonatomic, strong) NSString *columna16;
@property (nonatomic, strong) NSString *columna17;
@property (nonatomic, strong) NSString *columna18;
@property (nonatomic, strong) NSString *columna19;
@property (nonatomic, strong) NSString *columna20;

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *mensaje;


/**
 *@brief MSArray of Item *
 **/
@property (nonatomic, strong) NSMutableArray *columns;

//- (id)copyWithZone:(NSZone *)zone;

@end
