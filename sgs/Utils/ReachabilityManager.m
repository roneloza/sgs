//
//  ReachabilityManager.m
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ReachabilityManager.h"

@implementation ReachabilityManager

#pragma mark -
#pragma mark Default Manager
+ (ReachabilityManager *)sharedManager {
    
    static ReachabilityManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark -
#pragma mark Memory Management
- (void)dealloc {
    // Stop Notifier
    if (_reachability) {
        [_reachability stopNotifier];
    }
}

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable {
    
    return [[[[ReachabilityManager class] sharedManager] reachability] isReachable];
}

+ (BOOL)isUnreachable {
    
    return ![[[[ReachabilityManager class] sharedManager] reachability] isReachable];
}

+ (BOOL)isReachableViaWWAN {
    
    return [[[[ReachabilityManager class] sharedManager] reachability] isReachableViaWWAN];
}

+ (BOOL)isReachableViaWiFi {
    
    return [[[[ReachabilityManager class] sharedManager] reachability] isReachableViaWiFi];
}

+ (void)startNotifier {
    
    [[[[ReachabilityManager class] sharedManager] reachability] startNotifier];
}

+ (void)stopNotifier {
    
    [[[[ReachabilityManager class] sharedManager] reachability] stopNotifier];
}

#pragma mark -
#pragma mark Private Initialization

- (id)init {
    
    self = [super init];
    
    if (self) {
        // Initialize Reachability
        
//        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        
        self.reachability = [Reachability reachabilityForInternetConnection];
        
        // Start Monitoring
        [self.reachability startNotifier];
    }
    
    return self;
}

+ (void)addReachabilityChangedNotificationObserver:(__weak id)observer selector:(SEL)selector {
    
    // Add Observer
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:kReachabilityChangedNotification object:nil];
}

+ (void)removeReachabilityChangedNotificationObserver:(__weak id)observer {
    
    // Add Observer
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:kReachabilityChangedNotification object:nil];
}

@end
