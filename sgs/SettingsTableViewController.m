//
//  SettingsViewController.m
//  sgs
//
//  Created by Rone Loza on 5/5/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "LocalizableManager.h"
#import "PreferencesManager.h"
#import "NetworkManagerReachability.h"
#import "SectionItem.h"
#import "ParamItem.h"
#import "IdiomItem.h"
#import "Constants.h"
#import "UIAlertViewManager.h"
#import "ColsTableViewController.h"
#import "SwitchTableViewCell.h"
#import <libkern/OSAtomic.h>

@interface SettingsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;
@end

@implementation SettingsTableViewController

volatile int32_t _count;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    self.titleLocalizedString = @"tab_settings_label";
    
    SectionItem *item1 = [[SectionItem alloc] initWithTitle:@"row_type_label" selected:NO];
    item1.storyBoardId = kParamIdNotiType;
    
    SectionItem *section1 = [[SectionItem alloc] initWithTitle:@"sec_noti_label" selected:NO items:[[NSArray alloc] initWithObjects:item1, nil]];
    
    SectionItem *item2 = [[SectionItem alloc] initWithTitle:@"row_noti_label" selected:NO];
    item2.storyBoardId = kParamIdNotiDays;
    
    SectionItem *item3 = [[SectionItem alloc] initWithTitle:@"row_menu_label" selected:NO];
    item3.storyBoardId = kParamIdMenuDays;
    
    SectionItem *section2 = [[SectionItem alloc] initWithTitle:@"sec_sync_label" selected:NO items:[[NSArray alloc] initWithObjects:item2, item3, nil]];
    
    BOOL useMobileData = [PreferencesManager getPreferencesBOOLForKey:kPrefUserUseMobileData];
    SectionItem *item4 = [[SectionItem alloc] initWithTitle:@"row_usedata_label" selected:useMobileData];
    
    BOOL useAttachWiFi = [PreferencesManager getPreferencesBOOLForKey:kPrefUserUseAttachWifi];
    SectionItem *item5 = [[SectionItem alloc] initWithTitle:@"row_attach_label" selected:useAttachWiFi];
    SectionItem *section3 = [[SectionItem alloc] initWithTitle:@"sec_data_label" selected:NO items:[[NSArray alloc] initWithObjects:item4, item5, nil]];
    
    SectionItem *item6 = [[SectionItem alloc] initWithTitle:@"row_lang_label" selected:NO];
    SectionItem *section4 = [[SectionItem alloc] initWithTitle:@"sec_lang_label" selected:NO items:[[NSArray alloc] initWithObjects:item6, nil]];
    
    self.data = [[NSArray alloc] initWithObjects:section1, section2, section3, section4, nil];
}

- (void)setupLabels {
    
    [super setupLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    BOOL useMobileData = [PreferencesManager getPreferencesBOOLForKey:kPrefUserUseMobileData];
    
    if (useMobileData) {
     
        [self refreshBarButtonPressed:nil];
    }
    else {
        
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    NSString *titleForHeaderInSection = [LocalizableManager localizedString:(section == 0 ? @"sec_noti_label" : (section == 1 ? @"sec_sync_label" : (section == 2 ? @"sec_data_label" : @"sec_lang_label")))];
//    
//    return titleForHeaderInSection;
//}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    __weak SectionItem *item = [self.data objectAtIndex:section];
    
    return item.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    __weak SectionItem *item = [self.data objectAtIndex:section];
    
    return [[LocalizableManager localizedString:item.title] capitalizedString];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak SettingsTableViewController *wkself = self;
    
    UITableViewCell *cell = nil;
    
    __weak SectionItem *section = [self.data objectAtIndex:indexPath.section];
    __weak SectionItem *item = [section.items objectAtIndex:indexPath.row];
    
    if (indexPath.section == 2) {
        
        SwitchTableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchTableViewCell" forIndexPath:indexPath];
        switchCell.titleLabel.text = [[LocalizableManager localizedString:item.title] capitalizedString];
        
        [switchCell.switchView setOn:[item.selected boolValue]];
        switchCell.switchView.tag = indexPath.row;
        
        [switchCell.switchView removeTarget:wkself action:@selector(switchValueChanged:) forControlEvents:(UIControlEventValueChanged)];
        
        [switchCell.switchView addTarget:wkself action:@selector(switchValueChanged:) forControlEvents:(UIControlEventValueChanged)];
        
        cell = switchCell;
    }
    else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"titleRowCell" forIndexPath:indexPath];
        
        if (indexPath.section == 3) {
            
            NSString *langName = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLangName];
            
            cell.detailTextLabel.text = langName;
        }
        else {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"boolseleccion == YES"];
            __weak NSArray *selecteds = [item.items filteredArrayUsingPredicate:predicate];
            
            __weak ParamItem *paramItem = [selecteds lastObject];
            
            NSString *detailText = (selecteds.count == item.items.count ?
            [[LocalizableManager localizedString:@"lbl_all"] capitalizedString] :
            (selecteds.count < item.items.count && selecteds.count > 1 ?
             [[LocalizableManager localizedString:@"lbl_various"] uppercaseString] :
             paramItem.nombre));
            
            cell.detailTextLabel.text = detailText;
        }
        
        cell.textLabel.text = [[LocalizableManager localizedString:item.title] capitalizedString];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 2) {
        
        [self performSegueWithIdentifier:@"segue_title_table" sender:indexPath];
    }
}

#pragma mark - FETCH Request

- (void)requestSettingsParamsWithParamId:(NSString *)paramId completion:(void (^)(NSArray *data , NSError *error))completion {
    
    OSAtomicIncrement32(&_count);
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamApiParams_ididioma,
                                  [country uppercaseString], kUrlPathParamApiParams_idpais,
                                  userId, kUrlPathParamApiParams_idusuario,
                                  paramId,kUrlPathParamApiParams_idparametro,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getSettingsParamsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getSettingsParamsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
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

- (void)successRequestWithParamId:(NSString *)paramId data:(NSArray *)data error:(NSError *)error {
    
    __weak SettingsTableViewController *wkself = self;
    

    if (error) {
        
        if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            NSIndexPath *indexPath = ([paramId isEqualToString:kParamIdNotiType] ? [NSIndexPath indexPathForRow:0 inSection:0] :
                                      ([paramId isEqualToString:kParamIdNotiDays] ? [NSIndexPath indexPathForRow:0 inSection:1] :
                                       [NSIndexPath indexPathForRow:1 inSection:1]));
            
            __weak SectionItem *section = [self.data objectAtIndex:indexPath.section];
            __weak SectionItem *item = [section.items objectAtIndex:indexPath.row];
            
            /////
            
            if ([paramId isEqualToString:kParamIdNotiType]) {
             
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"boolseleccion == NO"];
                __weak NSArray *noSelecteds = [data filteredArrayUsingPredicate:predicate];
                
                ParamItem *paramItem = [[ParamItem alloc] init];
                paramItem.idparametro = @"4";
                paramItem.idparametrodetalle = @"0";
                paramItem.nombre = [[LocalizableManager localizedString:@"lbl_all"] capitalizedString];
                paramItem.boolseleccion = [NSNumber numberWithBool:noSelecteds.count == 0];
                
                item.items = [[[NSArray alloc] initWithObjects:paramItem, nil] arrayByAddingObjectsFromArray:data];
            }
            else {
             
                item.items = data;
            }
            
            ////
            
            [wkself dispatchOnMainQueue:^{
                
                //        [wkself.tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                [wkself.tableView reloadData];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    
    if(OSAtomicDecrement32(&_count) <= 0) {
        
        [UIAlertViewManager progressHUDDismissWithCompletion:nil];
    }
}

- (void)requestGetIdiomsWithCompletion:(void(^)(NSArray *data, NSError *error))completion {
    
    OSAtomicIncrement32(&_count);
    
    __weak SettingsTableViewController *wkself = self;
    
    [UIAlertViewManager progressHUShow];
    
    Class objectClass = (wkself.tabBarController ? [NetworkManagerReachability class] : [NetworkManager class]);
    
    [objectClass getIdiomsWithCompletion:^(NSArray *data, NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [objectClass getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [objectClass getIdiomsWithCompletion:^(NSArray *data, NSError *error) {
                            
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
    
    __weak SettingsTableViewController *wkself = self;
    
    if (error) {
        
        if (error.code == kCFURLErrorNotConnectedToInternet) {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    else {
        
        if (data) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            
            __weak SectionItem *section = [self.data objectAtIndex:indexPath.section];
            __weak SectionItem *item = [section.items objectAtIndex:indexPath.row];
            
            item.items = data;
            
            NSString *langId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K CONTAINS[cd] %@)",@"ididioma", langId];
            
            __weak IdiomItem *idiomItem = [[data filteredArrayUsingPredicate:predicate] lastObject];
            
            idiomItem.selected = [NSNumber numberWithBool:YES];
            
            [wkself dispatchOnMainQueue:^{
                
                //        [wkself.tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                
                [wkself.tableView reloadData];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
    
    if(OSAtomicDecrement32(&_count) <= 0) {
        
        [UIAlertViewManager progressHUDDismissWithCompletion:nil];
    }
}

#pragma mark - IBActions

- (IBAction)switchValueChanged:(UISwitch *)sender {
    
    if (sender.tag == 0) {
     
        [PreferencesManager setPreferencesBOOL:sender.on forKey:kPrefUserUseMobileData];
    }
    else {
        
        [PreferencesManager setPreferencesBOOL:sender.on forKey:kPrefUserUseAttachWifi];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    
    __weak SectionItem *section = [self.data objectAtIndex:indexPath.section];
    __weak SectionItem *item = [section.items objectAtIndex:indexPath.row];
    
    item.selected = [NSNumber numberWithBool:sender.on];
    
}

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak SettingsTableViewController *wkself = self;
    
    [wkself requestSettingsParamsWithParamId:kParamIdNotiType completion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithParamId:kParamIdNotiType data:data error:error];
    }];
    
    [wkself requestSettingsParamsWithParamId:kParamIdNotiDays completion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithParamId:kParamIdNotiDays data:data error:error];
    }];
    
    [wkself requestSettingsParamsWithParamId:kParamIdMenuDays completion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithParamId:kParamIdMenuDays data:data error:error];
    }];
    
    [wkself requestGetIdiomsWithCompletion:^(NSArray *data, NSError *error) {
        
        [wkself successRequestWithData:data error:error];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    __weak NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    __weak SettingsTableViewController *wkself = self;
    
    if ([segue.identifier isEqualToString:@"segue_title_table"]) {
        
        __weak ColsTableViewController *vc = (ColsTableViewController *)segue.destinationViewController;
        
        __weak SectionItem *section = [wkself.data objectAtIndex:indexPath.section];
        __weak SectionItem *item = [section.items objectAtIndex:indexPath.row];
        
        vc.data = item.items;
        
        if (indexPath.section == 0) {
            
            vc.titleLocalizedString = @"title_type_noti_label";
            vc.paramId = item.storyBoardId;
        }
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                vc.titleLocalizedString = @"title_sync_noti_label";
                vc.paramId = item.storyBoardId;
            }
            else {
                
                vc.titleLocalizedString = @"title_sync_menu_label";
                vc.paramId = item.storyBoardId;
            }
            
        }
        else if (indexPath.section == 3) {
            
            vc.titleLocalizedString = @"title_lang_available_label";
        }
    }
}

@end
