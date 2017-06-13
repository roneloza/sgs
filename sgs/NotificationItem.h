//
//  NotificationItem.h
//  sgs
//
//  Created by rone loza on 6/1/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "valorbusqueda": null,
 "pagina": 0,
 "idnotificacion": "NOTSGS201700001",
 "icononaranja": null,
 "iconogris": null,
 "titulo": "Notificación de Embarques",
 "subtitulo1": "Embarques del mes de Enero",
 "subtitulo2": "Estado: Aperturado",
 "fecha": "2015-01-01T00:00:00",
 "booladjunto": false,
 "boolimportante": true,
 "boollectura": false,
 "result": "",
 "mensaje": ""
 }
 */
@interface NotificationItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *valorbusqueda;
@property (nonatomic, strong) NSNumber *pagina;
@property (nonatomic, strong) NSString *idnotificacion;
@property (nonatomic, strong) NSString *icononaranja;
@property (nonatomic, strong) NSString *iconogris;
@property (nonatomic, strong) NSString *titulo;
@property (nonatomic, strong) NSString *subtitulo1;
@property (nonatomic, strong) NSString *subtitulo2;
@property (nonatomic, strong) NSString *fecha;
@property (nonatomic, strong) NSNumber *booladjunto;
@property (nonatomic, strong) NSNumber *boolimportante;
@property (nonatomic, strong) NSNumber *boollectura;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *mensaje;

@end
