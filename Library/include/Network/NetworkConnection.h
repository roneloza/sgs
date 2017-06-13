//
//  NetworkURLConnection.h
//  Network
//
//  Created by Rone Loza on 4/2/14.
//  Copyright (c) 2014 Tismart. All rights reserved.
//

#import <Foundation/Foundation.h>

/// \brief
/// An ConnectionNetwork object provides support to perform the asynchronous loading of a URL request.
/// Executing a handler block when the request completes or fails.
///
@interface NetworkConnection : NSObject

/// \brief
/// Dispatch async task on an queue for a URL request and executes a handler block when the request completes or fails.
/// If the request completes successfully, the data parameter of the handler block contains the resource data, and the error parameter is nil. If the
/// request fails, the data parameter is nil and the error parameter contain information about the failure.
///
/// \param
/// [in] request
/// The URL request to load. The request object is deep-copied as part of the initialization process. Changes made to request after this method returns do not affect the request that is used for the loading process.
/// \param
/// [in] handler The handler block to execute.
/// \b response Out parameter for the URL response returned by the server.
/// \b error Out parameter used if an error occurs while processing the request. May be NULL.
/// \b data The downloaded data for the URL request. Returns nil if a connection could not be created or if the download fails.
///
+ (void)sendAsynchronousRequest:(NSURLRequest *)request
              completionOnLocalQueue:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))handler;

/// \brief Dispatch async task on an queue for a URL request and executes a handler block on the main queue (main Thread UI) when the request completes or fails.
/// If the request completes successfully, the data parameter of the handler block contains the resource data, and the error parameter is nil. If the
/// request fails, the data parameter is nil and the error parameter contain information about the failure.
///
/// \param
/// [in] request
/// The URL request to load. The request object is deep-copied as part of the initialization process. Changes made to request after this method returns do not affect the request that is used for the loading process.
/// \param
/// [in] handler The handler block to execute.
/// \b response Out parameter for the URL response returned by the server.
/// \b error Out parameter used if an error occurs while processing the request. May be NULL.
/// \b data The downloaded data for the URL request. Returns nil if a connection could not be created or if the download fails.
///
+ (void)sendAsynchronousRequest:(NSURLRequest *)request
   completionOnMainQueue:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))handler;

@end
