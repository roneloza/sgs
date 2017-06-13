//
//  BaseViewController.h
//  sgs
//
//  Created by Rone Loza on 4/25/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DelegateLocalizedString.h"

@class Item, CustomPageViewController;
@interface BaseViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *titleLocalizedString;

/*
 * @brief NSArray of *Item
 */
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) Item *model;

@property (nonatomic, weak) CustomPageViewController *pgvc;

- (void)setupLabels;

- (void)dispatchOnMainQueue:(void(^)(void))block;

- (IBAction)refreshBarButtonPressed:(id)sender;

- (UIInterfaceOrientation)currentInterfaceOrientation;

- (NSData *)dataFromBase64EncodedString:(NSString *)base64EncodedString;
@end
