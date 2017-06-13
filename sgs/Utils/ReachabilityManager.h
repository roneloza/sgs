//
//  ReachabilityManager.h
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>

@class Reachability;

@interface ReachabilityManager : NSObject

@property (strong, nonatomic) Reachability *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (ReachabilityManager *)sharedManager;

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;
+ (void)startNotifier;
+ (void)stopNotifier;

+ (void)addReachabilityChangedNotificationObserver:(__weak id)observer selector:(SEL)selector;
+ (void)removeReachabilityChangedNotificationObserver:(__weak id)observer;
@end
