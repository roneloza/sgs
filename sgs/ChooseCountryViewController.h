//
//  ChooseCountryViewController.h
//  sgs
//
//  Created by Rone Loza on 4/20/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface ChooseCountryViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIPickerView *idiomPicker;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBarButton;

- (IBAction)nextButtonPress:(UIButton *)sender;

@end
