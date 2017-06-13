//
//  SocialTableViewController.m
//  sgs
//
//  Created by Daniel on 5/8/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ContactViewController.h"
#import "LocalizableManager.h"
#import "CustomPageViewController.h"
#import "Item.h"
#import "Constants.h"

#define kSegueContactToPageView @"segue_to_pageview"

@interface ContactViewController ()

@property (nonatomic, strong) NSArray *pageViewControllers;

@property (nonatomic, weak) CustomPageViewController *pageViewComtroller;

@end

@implementation ContactViewController

- (NSArray *)pageViewControllers {
    
    if (!_pageViewControllers) {
        
        Item *itemDirectory = [[Item alloc] init];
        itemDirectory.storyBoardId = kStoryboardIdentifierColsTVC;
        
        Item *itemGeneral = [[Item alloc] init];
        itemGeneral.storyBoardId = kStoryboardIdentifierGeneralVC;
        
        _pageViewControllers = [[NSArray alloc] initWithObjects:itemDirectory, itemGeneral, nil];
    }
    
    return _pageViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleLocalizedString = @"tab_contacts_label";
}

- (void)setupLabels {
    
    [super setupLabels];
    
    [self.titleSegmented setTitle:[[LocalizableManager localizedString:@"lbl_segmented_directory"] capitalizedString] forSegmentAtIndex:0];
    [self.titleSegmented setTitle:[[LocalizableManager localizedString:@"lbl_segmented_general"] capitalizedString] forSegmentAtIndex:1];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSegueContactToPageView]) {
        
        self.pageViewComtroller = segue.destinationViewController;
        
        self.pageViewComtroller.items = self.pageViewControllers;
        
        
        
    }
}

- (IBAction)refreshBarButtonPressed:(id)sender {
    
}

- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender {
    
    [self.pageViewComtroller scrollToPage:sender.selectedSegmentIndex animated:YES];
}

@end
