//
//  JSONParserManager.m
//  statslite
//
//  Created by Rone Loza on 11/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import "JSONParserManager.h"
#import "PreferencesManager.h"
#import "Item.h"
#import <objC/message.h>

@implementation JSONParserManager

+ (NSArray *)getArrayDeserializeClassName:(NSString *)className jsonData:(NSData *)jsonData {
    
    NSMutableArray *objects = nil;
    
    if (jsonData) {
        
        id json = (jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil] : nil);
        
        if ([json isKindOfClass:[NSArray class]]) {
            
            objects = [[NSMutableArray alloc] initWithCapacity:[json count]];
            
            for (__weak NSDictionary *item in json) {
             
                id object = [[NSClassFromString(className) alloc] init];
                
                if ([object conformsToProtocol:@protocol(ObjectInspectRuntime)]) {
                    
                    for (__weak NSString *propertyName in [object propertyListClassNames]) {
                        
                        SEL propertySetter = NSSelectorFromString([[NSString alloc] initWithFormat:@"set%@:", [propertyName capitalizedString]]);
                        
                        if (class_respondsToSelector([object class], propertySetter)) {
                            
                            Class class = NULL;
                            
                            objc_property_t property = class_getProperty([object class], [propertyName cStringUsingEncoding:NSUTF8StringEncoding]);
                            
                            if (property != NULL) {
                                
                                const char* attributes = property_getAttributes(property);
                                
                                if (attributes[1] == '@') {
                                    
                                    NSMutableString* className = [NSMutableString new];
                                    
                                    for (int j=3; attributes[j] && attributes[j]!='"'; j++)
                                        [className appendFormat:@"%c", attributes[j]];
                                    
                                    class = NSClassFromString(className);
                                }
                            }
                            
                            id value = [item valueForKey:propertyName];
                            
                            if (value &&
                                [value isKindOfClass:class] &&
                                ![value isKindOfClass:[NSNull class]]) {
                                
                                void (*objc_msgSendTyped)(id selfObject, SEL _cmd, id object) = (void*)objc_msgSend;
                                
                                objc_msgSendTyped(object, propertySetter, value);
                            }
                        }
                        
                    }
                }
                
                [objects addObject:object];
            }
        }
    }
    
    return objects;
}

+ (id)getObjectDeserializeClassName:(NSString *)className jsonData:(NSData *)jsonData {
    
    id object = nil;
    
    if (jsonData) {
        
        id json = (jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil] : nil);
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            object = [[NSClassFromString(className) alloc] init];
            
            if ([object conformsToProtocol:@protocol(ObjectInspectRuntime)]) {
                
                for (__weak NSString *propertyName in [object propertyListClassNames]) {
                    
                    SEL propertySelector = NSSelectorFromString([[NSString alloc] initWithFormat:@"set%@:", [propertyName capitalizedString]]);
                    
                    if ((class_respondsToSelector([object class], propertySelector))) {
                        
                        Class class = NULL;
                        
                        objc_property_t property = class_getProperty([object class], [propertyName cStringUsingEncoding:NSUTF8StringEncoding]);
                        
                        if (property != NULL) {
                            
                            const char* attributes = property_getAttributes(property);
                            
                            if (attributes[1] == '@') {
                                
                                NSMutableString* className = [NSMutableString new];
                                
                                for (int j=3; attributes[j] && attributes[j]!='"'; j++)
                                    [className appendFormat:@"%c", attributes[j]];
                                
                                class = NSClassFromString(className);
                            }
                        }
                        
                        id value = [json valueForKey:propertyName];
                        
                        if (value &&
                            [value isKindOfClass:class] &&
                            ![value isKindOfClass:[NSNull class]]) {
                            
                            void (*objc_msgSendTyped)(id selfObject, SEL _cmd, id object) = (void*)objc_msgSend;
                            
                            objc_msgSendTyped(object, propertySelector, value);
                        }
                    }
                }
            }
        }
    }
    
    return object;
}

@end
