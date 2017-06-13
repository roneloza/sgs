//
//  SignViewController.h
//  sgs
//
//  Created by Rone Loza on 4/24/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@class CountryItem;

@interface SignViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *chooseRegionButton;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (weak, nonatomic) IBOutlet UIView *lockContextView;
@property (weak, nonatomic) IBOutlet UIView *passContentView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextButtonPress:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;
- (IBAction)passwordEditChanged:(UITextField *)sender;
- (IBAction)showPassButtonPress:(UIButton *)sender;

@property (nonatomic, strong) CountryItem *countryItem;
@end
