//
//  SocialTableViewController.h
//  sgs
//
//  Created by Daniel on 5/8/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSegmented;
- (IBAction)refreshBarButtonPressed:(id)sender;
- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender;
@end
