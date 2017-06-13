//
//  FileManager.h
//  sgs
//
//  Created by Rone Loza on 5/19/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFolderNameAttachments @"Attachments"
//#define AppendingPathToCacheDirectory(path) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:path]

// 50MB
#define kCacheMaxSize 1024*1024*50

@interface FileManager : NSObject

+ (NSURL *)appendPathComponentAtCachesDirectory:(NSString *)path;
+ (NSURL *)appendPathComponentAtDocumentDirectory:(NSString *)path;
+ (NSURL *)appendPathComponentAtCachesDirectory:(NSString *)path ifNotExistCreateDirectory:(BOOL)ifNotExist;
+ (NSURL *)appendPathComponentAtDocumentDirectory:(NSString *)path ifNotExistCreateDirectory:(BOOL)ifNotExist;
+ (BOOL)createPathAtCachesDirectory:(NSString *)path;
+ (BOOL)createPathAtDocumentDirectory:(NSString *)path;

+ (void)writeData:(NSData *)data atFilePath:(NSString *)filePath;
+ (NSData *)readDataAtFilePath:(NSString *)filePath;
+ (void)writeString:(NSString *)data atFilePath:(NSString *)filePath;
+ (NSString *)readStringAtFilePath:(NSString *)filePath;

+ (void)cleanupOldFilesAtURL:(NSURL *)url maxDirSize:(NSUInteger)maxDirSize;

@end
