//
//  ContactsNavViewController.m
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ContactsNavViewController.h"
#import "Item.h"
#import "BaseViewController.h"
#import "Constants.h"
//#import "CustomPageViewController.h"

@interface ContactsNavViewController ()

@end

@implementation ContactsNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    BaseViewController *pgvc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierCustomPVC);

    Item *itemDirectory = [[Item alloc] initWithTitle:@"lbl_segmented_directory" selected:NO];
    itemDirectory.storyBoardId = kStoryboardIdentifierOfficeVC;
    
    Item *itemGeneral = [[Item alloc] initWithTitle:@"lbl_segmented_general" selected:YES];
    itemGeneral.storyBoardId = kStoryboardIdentifierGeneralVC;
    
    pgvc.items = [[NSArray alloc] initWithObjects:itemDirectory, itemGeneral, nil];
    
//    [pgvc.titleSegmented setEnabled:NO forSegmentAtIndex:0];
    
    pgvc.titleLocalizedString = @"tab_contacts_label";
    
    pgvc.index = 1;
    
    self.viewControllers = [[NSArray alloc] initWithObjects:pgvc, nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
