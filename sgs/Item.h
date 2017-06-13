//
//  Item.h
//  sgs
//
//  Created by Rone Loza on 5/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectInspectRuntime <NSObject>
/**
 *@brief
 *NSArray of @b *NSString describing the properties names declared by the class
 
 *@return
 *NSArray of *NSString
 **/
@property (nonatomic, strong) NSArray *propertyListClassNames;

/**
 *@brief
 *NSArray of @b id describing the properties values declared by the class
 
 *@return
 *NSArray of *NSString
 **/
@property (nonatomic, strong) NSArray *propertyListClassValues;

/**
 *@brief
 *NSDictionary of @b id describing the properties names & values declared by the class
 
 *@return
 *NSArray of *NSString
 **/
@property (nonatomic, strong) NSDictionary *propertyKeyPairs;

@end

@interface Item : NSObject<NSCopying, NSCoding, ObjectInspectRuntime>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *selected;
@property (nonatomic, strong) NSString *storyBoardId;
@property (nonatomic, strong) NSString *segueId;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *methodName;

- (id)initWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title selected:(BOOL)selected;

- (id)copyWithZone:(NSZone *)zone;

@end
