//
//  FileManager.m
//  sgs
//
//  Created by Rone Loza on 5/19/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (NSURL *)appendPathComponentAtCachesDirectory:(NSString *)path {
    
    NSURL *urlPathFile = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                                  inDomains:NSUserDomainMask] lastObject]
                          URLByAppendingPathComponent:path];
    
//    [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
//                                             inDomains:NSUserDomainMask] lastObject]
//     URLByAppendingPathComponent:string isDirectory:YES];
    
    return urlPathFile;
}

+ (NSURL *)appendPathComponentAtDocumentDirectory:(NSString *)path {
    
    NSURL *urlPathFile = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                  inDomains:NSUserDomainMask] lastObject]
                          URLByAppendingPathComponent:path];
    
    return urlPathFile;
}

+ (NSURL *)appendPathComponentAtCachesDirectory:(NSString *)path ifNotExistCreateDirectory:(BOOL)ifNotExist {
    
    NSURL *urlPathFile = [[FileManager class] appendPathComponentAtCachesDirectory:path];
    BOOL isDir = YES;
    
    if (ifNotExist &&
        ![[NSFileManager defaultManager] fileExistsAtPath:[urlPathFile path] isDirectory:&isDir]) {
        
        [[NSFileManager defaultManager] createDirectoryAtURL:urlPathFile
                                           withIntermediateDirectories:YES
                                                            attributes:nil
                                                                 error:nil];
    }
    
    return urlPathFile;
}

+ (NSURL *)appendPathComponentAtDocumentDirectory:(NSString *)path ifNotExistCreateDirectory:(BOOL)ifNotExist {
    
    NSURL *urlPathFile = [[FileManager class] appendPathComponentAtDocumentDirectory:path];
    BOOL isDir = YES;
    
    if (ifNotExist &&
        ![[NSFileManager defaultManager] fileExistsAtPath:[urlPathFile path] isDirectory:&isDir]) {
        
        [[NSFileManager defaultManager] createDirectoryAtURL:urlPathFile
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:nil];
    }
    
    return urlPathFile;
}

+ (BOOL)createPathAtCachesDirectory:(NSString *)path {
    
    NSURL *urlPathDirectory = [[FileManager class] appendPathComponentAtCachesDirectory:path];
    
    BOOL isDir = YES;
    BOOL success = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[urlPathDirectory path] isDirectory:&isDir]) {
        
        success = NO;
        
        success = [[NSFileManager defaultManager] createDirectoryAtURL:urlPathDirectory
                                            withIntermediateDirectories:YES
                                                             attributes:nil
                                                                  error:nil];
    }
    
    return success;
}


+ (BOOL)createPathAtDocumentDirectory:(NSString *)path {
    
    NSURL *urlPathDirectory = [[FileManager class] appendPathComponentAtCachesDirectory:path];
    
    BOOL isDir = YES;
    BOOL success = NO;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[urlPathDirectory path] isDirectory:&isDir]) {
        
        success = [[NSFileManager defaultManager] createDirectoryAtURL:urlPathDirectory
                                           withIntermediateDirectories:YES
                                                            attributes:nil
                                                                 error:nil];
    }
    
    return success;
}

+ (void)writeData:(NSData *)data atFilePath:(NSString *)filePath {
    
    NSString *pathFolder = [filePath stringByDeletingLastPathComponent];
    BOOL isDir = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathFolder isDirectory:&isDir]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:pathFolder
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:nil];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        
    }
}

+ (NSData *)readDataAtFilePath:(NSString *)filePath {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) return nil;
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    
    return data;
}

+ (void)writeString:(NSString *)data atFilePath:(NSString *)filePath {
    
    NSString *pathFolder = [filePath stringByDeletingLastPathComponent];
    BOOL isDir = YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathFolder isDirectory:&isDir]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:pathFolder
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];;
        
    }
}

+ (NSString *)readStringAtFilePath:(NSString *)filePath {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) return nil;
    
    NSString *data = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    return data;
}

+ (void)cleanupOldFilesAtURL:(NSURL *)url maxDirSize:(NSUInteger)maxDirSize {
    
    NSDirectoryEnumerator *dirEnumerator = [[NSFileManager defaultManager]
                                            enumeratorAtURL:url
                                            includingPropertiesForKeys:[NSArray arrayWithObject:NSURLCreationDateKey]
                                            options:NSDirectoryEnumerationSkipsHiddenFiles
                                            errorHandler:nil];
    NSString *fileName;
    NSNumber *fileSize;
    NSDate *fileCreation;
    NSMutableArray *files = [NSMutableArray array];
    NSDictionary *fileData;
    __block NSUInteger dirSize = 0;
    
    for (NSURL *url in dirEnumerator) {
        
        [url getResourceValue:&fileName forKey:NSURLNameKey error:nil];
        [url getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
        [url getResourceValue:&fileCreation forKey:NSURLCreationDateKey error:nil];
        dirSize += [fileSize integerValue];
        fileData = [[NSDictionary alloc] initWithObjectsAndKeys:
                    url, @"url",
                    fileSize, @"size",
                    fileCreation, @"date",
                    fileName, @"name",
                    nil];
        
        [files addObject:fileData];
    }
    
    if (dirSize > maxDirSize) {
        
        NSArray *sorted = [files sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 valueForKey:@"date"] compare:[obj2 valueForKey:@"date"]];
        }];
        
        [sorted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            dirSize -= [[obj valueForKey:@"size"] integerValue];
            [[NSFileManager defaultManager] removeItemAtURL:[obj valueForKey:@"url"] error:nil];
            
            *stop = dirSize < maxDirSize;
        }];
    }
}

@end
