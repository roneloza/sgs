//
//  ViewController.h
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

#define ktopPinConstraint 32

@interface FirstViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIPickerView *idiomPicker;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)nextButtonPress:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPinConstraint;

@end

