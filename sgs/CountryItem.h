//
//  CountryItem.h
//  sgs
//
//  Created by Rone Loza on 4/26/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "Item.h"

/*
 
 {
 "ididioma": null,
 "idpais": "AF",
 "nombrepais": "Afganistán",
 "iconopais": "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAACiElEQVRIx9WWy2oUQRSGv+7qmcwlcSZRghqEqIkgIehSA4oMcZEX8AXyHi58Bre68AVEEdSdICJINmJmaYwTQpQE093TnenuurnITG7dzipZeKCgqDp1/nP+6vpPO9ZaztJcztjOHMABPKAClE45tgQSDxhdXFzcFUIUej2jNjTK8qOpf+69X3467gF113VptVqFTjXKQwFaMxOF6x/WVgDqHuAppUjTFN/3sX3e9s2iqAymRzcO1n53bX9qDzhvVMfQ2gB4HoDWmjiOieM4l4nFDK0glklurSRKKKOhf8FIKYmiiCiKcs4GBQLc0QZuff8+bJKg/2wDHlE6ljvjuQKt1SGAUoput0sYhgUACd7lKfTODo6YxOzF2F5GafoaWbtNmJ7LnRGuQJoTAGEYHgAcpVtcvUntwX2iV28o35iFkkf89h0jt+fRQUCYdPMAjoNS+jiA7/sEQZDnc+Y6cmOT2tJDMBZx4Twjc3PI9XW8qUsE6Vb+cTkO2dEKpJR0Oh1838/fotaI8QbZ11XKt+axvQS1sUl1dga5/pOO/JU7ElZiqk75ECDLMpRSaK1zztlqm9L1aUyaItd+4AgPd2IC0WzQ/fwFvZD/ypTVZEYeatEguDEmN3ofP4GF6sIdRLOJmGhSvXeX7Ps66coKxprc0FajtDxO0SBgjqFuwM7jJ4wuLSEuTmL3eqTf2kQvX2PSFFMg98oYHG0PAQbZF1EELnprm+D5i0Kt1AVJGWOQyh6vYLBBwUsYZsYWVG00Zl8q+hUojStc6vV6Qf7D1bRerhTIiz32kqVUEkc7hQF2SU60jyNKB2RRMrQnOEADuAI0T7nh+MDGoKONDOg6RVNA6vz3fxV/AcTHY7yuagkxAAAAAElFTkSuQmCC",
 "dominioservicio": "http://200.60.69.51/"
 }
 
 */
@interface CountryItem : Item

@property (nonatomic, strong) NSString *ididioma;
@property (nonatomic, strong) NSString *idpais;
@property (nonatomic, strong) NSString *nombrepais;
@property (nonatomic, strong) NSString *iconopais;
@property (nonatomic, strong) NSString *dominioservicio;

@end
