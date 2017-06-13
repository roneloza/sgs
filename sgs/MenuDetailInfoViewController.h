//
//  MenuDetailInfoViewController.h
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@class MenuDetailItem, DetailInfoItem;

@interface MenuDetailInfoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (nonatomic, strong) MenuDetailItem *item;

+ (void)requestMenuDetailInfoWithItem:(MenuDetailItem *)item completion:(void(^)(DetailInfoItem *data, NSError *error))completion;
@end
