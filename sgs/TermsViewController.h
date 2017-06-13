//
//  TermsViewController.h
//  sgs
//
//  Created by Rone Loza on 4/21/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface TermsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBarButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)nextButtonPress:(UIButton *)sender;

@property (nonatomic, assign) BOOL hiddenNextButton;
@end
