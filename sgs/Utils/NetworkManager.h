//
//  NetworkManager.h
//  statslite
//
//  Created by Rone Loza on 7/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VerifyUserItem;
@class DetailInfoItem;
@class UserProfileItem;
@class AttachItem;
@class NotificationItem;
@class NotificationDetailItem;
@class NotificationAttachItem;

@interface NetworkManager : NSObject

+ (void)getTokenWithCompletion:(void(^)(NSString *newToken, NSError *error))completion;
+ (void)getIdiomsWithCompletion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)getCountriesWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;

+ (void)validateUserNameWithPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion;
+ (void)validateUserPassWithPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion;

+ (void)getListTermsPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion;
+ (void)acceptTermsPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion;

+ (void)getMenuWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)getMenuDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)getSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)postUpdateSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSInteger responseCodeData, NSError *error))completion;

+ (void)getSocialWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)getOfficesWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;
+ (void)getMenuDetailInfoWithPostDict:(NSDictionary *)postDict completion:(void(^)(DetailInfoItem *item, NSError *error))completion;
+ (void)getUserProfileWithPostDict:(NSDictionary *)postDict completion:(void(^)(UserProfileItem *item, NSError *error))completion;
+ (void)getAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;

+ (void)getAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(AttachItem *data, NSError *error))completion;

+ (void)getDirectoryWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;

+ (void)getNotificationsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;

+ (void)getNotificationsUnReadWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSString *data, NSError *error))completion;

+ (void)postNotificationUpdateWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationItem *data, NSError *error))completion;

+ (void)getNotificationDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationDetailItem *data, NSError *error))completion;

+ (void)getNotificationAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion;

+ (void)getNotificationAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationAttachItem *data, NSError *error))completion;
@end
