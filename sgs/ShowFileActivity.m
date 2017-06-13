//
//  ShowFileActivity.m
//  sgs
//
//  Created by Rone Loza on 5/19/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ShowFileActivity.h"
#import "LocalizableManager.h"

@implementation ShowFileActivity

- (NSString *)activityType {
    
    return @"com.novit.sgs.showfile";
}

- (NSString *)activityTitle {
    
    return [[LocalizableManager localizedString:@"lbl_display"] capitalizedString];
}

- (UIImage *) activityImage {
    
    return [UIImage imageNamed:@"ic_file"];
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
