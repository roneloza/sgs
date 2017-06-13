
//
//  ColsTableViewController.m
//  sgs
//
//  Created by Rone Loza on 5/2/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ColsTableViewController.h"
#import "UIAlertViewManager.h"
//#import "Item.h"
#import "ParamItem.h"
#import "IdiomItem.h"
#import "LocalizableManager.h"
#import "Constants.h"
#import "NetworkManagerReachability.h"
#import "PreferencesManager.h"

#define kTableViewCellColsIdentifier @"ColTableViewCell"
#define kTableViewCellHeight 44.0f

@interface ColsTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ColsTableViewController

- (NSMutableArray *)noCheckmarks {
    
    if (!_noCheckmarks) {
        
        _noCheckmarks = [[NSMutableArray alloc] init];
    }
    
    return _noCheckmarks;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super  viewDidDisappear:animated];
    
    __weak ColsTableViewController *wkself = self;
    
    if (wkself.paramId) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"boolseleccion == YES"];
        
        __weak NSArray *selecteds = [wkself.data filteredArrayUsingPredicate:predicate];
        
        NSArray *selectedIds = [selecteds valueForKey:@"idparametrodetalle"];
        
        predicate = [NSPredicate predicateWithFormat:@"SELF == \"0\""];
        
        __weak NSArray *selectedsZero = [selectedIds filteredArrayUsingPredicate:predicate];
        
        if (selectedsZero.count > 0) {
            
            selectedIds = selectedsZero;
        }
        
        
        [wkself requestPostUpdateParamsWithParamId:wkself.paramId paramDetailIds:selectedIds completion:^(NSInteger responseCodeData, NSError *error) {
            
            [wkself successRequestWithResponseCodeData:responseCodeData error:error];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.headerTitleLabel.text = [[LocalizableManager localizedString:self.titleLocalizedString] uppercaseString];
}

- (void)updateSelectedColumns {
    
    __weak ColsTableViewController *wkself = self;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == YES"];
    
    __weak NSArray *selecteds = [wkself.data filteredArrayUsingPredicate:predicate];
    
    [[PreferencesManager class] setSelectedColumnsWithIsPortrait:UIInterfaceOrientationIsPortrait(wkself.currentInterfaceOrientation) data:selecteds];
}

#pragma mark - Fetch Request

- (void)requestPostUpdateParamsWithParamId:(NSString *)paramId paramDetailIds:(NSArray *)paramDetailIds completion:(void (^)(NSInteger responseCodeData, NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [country uppercaseString], kUrlPathParamApiParamsUpdate_idpais,
                                  userId, kUrlPathParamApiParamsUpdate_idusuario,
                                  paramId,kUrlPathParamApiParamsUpdate_idparametro,
                                  [paramDetailIds componentsJoinedByString:@"*"],kUrlPathParamApiParamsUpdate_idparametrodetalle,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability postUpdateSettingsParamsWithPostDict:postDataDict completion:^(NSInteger responseCodeData, NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(responseCodeData, error);
                    }
                    else {
                        
                        [NetworkManagerReachability postUpdateSettingsParamsWithPostDict:postDataDict completion:^(NSInteger responseCodeData, NSError *error) {
                            
                            if (completion) completion(responseCodeData, error);
                        }];
                        
                    }
                }];
            }
            else {
                
                if (completion) completion(responseCodeData, error);
            }
        }
        else {
            
            if (completion) completion(responseCodeData, error);
        }
    }];
}

- (void)successRequestWithResponseCodeData:(NSInteger)responseCodeData error:(NSError *)error {

    //success
    
    __weak ColsTableViewController *wkself = self;
    
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
        
        if (responseCodeData == 0) {
            
            [wkself dispatchOnMainQueue:^{
                
                [[wkself.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    obj.accessoryType = UITableViewCellAccessoryNone;
                }];
                
                __weak UITableViewCell *cell = [wkself.tableView cellForRowAtIndexPath:wkself.tableView.indexPathForSelectedRow];
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellColsIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    __weak Item *item = [self.data objectAtIndex:indexPath.row];
    
    if ([item isKindOfClass:[ParamItem class]]) {
    
        cell.textLabel.text = [(ParamItem *)item nombre];
        
        [cell setAccessoryType:([[(ParamItem *)item boolseleccion] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];
    }
    else if ([item isKindOfClass:[IdiomItem class]]) {
        
        cell.textLabel.text = [(IdiomItem *)item nombreidioma];
        [cell setAccessoryType:([item.selected boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];
    }
    else if ([item isKindOfClass:[Item class]]) {
        
        cell.textLabel.text = item.title;
        [cell setAccessoryType:([item.selected boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];
    }
            
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak ColsTableViewController *wkself = self;
    
    __weak UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    __weak Item *item = [wkself.data objectAtIndex:indexPath.row];

    if ([item isKindOfClass:[ParamItem class]]) {
    
        __weak ParamItem *paramItem = (ParamItem *)item;
        
        BOOL boolseleccion = [paramItem.boolseleccion boolValue];
        
        
        if (![paramItem.idparametro isEqualToString:kParamIdNotiType]) {
            
            [wkself.data makeObjectsPerformSelector:@selector(setBoolseleccion:) withObject:[NSNumber numberWithBool:NO]];
            
            [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.accessoryType = UITableViewCellAccessoryNone;
            }];
        }
        else {
           
            if ([paramItem.idparametrodetalle isEqualToString:@"0"]) {
                
                [wkself.data makeObjectsPerformSelector:@selector(setBoolseleccion:) withObject:[NSNumber numberWithBool:!boolseleccion]];
                
                [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    obj.accessoryType = !boolseleccion ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
                }];
            }
            else {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:[[NSString alloc] initWithFormat:@"idparametrodetalle == %@", @"\"0\""]];
                
                __weak ParamItem *allParamItem = [[wkself.data filteredArrayUsingPredicate:predicate] lastObject];
                
                allParamItem.boolseleccion = [NSNumber numberWithBool:NO];
                
                NSIndexPath *indexPathAllParamItem = [NSIndexPath indexPathForRow:[wkself.data indexOfObject:allParamItem] inSection:0];
                
                __weak UITableViewCell *cellAllParamItem = [tableView cellForRowAtIndexPath:indexPathAllParamItem];
                
                cellAllParamItem.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
        paramItem.boolseleccion = [NSNumber numberWithBool:!boolseleccion];
        cell.accessoryType = !boolseleccion ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    else if ([item isKindOfClass:[IdiomItem class]]) {
        
        __weak IdiomItem *idiomItem = (IdiomItem *)item;
        
        [[tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.accessoryType = UITableViewCellAccessoryNone;
        }];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [PreferencesManager setPreferencesString:idiomItem.ididioma forKey:kPrefsKeyLang];
        [PreferencesManager setPreferencesString:idiomItem.nombreidioma forKey:kPrefsKeyLangName];
        
        [wkself setupLabels];
    }
    else if ([item isKindOfClass:[Item class]]) {
        
        if ([item.selected boolValue]) {
            
            item.selected = [NSNumber numberWithBool:NO];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            [wkself.noCheckmarks addObject:item];
        }
        else {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == YES"];
            
            __weak NSArray *selecteds = [wkself.data filteredArrayUsingPredicate:predicate];
            
            NSUInteger maxSelectRow = UIInterfaceOrientationIsPortrait(wkself.currentInterfaceOrientation) ? ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 3 : 5) : 5;
            
            if (selecteds.count < maxSelectRow) {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                item.selected = [NSNumber numberWithBool:YES];
                
                wkself.refreshParent = ![wkself.noCheckmarks containsObject:item];
                
                [wkself.noCheckmarks removeLastObject];
            }
            else {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_showNumberColumns5"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
        }
    }
}

@end
