//
//  ProfileViewController.h
//  sgs
//
//  Created by Rone Loza on 5/5/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface ProfileViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailProfileTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UITextView *footerTextView;

- (IBAction)settingsButtonPressed:(UIButton *)sender;
- (IBAction)logoutButtonPressed:(id)sender;
@end
