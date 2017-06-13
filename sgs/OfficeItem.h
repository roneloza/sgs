//
//  OfficeItem.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 {
 "ididioma": null,
 "idpais": null,
 "idoficina": "01",
 "imgoficina": "[string-base64]",
 "nombresede": "Central",
 "direccionsede": "Av. Elmer Faucett 3348, Callao",
 "ciudadsede": "Lima",
 "telefonosede": "+515171900",
 "anexosede": "",
 "correosede": "pe.servicio@sgs.com",
 "latitud": "-12.0185595",
 "longitud": "-77.1084019",
 "contactosede": "Ricardo Benitez Díaz"
 }
 */

@interface OfficeItem : Item

@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *idoficina;
@property (nonatomic, strong) NSString *imgoficina;
@property (nonatomic, strong) NSString *nombresede;
@property (nonatomic, strong) NSString *direccionsede;
@property (nonatomic, strong) NSString *ciudadsede;
@property (nonatomic, strong) NSString *telefonosede;
@property (nonatomic, strong) NSString *anexosede;
@property (nonatomic, strong) NSString *correosede;
@property (nonatomic, strong) NSString *latitud;
@property (nonatomic, strong) NSString *longitud;
@property (nonatomic, strong) NSString *contactosede;

@end
