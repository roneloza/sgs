//
//  NotificationDetailItem.h
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
 "idnotificacion": "NOTSGS201700001",
 "icononotificacion": null,
 "titulo": "Notificación de Embarques",
 "subtitulo1": "Embarques del mes de Enero",
 "subtitulo2": "Estado: Aperturado",
 "fecha": "2015-01-01T00:00:00",
 "booladjunto": false,
 "boolimportante": true,
 "iconooffline": null,
 "nombremenu": "Embarques",
 "descripcionoffline": "Embarque para offline",
 "htmldetalle": "<div>Hola, Como estas</div><div><strong>Detalles:</strong></div>"
 }
 */
@interface NotificationDetailItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *idnotificacion;
@property (nonatomic, strong) NSString *titulo;
@property (nonatomic, strong) NSString *subtitulo1;
@property (nonatomic, strong) NSString *subtitulo2;
@property (nonatomic, strong) NSString *fecha;
@property (nonatomic, strong) NSNumber *booladjunto;
@property (nonatomic, strong) NSNumber *boolimportante;
@property (nonatomic, strong) NSString *icononotificacion;
@property (nonatomic, strong) NSString *iconooffline;
@property (nonatomic, strong) NSString *nombremenu;
@property (nonatomic, strong) NSString *descripcionoffline;
@property (nonatomic, strong) NSString *htmldetalle;
@end
