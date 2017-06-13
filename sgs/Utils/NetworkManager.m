//
//  NetworkManager.m
//  statslite
//
//  Created by Rone Loza on 7/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import "NetworkManager.h"
#import "NSString+Utils.h"
#import "JSONParserManager.h"
#import "Constants.h"
#import "NSString+Utils.h"
#import "PreferencesManager.h"
#import <Network/Network.h>

@implementation NetworkManager

+ (void)getTokenWithCompletion:(void(^)(NSString *newToken, NSError *error))completion; {
    
    NSDictionary *postDictToken = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   kUrlPathParamApiToken_username_value, kUrlPathParamApiToken_username,
                                   kUrlPathParamApiToken_pass_value, kUrlPathParamApiToken_pass, nil];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDictToken];
    
    NSString *sURL = [NSString stringWithFormat:@"%@/%@", kUrlHost, kUrlPathApiToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSString *newToken = nil;
        
        if (!error && data) {
            
            NSDictionary *json = (data ? (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error] : nil);
            newToken = [json valueForKey:kJsonKeyAccessToken];
            [PreferencesManager setPreferencesString:newToken forKey:kJsonKeyAccessToken];
        }
        
        if (completion) completion(newToken, error);
    }];
}

+ (void)getIdiomsWithCompletion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiIdiom];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"GET";
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *idioms = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"IdiomItem" jsonData:data] : nil);
        
        if (completion) completion(idioms, error);
    }];
}

+ (void)getCountriesWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiCountry];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *countries = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"CountryItem" jsonData:data] : nil);
        
        if (completion) completion(countries, error);
    }];
}

+ (void)validateUserNameWithPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiUser];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        VerifyUserItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"VerifyUserItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)validateUserPassWithPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiUserPass];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        VerifyUserItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"VerifyUserItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)getListTermsPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiListTerms];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        VerifyUserItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"VerifyUserItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)acceptTermsPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiAcceptTerms];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        VerifyUserItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"VerifyUserItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)getMenuWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiMenu];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *menu = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"MenuItem" jsonData:data] : nil);
        
        if (completion) completion(menu, error);
    }];
}

+ (void)getMenuDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiMenuDetail];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *menuDetail = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"MenuDetailItem" jsonData:data] : nil);
        
        if (completion) completion(menuDetail, error);
    }];
}

+ (void)getSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiParams];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *params = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"ParamItem" jsonData:data] : nil);
        
        if (completion) completion(params, error);
    }];
}

+ (void)postUpdateSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSInteger responseCodeData, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiParamsUpdate];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCodeData = (!error && data ? [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] integerValue] : NSNotFound);
        
        if (completion) completion(responseCodeData, error);
    }];
}

+ (void)getSocialWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiSocial];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *params = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"SocialItem" jsonData:data] : nil);
        
        if (completion) completion(params, error);
    }];
}

+ (void)getOfficesWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiOffice];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *offices = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"OfficeItem" jsonData:data] : nil);
        
        if (completion) completion(offices, error);
    }];
}

+ (void)getMenuDetailInfoWithPostDict:(NSDictionary *)postDict completion:(void(^)(DetailInfoItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiMenuDetailInfo];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        DetailInfoItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"DetailInfoItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)getUserProfileWithPostDict:(NSDictionary *)postDict completion:(void(^)(UserProfileItem *item, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiUserProfile];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        UserProfileItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"UserProfileItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)getAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiListAttach];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *attachments = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"AttachItem" jsonData:data] : nil);
        
        if (completion) completion(attachments, error);
    }];
}

+ (void)getAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(AttachItem *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiAttach];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        AttachItem *item = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"AttachItem" jsonData:data] : nil);
        
        if (completion) completion(item, error);
    }];
}

+ (void)getDirectoryWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiDirectory];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *directories = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"DirectoryItem" jsonData:data] : nil);
        
        if (completion) completion(directories, error);
    }];
}

+ (void)getNotificationsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotification];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *notifications = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"NotificationItem" jsonData:data] : nil);
        
        if (completion) completion(notifications, error);
    }];
}

+ (void)getNotificationsUnReadWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSString *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotiUnread];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSString *value = ((!error && data) ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : 0);
        
        if (completion) completion(value, error);
    }];
}

+ (void)postNotificationUpdateWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationItem *data, NSError *error))completion; {
 
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotiUpdateRead];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NotificationItem *obejct = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"NotificationItem" jsonData:data] : nil);
        
        if (completion) completion(obejct, error);
    }];
}

+ (void)getNotificationDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationDetailItem *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotiDetail];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NotificationDetailItem *obejct = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"NotificationDetailItem" jsonData:data] : nil);
        
        if (completion) completion(obejct, error);
    }];
}

+ (void)getNotificationAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotiListAttach];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray *attachments = (!error && data ? [JSONParserManager getArrayDeserializeClassName:@"NotificationAttachItem" jsonData:data] : nil);
        
        if (completion) completion(attachments, error);
    }];
}

+ (void)getNotificationAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationAttachItem *data, NSError *error))completion; {
    
    NSString *currentToken = [PreferencesManager getPreferencesStringForKey:kJsonKeyAccessToken];
    
    NSString *sURL = [kUrlHost stringByAppendingPathComponent:kUrlPathApiNotiAttach];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:sURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kNetworkDefaultTimeoutSeconds];
    
    NSString *postBody = [NSString queryStringFromDictionary:postDict];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[NSString stringWithFormat:@"%@ %@", kUrlApiHeaderPrefix, currentToken] forHTTPHeaderField:kUrlApiHeaderAuthorization];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NetworkConnection sendAsynchronousRequest:request completionOnLocalQueue:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NotificationAttachItem *obejct = (!error && data ? [JSONParserManager getObjectDeserializeClassName:@"NotificationAttachItem" jsonData:data] : nil);
        
        if (completion) completion(obejct, error);
    }];
}

@end
