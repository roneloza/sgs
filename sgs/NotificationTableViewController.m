//
//  NotificationTableViewController.m
//  sgs
//
//  Created by rone loza on 6/1/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "NotificationTableViewController.h"
#import "WebViewController.h"
#import "NotificationTableViewCell.h"
#import "UIAlertViewManager.h"
#import "NotificationItem.h"
#import "NotificationDetailItem.h"
#import "LocalizableManager.h"
#import "PreferencesManager.h"
#import "Constants.h"
#import "BaseTabBarViewController.h"
#import "NetworkManagerReachability.h"
#import "DataBaseManagerSqlite.h"
#import "TableClause.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

#define kTableViewCellIdentifierNotification @"NotificationTableViewCell"
#define kTableViewCellHeight 77.0f
#define kSegueToPageViewIdentifier @"segue_notification_to_pageview"

@interface NotificationTableViewController ()<UISearchBarDelegate>

/**
 *
 @brief NSArray of NotificationItem *
 *
 **/
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *important;

@end

@implementation NotificationTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak NotificationTableViewController *wkself = self;
    
    wkself.titleLocalizedString = @"tab_noti_label";
    
    wkself.page = 0;
    wkself.searchText = @"null";
    wkself.important = @"null";
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    wkself.searchBar.delegate = wkself;
    
    wkself.searchBar.showsCancelButton = NO;
    
    [wkself.tableView addPullToRefreshWithActionHandler:^{
        
        [wkself requestNotificationWithCompletion:^(NSArray *data, NSError *error) {
            
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
    
    __weak NotificationTableViewController *wkself = self;
    
    [wkself refreshBarButtonPressed:nil];
    
    [[BaseTabBarViewController class] requestNotificationUnReadWithCompletion:^(NSString *data, NSError *error) {
        
        [[BaseTabBarViewController class] successRequestWithTabBar:[wkself.tabBarController.tabBar.items objectAtIndex:0] data:data error:error];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)requestNotificationWithCompletion:(void (^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSUInteger page = self.page + 1;
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamNotification_ididioma,
                                  [country uppercaseString], kUrlPathParamNotification_idpais,
                                  userId, kUrlPathParamNotification_idusuario,
                                  [[NSString alloc] initWithFormat:@"%d", page], kUrlPathParamNotification_pagina,
                                  self.searchText, kUrlPathParamNotification_valorbusqueda,
                                  self.important, kUrlPathParamNotification_boolimportante,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getNotificationsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getNotificationsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
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
    
    __weak NotificationTableViewController *wkself = self;
    
    if (error) {
        
        if (error.code == kCFURLErrorUserCancelledAuthentication) {
            
        }
        else if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            wkself.page++;
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself refreshWithData:data];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

/**
 *@brief refresh sections and data properties
 *@param data NSArray of MenuDetailItem *
 **/
- (void)refreshWithData:(NSArray *)data {
    
    __weak NotificationTableViewController *wkself = self;
    
    if (wkself.data) {
        
        NSArray *indexPaths = [[NSArray alloc] init];
        NSInteger index = wkself.data.count;
        
        for (int i = 0; i < data.count; i++) {
            
            indexPaths = [indexPaths arrayByAddingObject:[NSIndexPath indexPathForRow:index + i inSection:0]];
        }
        
        //        CGPoint newContentOffset = CGPointMake(0, wkself.tableView.bounds.size.height * wkself.data.count);
        
        if (indexPaths.count > 0) {
            
            wkself.data = [wkself.data arrayByAddingObjectsFromArray:data];
            
            [wkself.tableView insertRowsAtIndexPaths:indexPaths
                                    withRowAnimation:UITableViewRowAnimationNone];
            
            //            [wkself.tableView setContentOffset:newContentOffset animated:YES];
        }
    }
    else {
        
        wkself.data = data;
        
        [wkself.tableView reloadData];
    }
    
    [wkself.tableView.pullToRefreshView stopAnimating];
}

- (void)requestNotificationUpdateWithNotificationId:(NSString *)notificationId completion:(void (^)(NotificationItem *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamNotiUpdateRead_ididioma,
                                  [country uppercaseString], kUrlPathParamNotiUpdateRead_idpais,
                                  userId, kUrlPathParamNotiUpdateRead_idusuario,
                                  notificationId, kUrlPathParamNotiUpdateRead_idnotificacion,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability postNotificationUpdateWithPostDict:postDataDict completion:^(NotificationItem *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability postNotificationUpdateWithPostDict:postDataDict completion:^(NotificationItem *data , NSError *error) {
                            
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

- (void)successRequestNotificationUpdateWithData:(NotificationItem *)data error:(NSError *)error {
    
    __weak NotificationTableViewController *wkself = self;
    
    if (error) {
        
        if (error.code == kCFURLErrorUserCancelledAuthentication) {
            
        }
        else if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            [wkself dispatchOnMainQueue:^{
            
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
                
                if([data.result isEqualToString:@"0"]) {
                    
                    __weak NotificationItem *item = [wkself.data objectAtIndex:wkself.tableView.indexPathForSelectedRow.row];
                    
                    item.boollectura = [NSNumber numberWithBool:YES];
                    
                    [wkself.tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:wkself.tableView.indexPathForSelectedRow, nil] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                }
                else {
                    
                    [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:data.mensaje cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
                }
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

+ (NSString *)stringFormattedNotificationDateString:(NSString *)notificationDateString {
    
    NSString *dateString = @"";
    
    NSDate *currentDateUTC = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    NSDate *notificactionDateUTC = [dateFormatter dateFromString:notificationDateString];
    
    NSTimeInterval intervalOneMinute = 60;
    NSTimeInterval intervalOneHour = 60 * 60;
    NSTimeInterval intervalOneDay = 60 * 60 * 24;
    
    NSTimeInterval intervalCurrentDateUTC = currentDateUTC.timeIntervalSince1970;
    NSTimeInterval intervalNotificactionDateUTC = notificactionDateUTC.timeIntervalSince1970;
    
    NSTimeInterval intervalElapsedInToday = (long)intervalCurrentDateUTC % (long)intervalOneDay;
    
    NSTimeInterval intervalElapsedYesterday = intervalCurrentDateUTC - intervalElapsedInToday;
    NSTimeInterval intervalElapsedTwoDaysAgo = intervalElapsedYesterday - intervalOneDay;
    
    NSTimeInterval intervalBetweenDates = intervalCurrentDateUTC - intervalNotificactionDateUTC;
    
    /// Today
    if (BETWEEN(intervalNotificactionDateUTC, intervalElapsedYesterday, intervalCurrentDateUTC)) {
        
        if (intervalBetweenDates < intervalOneHour) {
            
            int minutes = ((int)intervalBetweenDates / (int)intervalOneMinute);
            
            dateString = [NSString stringWithFormat:[LocalizableManager localizedString:@"lbl_display_date"], [[NSString alloc] initWithFormat:@"%d", minutes]];
        }
        else {
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"H:mm a"];
            
            dateString = [dateFormatter stringFromDate:notificactionDateUTC];
        }
    }
    // Yesterday
    else if (BETWEEN(intervalNotificactionDateUTC, intervalElapsedTwoDaysAgo, intervalElapsedYesterday)) {
        
        dateString = [[LocalizableManager localizedString:@"lbl_yesterday"] capitalizedString];
    }
    else {
        
        NSLocale *locale = [LocalizableManager localizedLocale];
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = locale;
        
        [dateFormatter setDateFormat:@"d MMM"];
        
        dateString = [dateFormatter stringFromDate:notificactionDateUTC];
    }
    
    return dateString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationTableViewCell *cell = (NotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifierNotification forIndexPath:indexPath];
    
    __weak NotificationItem *item = [self.data objectAtIndex:indexPath.row];
    
    NSString *dateString = [[self class] stringFormattedNotificationDateString:item.fecha];
    
    cell.dateLabel.text = dateString;
    
    cell.iconImageView.image = ([item.boollectura boolValue] ? (item.iconogris.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:item.iconogris]] : [UIImage imageNamed:@"ic_notification_read"]) : (item.icononaranja.length > 0 ? [[UIImage alloc] initWithData:[self dataFromBase64EncodedString:item.icononaranja]] : [UIImage imageNamed:@"ic_notification_unread"]));
    
    cell.attachImageView.image = [item.booladjunto boolValue]? [UIImage imageNamed:@"ic_attachment"] : nil;
    cell.alertImageView.image = [item.boolimportante boolValue] ? [UIImage imageNamed:@"ic_alert"] : nil;
    
    cell.titleLabel.text = item.titulo;
    
    cell.subTitleLabel.text = [[NSString  alloc] initWithFormat:@"%@ %@", item.subtitulo1, item.subtitulo2];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak NotificationTableViewController *wkself = self;
    
    __weak NotificationItem *item = [wkself.data objectAtIndex:indexPath.row];

    if ([item.boollectura boolValue]) {
        
        [wkself requestNotificationUpdateWithNotificationId:item.idnotificacion completion:^(NotificationItem *data, NSError *error) {
            
            [wkself successRequestNotificationUpdateWithData:data error:error];
        }];
    }
    [self performSegueWithIdentifier:kSegueToPageViewIdentifier sender:indexPath];
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
    
    __weak NotificationTableViewController *wkself = self;
    
    UITableViewRowAction *archiveAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:[LocalizableManager localizedString:@"btn_archive_label"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        __weak NotificationItem *item = [wkself.data objectAtIndex:indexPath.row];
        
        [[WebViewController class] requestNotificationDetailWithNotificationId:item.idnotificacion completion:^(NotificationDetailItem *data, NSError *error) {
            
            NSDictionary *keyPairs = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      data.idnotificacion, @"idmenu",
                                      data.idnotificacion, @"idmenudetalle",
                                      (!data.iconooffline ? [NSNull null] : data.iconooffline), @"iconooffline",
                                      (!data.nombremenu ? [NSNull null] : data.nombremenu), @"nombremenu",
                                      (!data.descripcionoffline ? [NSNull null] : data.descripcionoffline), @"descripcionoffline",
                                      (!data.htmldetalle ? [NSNull null] : data.htmldetalle), @"htmldetalle",
                                      nil];
            
            [DataBaseManagerSqlite insertFromClassName:@"DetailInfoItem"
                                              keyPairs:keyPairs
                                                 where:[[NSArray alloc] initWithObjects:
                                                        [[TableClause alloc] initWithKey:@"idmenudetalle" value:item.idnotificacion operatorCondition:@"==" operatorExpression:@"AND"],
                                                        [[TableClause alloc] initWithKey:@"idmenu" value:item.idnotificacion operatorCondition:@"==" operatorExpression:nil],
                                                        nil]];
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_detail_archive_success"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_accept_label"] otherButtonTitles:nil onDismiss:nil];
        }];
        
        [tableView setEditing:NO animated:NO];
    }];
    
    archiveAction.backgroundColor = UIColorFromHex(kColorSGS, 1.0f);
    
    return [[NSArray alloc] initWithObjects:archiveAction, nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    __weak NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    __weak NotificationItem *item = [self.data objectAtIndex:indexPath.row];
    
    if ([segue.identifier isEqualToString:kSegueToPageViewIdentifier]) {
        
        BaseViewController *pgvc = segue.destinationViewController;
        pgvc.model = item;
        
        Item *itemWeb = [item copy];
        itemWeb.title = @"lbl_segmented_detail";
        itemWeb.selected = [NSNumber numberWithBool:YES];
        itemWeb.storyBoardId = kStoryboardIdentifierWebViewController;
        
        Item *itemAttachments = [item copy];
        itemAttachments.title = @"lbl_segmented_attach";
        item.selected = [NSNumber numberWithBool:NO];
        itemAttachments.storyBoardId = kStoryboardIdentifierAttachmentVC;
        
        pgvc.items = [[NSArray alloc] initWithObjects:itemWeb, itemAttachments, nil];
        
        pgvc.titleLocalizedString = [[NSString alloc] initWithFormat:@"%@...", (item.idnotificacion.length > 6 ? [item.idnotificacion substringToIndex:6] : item.idnotificacion)];
        
        pgvc.index = 0;
    }
}

#pragma mark - IBActions

- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender {
    
    __weak NotificationTableViewController *wkself = self;
    
    wkself.important = sender.selectedSegmentIndex == 0 ? @"null" : @"true";
    
    [wkself refreshBarButtonPressed:nil];
}

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak NotificationTableViewController *wkself = self;
    
    NSString *searchBarText = [wkself.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    wkself.searchText = searchBarText.length > 1 ? searchBarText : @"null";
    
    wkself.page = 0;
    wkself.data = nil;
    
    [wkself requestNotificationWithCompletion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithData:data error:error];
    }];
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
    
    __weak NotificationTableViewController *wkself = self;
    
    [wkself refreshBarButtonPressed:nil];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    __weak NotificationTableViewController *wkself = self;
    
    searchBar.text = @"";
    
    [searchBar resignFirstResponder];
    
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

@end
