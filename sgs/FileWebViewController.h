//
//  FileWebViewController.h
//  sgs
//
//  Created by rone loza on 5/22/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface FileWebViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURL *urlFile;
@end
