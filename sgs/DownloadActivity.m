//
//  DownloadActivity.m
//  sgs
//
//  Created by Rone Loza on 5/19/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "DownloadActivity.h"
#import "LocalizableManager.h"

@implementation DownloadActivity

- (NSString *)activityType {
    
    return @"com.novit.sgs.download";
}

- (NSString *)activityTitle {
    
    return [[LocalizableManager localizedString:@"lbl_download"] capitalizedString];
}

- (UIImage *) activityImage {
    
    return [UIImage imageNamed:@"ic_download"];
}

- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems {
    
    return YES;
}

- (void) prepareWithActivityItems:(NSArray *)activityItems {
    
}

- (UIViewController *) activityViewController {
    return nil; }

- (void)performActivity {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"maps://"]];
}

@end
