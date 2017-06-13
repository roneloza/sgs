//
//  NetworkActivityIndicator.h
//  Network
//
//  Created by Rone Loza on 4/2/14.
//  Copyright (c) 2014 Tismart. All rights reserved.
//

#import <Foundation/Foundation.h>

/// \brief
/// An NetworkActivityIndicator object provides support to manage the indicator of network activity on or off.
///
@interface NetworkActivityIndicator : NSObject

/// \brief
/// Increments the counter global of the network activity and \b show the network activity indicator.
///
+ (void)startActivity;

/// \brief
/// Decrements the counter global of the network activity and if counter global is \b zero then \b hides the network activity indicator.
///
+ (void)stopActivity;

@end
