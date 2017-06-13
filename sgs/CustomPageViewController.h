//
//  CustomPageViewController.h
//  sgs
//
//  Created by Rone Loza on 5/15/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@class BaseViewController;

@interface CustomPageViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *contentPageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSegmented;
- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender;

@property (weak, nonatomic) BaseViewController *currentViewController;
@property (weak, nonatomic) BaseViewController *nextViewController;
@property (nonatomic, assign) NSInteger currentPage;

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
