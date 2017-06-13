//
//  DetailMenuViewController.m
//  sgs
//
//  Created by Rone Loza on 4/27/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "MenuDetailTableViewCell.h"
#import "MenuDetailHeaderView.h"
#import "Constants.h"
#import "PreferencesManager.h"
#import "NetworkManagerReachability.h"
#import "UIAlertViewManager.h"
#import "LocalizableManager.h"
#import "MenuDetailItem.h"
#import "Constants.h"
#import "ColsTableViewController.h"
#import "BaseViewController.h"
#import "Item.h"
#import "MenuItem.h"
#import "LocalizableManager.h"
#import "DataBaseManagerSqlite.h"
#import <WYPopoverController/WYPopoverController.h>
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "DetailInfoItem.h"
#import "TableClause.h"
#import "MenuDetailInfoViewController.h"

#define kTableViewCellIdentifierMenuDetail @"MenuDetailTableViewCell"
#define kTableViewCellHeight 44.0f

#define kTableViewCellHeaderIdentifier @"MenuDetailHeaderView"
#define kTableViewCellHeaderHeight 44.0f

@interface MenuDetailViewController () <WYPopoverControllerDelegate, UISearchBarDelegate>

/**
 *
 @brief NSArray of MenuDetailItem *
 *
 **/
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *important;

@property (nonatomic, strong) WYPopoverController *popoverController;
@property (nonatomic, strong) ColsTableViewController *contentPopoverController;

@property (nonatomic, assign) BOOL firstRequest;

/**
 *
 @brief NSArray of MenuDetailItem *
 *
 **/
@property (nonatomic, strong) NSArray *sections;

@end

@implementation MenuDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    __weak MenuDetailViewController *wkself = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleLocalizedString = self.item.nombremenu;
//    self.title = self.item.nombremenu;
    
    wkself.page = 0;
    wkself.searchText = @"null";
    wkself.important = @"false";
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    [wkself.tableView registerNib:[UINib nibWithNibName:kTableViewCellHeaderIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:kTableViewCellHeaderIdentifier];
    
    wkself.searchBar.delegate = wkself;
    
    wkself.searchBar.showsCancelButton = NO;
    
    [wkself.tableView addPullToRefreshWithActionHandler:^{
       
        [wkself requestMenuDetailWithMenuId:wkself.item.idmenu completion:^(NSArray *data, NSError *error) {
            
            [wkself successRequestWithData:data error:error];
        }];
        
    } position:SVPullToRefreshPositionBottom];
    
    wkself.titleSegmented.selectedSegmentIndex = 0;
}

- (void)setupLabels {
    
    [super setupLabels];
    
    [self.titleSegmented setTitle:[[LocalizableManager localizedString:@"lbl_segmeted_all"] capitalizedString] forSegmentAtIndex:0];
    [self.titleSegmented setTitle:[[LocalizableManager localizedString:@"lbl_segmeted_important"] capitalizedString] forSegmentAtIndex:1];
    self.searchBar.placeholder = [[LocalizableManager localizedString:@"lbl_placeholder_search"] capitalizedString];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self.tableView reloadData];
    [self.popoverController dismissPopoverAnimated:NO];
    
    self.popoverController = nil;
}

/**
 *@brief generateLabelFromView
 *@param cols NSArray *of Item
 **/
+ (void)generateLabelFromView:(UIView *)view cols:(NSArray *)cols font:(UIFont *)font textColor:(UIColor *)textColor {
    
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat x = 0.0f;
    
    for (int i = 0; i < cols.count ;i++) {
        
        __weak Item *item = [cols objectAtIndex:i];
        
        float width = [item.width floatValue];
        
        NSString *words = [item.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        CGRect rectLabel1 = CGRectMake(x, 0, width, view.bounds.size.height);
        
        x = (rectLabel1.origin.x + rectLabel1.size.width);
        
        UILabel *label = [[UILabel alloc] initWithFrame:rectLabel1];
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = font;
        label.textColor = textColor;
        label.text = words;
        
        [view addSubview:label];
    }
}

/**
 *@brief adjustPadTextInLabel
 *@param cols NSArray *of Item
 **/
+ (NSString *)adjustPadTextInLabel:(UILabel *)label cols:(NSArray *)cols {
    
    NSString *newStr = @"";
    
//    CGFloat width = (widthLabel / cols.count);
    
    for (__weak Item *item in cols) {
        
        float width = [item.width floatValue];
        
        NSString *words = [item.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        BOOL next = YES;
        
        NSInteger count = 1;
        
        __block NSString *statement = @"";
        NSString *statementPrev = nil;
        
        NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys:label.font, NSFontAttributeName, nil];
        
        while (next) {
            
//            statement = [[NSString alloc] initWithFormat:@"%@%@%@",(count == 1 ? @"": @" "), (count == 1 ? words: statement), (count == 1 ? @"": @" ")];
            statement = [[NSString alloc] initWithFormat:@"%@%@", (count == 1 ? [[NSString alloc] initWithFormat:@" %@", words] : statement), (count == 1 ? @"": @" ")];
            
            CGSize size = [statement sizeWithAttributes:attr];
            
            if(size.width < width){
                
                next = YES;
            }
            else {
                
                if (statementPrev) {
                    
                    CGSize newSize = [words sizeWithAttributes:attr];
                    
                    if(newSize.width < width){
                        
                        statement = statementPrev;
                    }
                    else {
                        
                        statement = [statementPrev stringByReplacingOccurrencesOfString:words withString:[[NSString alloc] initWithFormat:@"%@...   ", words]];
                    }
                }
                else {
                    
                    [statement enumerateSubstringsInRange: NSMakeRange(0, [statement length]) options: NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *inSubstring, NSRange inSubstringRange, NSRange inEnclosingRange, BOOL *outStop) {
                        
                        NSString *subString = [statement substringWithRange:NSMakeRange(0, inSubstringRange.location + 1)];
                        
                        CGSize newSize = [subString sizeWithAttributes:attr];
                        
                        if(newSize.width >= width){
                            
                            statement = [[NSString alloc] initWithFormat:@"%@...   ", (subString.length > 4 ? [subString substringToIndex:subString.length - 4] : subString)];
                            
                            *outStop = YES;
                        }
                    }];
                }
                
                next = NO;
            }
            
            statementPrev = statement;
            
            count++;
        }
        
        newStr = [newStr stringByAppendingString:statement];
    }
    
    return newStr;
}

#pragma mark - Network

- (void)requestMenuDetailWithMenuId:(NSString *)menuId completion:(void (^)(NSArray *data , NSError *error))completion {
    
    __weak MenuDetailViewController *wkself = self;
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSUInteger page = wkself.page + 1;
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiMenuDetail_ididioma,
                                  [country uppercaseString], kUrlPathParamApiMenuDetail_idpais,
                                  userId, kUrlPathParamApiMenuDetail_idusuario,
                                  menuId, kUrlPathParamApiMenuDetail_idmenu,
                                  [[NSString alloc] initWithFormat:@"%d", page], kUrlPathParamApiMenuDetail_pagina,
                                  wkself.searchText, kUrlPathParamApiMenuDetail_valorbusqueda,
                                  wkself.important, kUrlPathParamApiMenuDetail_boolimportante,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getMenuDetailWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getMenuDetailWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                        
                    }
                }];
            }
            else {
                
                if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}


- (void)successRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak MenuDetailViewController *wkself = self;
    
    if (error) {
        
        if (error.code == kCFURLErrorUserCancelledAuthentication) {
            
        }
        else if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        [wkself dispatchOnMainQueue:^{
            
            if (!data || data.count < 2) {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notData"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_accept_label"] otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
                    
                    if (!wkself.firstRequest) {
                        
                        [wkself.navigationController popViewControllerAnimated:YES];
                    }
                    
                    [wkself refreshWithData:data];
                    
                    wkself.firstRequest = YES;
                }];
            }
            else {
                
                wkself.page++;
                
                [wkself refreshWithData:data];
                
                wkself.firstRequest = YES;
            }
        }];
        
//        else {
//            
//            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
//        }
    }
    
    [UIAlertViewManager progressHUDDismissWithCompletion:nil];
}

/**
 *@brief refresh sections and data properties
 *@param data NSArray of MenuDetailItem *
 **/
- (void)refreshWithData:(NSArray *)data {
    
    __weak MenuDetailViewController *wkself = self;
    
    if (wkself.data) {
        
        if (data.count > 1) {
            
            NSArray *items = [data subarrayWithRange:NSMakeRange(1, data.count - 1)];
            
            NSArray *indexPaths = [[NSArray alloc] init];
            NSInteger index = wkself.data.count;
            
            for (int i = 0; i < items.count; i++) {
                
                indexPaths = [indexPaths arrayByAddingObject:[NSIndexPath indexPathForRow:(index + i) inSection:0]];
            }
            
            
            if (indexPaths.count > 0) {
                
                wkself.data = [wkself.data arrayByAddingObjectsFromArray:items];
                
                [wkself.tableView insertRowsAtIndexPaths:indexPaths
                                        withRowAnimation:UITableViewRowAnimationNone];
                
                //            CGPoint newContentOffset = CGPointMake(0, wkself.tableView.bounds.size.height * wkself.data.count);
                //            [wkself.tableView setContentOffset:newContentOffset animated:YES];
            }
        }
    }
    else {
        
        MenuDetailItem *item = [data firstObject];
        
        [PreferencesManager setSelectedColumnsDefaultsWithItem:item];
        
        wkself.sections = [[NSArray alloc] initWithObjects:item, nil];
        
        wkself.data = [data subarrayWithRange:NSMakeRange(1, data.count - 1)];
        
        [wkself.tableView reloadData];
    }
    
    [wkself.tableView.pullToRefreshView stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuDetailTableViewCell *cell = (MenuDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifierMenuDetail forIndexPath:indexPath];
    
    __weak MenuDetailItem *item = [self.data objectAtIndex:indexPath.row];

    cell.iconImageView.image = [item.booladjunto boolValue]? [UIImage imageNamed:@"ic_attachment"] : nil;
    cell.alertImageView.image = [item.boolimportante boolValue] ? [UIImage imageNamed:@"ic_alert"] : nil;
    
    cell.labelContentView.backgroundColor = UIColorFromHex(kColorCellDetail, 1.0f);
    cell.iconImageContentView.backgroundColor = UIColorFromHex(kColorCellDetail, 1.0f);
    
    __weak NSArray *cols = [[PreferencesManager class] getSelectedColumnsWithIsPortrait:UIInterfaceOrientationIsPortrait(self.currentInterfaceOrientation) data:item.columns];
    
    [cols makeObjectsPerformSelector:@selector(setWidth:) withObject:[NSNumber numberWithFloat:(self.tableView.bounds.size.width - (43.0f + 24.0f)) / cols.count]];
    
//    NSString *newStr = [[self class] adjustPadTextInLabel:cell.rowLabel cols:cols];
    
//    cell.rowLabel.text = newStr;
    
//    [cell.rowContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [[self class] generateLabelFromView:cell.rowContentView cols:cols font:[UIFont systemFontOfSize:13.0f] textColor:[UIColor darkGrayColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [self performSegueWithIdentifier:@"segue_to_pageviewcontroller" sender:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kTableViewCellHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
    MenuDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableViewCellHeaderIdentifier];
    
    __weak MenuDetailItem *item = [self.sections objectAtIndex:section];
    
    __weak NSArray *cols = [[PreferencesManager class] getSelectedColumnsWithIsPortrait:UIInterfaceOrientationIsPortrait(self.currentInterfaceOrientation) data:item.columns];
    
    [cols makeObjectsPerformSelector:@selector(setWidth:) withObject:[NSNumber numberWithFloat:((self.tableView.bounds.size.width - (43.0f + 24.0f)) / cols.count)]];
    
//    NSString *newStr = [[self class] adjustPadTextInLabel:v.sectionLabel cols:cols];
    
//    headerView.sectionLabel.text = newStr;
    
    [[self class] generateLabelFromView:headerView.contentLabelView cols:cols font:[UIFont boldSystemFontOfSize:13.0f] textColor:[UIColor whiteColor]];
    
    return headerView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform the real delete action here. Note: you may need to check editing style
    //   if you do not perform delete only.
    NSLog(@"Deleted row.");
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak MenuDetailViewController *wkself = self;
    
//    __weak UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // action one
    UITableViewRowAction *archiveAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:[LocalizableManager localizedString:@"btn_archive_label"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        __weak MenuDetailItem *item = [wkself.data objectAtIndex:indexPath.row];
        
        [[MenuDetailInfoViewController class] requestMenuDetailInfoWithItem:item completion:^(DetailInfoItem *data, NSError *error) {
            
            NSDictionary *keyPairs = nil;
            
            if ([data conformsToProtocol:@protocol(ObjectInspectRuntime)]) {
                
                keyPairs = [data propertyKeyPairs];
            }
            
            [DataBaseManagerSqlite insertFromClassName:NSStringFromClass([DetailInfoItem class]) keyPairs:keyPairs where:[[NSArray alloc] initWithObjects:[[TableClause alloc] initWithKey:@"idmenudetalle" value:item.idmenudetalle operatorCondition:@"==" operatorExpression:nil], nil]];
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_detail_archive_success"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_accept_label"] otherButtonTitles:nil onDismiss:nil];
            
        }];
        
        [tableView setEditing:NO animated:NO];
    }];
    
    archiveAction.backgroundColor = UIColorFromHex(kColorSGS, 1.0f);
    
    return [[NSArray alloc] initWithObjects:archiveAction, nil];
}

#pragma mark - IBAction

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak MenuDetailViewController *wkself = self;
    
    NSString *searchBarText = [wkself.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    wkself.searchText = searchBarText.length > 1 ? searchBarText : @"null";
    
    wkself.page = 0;
    wkself.data = nil;
    wkself.sections = nil;
    
    [wkself requestMenuDetailWithMenuId:wkself.item.idmenu completion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithData:data error:error];
    }];
}

- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender {
 
    __weak MenuDetailViewController *wkself = self;
    
    wkself.important = sender.selectedSegmentIndex == 0 ? @"false" : @"true";
    
    [wkself refreshBarButtonPressed:nil];
}

- (IBAction)showHeadersBarButtonPress:(UIBarButtonItem *)sender event:(UIEvent *)event {
    
    __weak MenuDetailViewController *wkself = self;

    wkself.contentPopoverController = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierColsTVC);
    wkself.contentPopoverController.titleLocalizedString = @"tab_header_by_label";
    
    __weak MenuDetailItem *item = [wkself.sections objectAtIndex:0];
    
    [item.columns makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:NO]];
    
    /////
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title.length > 0"];
    
    __weak NSArray *columns = [item.columns filteredArrayUsingPredicate:predicate];
    
    __weak NSArray *selectedColumns = [[PreferencesManager class] getSelectedColumnsWithIsPortrait:UIInterfaceOrientationIsPortrait(self.currentInterfaceOrientation)
                                                                                              data:columns];
    
    [selectedColumns makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:YES]];
    
    /////
    wkself.contentPopoverController.data = columns;
    
    wkself.popoverController = [[WYPopoverController alloc] initWithContentViewController:wkself.contentPopoverController];
    wkself.popoverController.delegate = wkself;
    
    CGRect rect = CGRectMake(0,0, wkself.view.bounds.size.width * 0.8f, wkself.view.bounds.size.height * 0.9f);
    
    wkself.popoverController.popoverContentSize = rect.size;
    wkself.contentPopoverController.view.frame = rect;
    
    [wkself.popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController {
    
    if (self.contentPopoverController.refreshParent) {
        
        [self.contentPopoverController updateSelectedColumns];
        
        [self.tableView reloadData];
    }
    
    // dealloc
    self.popoverController.delegate = nil;
    self.contentPopoverController = nil;
    self.popoverController = nil;
}

#pragma mark - UISearchBarDelegate

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText; {
//    
//    NSString *words = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    if (words.length >= 5) {
//        
//        [self refreshBarButtonPressed:nil];
//    }
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    __weak MenuDetailViewController *wkself = self;
    
    [wkself refreshBarButtonPressed:nil];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    __weak MenuDetailViewController *wkself = self;
    
    [searchBar resignFirstResponder];
    
    searchBar.text = @"";
    
    [wkself refreshBarButtonPressed:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    BOOL stop = NO;
    
    for (UIView *view in searchBar.subviews) {
        
        for (id subview in view.subviews) {
            
            if ([subview isKindOfClass:[UIButton class]]) {
                
                NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:[[LocalizableManager localizedString:@"btn_cancel_label"] capitalizedString] attributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName, nil]];
                
                [(UIButton*)subview setAttributedTitle:attrString forState:UIControlStateNormal];
                
                stop = YES;
                break;
            }
        }
        
        if (stop) break;
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_to_pageviewcontroller"]) {
    
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        __weak BaseViewController *vc = (BaseViewController *)segue.destinationViewController;
        
        MenuDetailItem *item1 = [[self.data objectAtIndex:indexPath.row] copy];
        MenuDetailItem *item2 = [[self.data objectAtIndex:indexPath.row] copy];
        
        item1.title = @"lbl_segmented_detail";
        item1.selected = [NSNumber numberWithBool:YES];
        item1.storyBoardId = kStoryboardIdentifierMenuDetailInfoVC;
        
        item2.title = @"lbl_segmented_attach";
        item2.selected = [NSNumber numberWithBool:NO];
        item2.storyBoardId = kStoryboardIdentifierAttachmentVC;
        
        __weak MenuDetailItem *menuDetailItem = [self.data objectAtIndex:indexPath.row];
                                 
        __weak NSArray *cols = [[PreferencesManager class] getSelectedColumnsWithIsPortrait:UIInterfaceOrientationIsPortrait(self.currentInterfaceOrientation) data:menuDetailItem.columns];
        
        Item *item = (Item *)[cols firstObject];
        
        vc.titleLocalizedString = cols.count > 0 ? item.title : @"";
        
        vc.items = [[NSArray alloc] initWithObjects:item1, item2, nil];
        
        vc.index = 0;
    }
}

@end
