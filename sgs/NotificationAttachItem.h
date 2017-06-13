//
//  NotificationAttachItem.h
//  sgs
//
//  Created by rone loza on 6/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "idnotificacion": "NOTSGS201700001",
 "idadjunto": "NOTA2017SGS001",
 "tipoadjunto": "TXT",
 "nombregrupo": "Embarques",
 "nombreadjunto": "Documento.txt",
 "boolseguridad": false,
 "imgadjunto": null,
 "archivoadjunto": null
 }
 
 */

@interface NotificationAttachItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *idnotificacion;
@property (nonatomic, strong) NSString *idadjunto;
@property (nonatomic, strong) NSString *tipoadjunto;
@property (nonatomic, strong) NSString *nombregrupo;
@property (nonatomic, strong) NSString *nombreadjunto;
@property (nonatomic, strong) NSNumber *boolseguridad;
@property (nonatomic, strong) NSString *imgadjunto;
@property (nonatomic, strong) NSString *archivoadjunto;

@property (nonatomic, strong) NSData *fileContent;
@end
