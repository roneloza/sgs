//
//  ShareManager.h
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSchemeGoogleMaps @"comgooglemaps://"
#define kSchemeGoogleMapsParam_center @"center"
#define kSchemeGoogleMapsParam_zoom @"zoom"
#define kSchemeGoogleMapsParam_mapmode @"mapmode"
#define kSchemeGoogleMapsParam_mapmode_standard @"standard"
#define kSchemeGoogleMapsParam_mapmode_streetview @"streetview"

//[NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", toEmail,subject,body]
#define kSchemeMail @"mailto://"
#define kSchemeMailParam_subject @"subject"
#define kSchemeMailParam_body @"body"

#define kSchemeTel @"tel://"

//NSURL *whatsappURL = [NSURL URLWithString:@"whatsapp://send?abid=Miguel&amp;text=Hola!"];

#define kSchemeWhatsApp @"whatsapp://send"
#define kSchemeWhatsAppParam_abid @"abid"
#define kSchemeWhatsAppParam_text @"text"

//fb://publish/profile/#ID#?text=#BODY#
#define kSchemeFacebook @"fb://"
#define kSchemeFacebookParam_text @"text"
#define kSchemeFacebookPathPublishProfile @"publish/profile/"

@class SocialItem;
@class AttachItem, NotificationAttachItem;

@interface ShareManager : NSObject

+ (void)openURLWithScheme:(NSString *)scheme parameters:(NSDictionary *)params;
+ (void)openURLWithScheme:(NSString *)scheme path:(NSString *)path parameters:(NSDictionary *)params;
+ (void)openURLWithItem:(SocialItem *)item;

+ (void)requestWithAttach:(AttachItem *)item completion:(void(^)(AttachItem *data, NSError *error))completion;
+ (void)requestWithNotificationAttach:(NotificationAttachItem *)item completion:(void(^)(NotificationAttachItem *data, NSError *error))completion;

+ (void)shareUrlFile:(NSURL *)urlFile inViewController:(__weak UIViewController *)viewController barButtonItem:(UIBarButtonItem *)barButtonItem completion:(void (^)(void))completion;

//+ (void)shareImage:(__weak  UIImage *)image inViewController:(__weak UIViewController *)viewController completion:(void (^)(void))completion;

@end
