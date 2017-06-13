//
//  AttachItem.h
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "idpais": null,
 "ididioma": null,
 "idusuario": null,
 "idmenu": "M2017SGS00001",
 "idmenudetalle": "MD2017SGS00001",
 "idadjunto": "MDA2017SGS00001",
 "nombregrupo": "Embarque",
 "tipoadjunto": "PDF",
 "nombreadjunto": "Caracteristicas_barco.pdf",
 "boolseguridad": true,
 "imgadjunto": null,
 "archivoadjunto": null
 }
 */
@interface AttachItem : Item

@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idusuario;
@property (nonatomic, strong) NSString *idmenu;
@property (nonatomic, strong) NSString *idmenudetalle;
@property (nonatomic, strong) NSString *idadjunto;
@property (nonatomic, strong) NSString *nombregrupo;
@property (nonatomic, strong) NSString *tipoadjunto;
@property (nonatomic, strong) NSString *nombreadjunto;
@property (nonatomic, strong) NSNumber *boolseguridad;
@property (nonatomic, strong) NSString *imgadjunto;
@property (nonatomic, strong) NSString *archivoadjunto;

@property (nonatomic, strong) NSData *fileContent;

@end
