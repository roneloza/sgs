//
//  DetailTableViewController.m
//  sgs
//
//  Created by rone loza on 5/30/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DataBaseManagerSqlite.h"
#import "DetailInfoItem.h"
#import "TableClause.h"
#import "Constants.h"
#import "MenuDetailTableViewCell.h"
#import "MenuDetailViewController.h"
#import "WebViewController.h"
#import "MenuDetailHeaderView.h"
#import "UIAlertViewManager.h"
#import "LocalizableManager.h"
#import "DataBaseManagerSqlite.h"
#import "TableClause.h"
#import "UIImage+Utils.h"

#define kTableViewCellIdentifierMenuDetail @"MenuDetailTableViewCell"
#define kTableViewCellHeight 44.0f

#define kTableViewCellHeaderIdentifier @"MenuDetailHeaderView"
#define kTableViewCellHeaderHeight 44.0f

#define kSegueIdentifierWeb @"segue_offile_to_web"

@interface DetailTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:kTableViewCellHeaderIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:kTableViewCellHeaderIdentifier];
    
    [UIAlertViewManager progressHUDSetMaskBlack];
    
    self.titleLocalizedString = @"tab_offline_label";
}

- (void)setupLabels {
    
    self.editBarButton.title = [[LocalizableManager localizedString:@"btn_edit_label"] capitalizedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.tableView setEditing:NO animated:YES];
}

- (void)refreshData {
    
    self.data = [DataBaseManagerSqlite selectFromClassName:NSStringFromClass([DetailInfoItem class]) where:nil];
    
    [self.tableView reloadData];
    
    self.editBarButton.enabled = (self.data.count > 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuDetailTableViewCell *cell = (MenuDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifierMenuDetail forIndexPath:indexPath];
    
    __weak DetailInfoItem *item = [self.data objectAtIndex:indexPath.row];
    
    cell.iconImageView.image = nil;
    cell.alertImageView.image = nil;
    
    cell.labelContentView.backgroundColor = UIColorFromHex(kColorCellDetail, 1.0f);
    cell.iconImageContentView.backgroundColor = UIColorFromHex(kColorCellDetail, 1.0f);
    
    cell.iconImageView.image = (item.iconooffline.length > 0  ? [UIImage imageWithData:[self dataFromBase64EncodedString:item.iconooffline]] : [UIImage imageNamed:@"ic_menu_orange" tintColor:[UIColor lightGrayColor]]);
    
    float width = (self.tableView.bounds.size.width - (43.0f + 24.0f));
    
    Item *item1 = [[Item alloc] initWithTitle:item.idmenu];
    item1.width = [NSNumber numberWithFloat:width * 0.25f];
    
    Item *item2 = [[Item alloc] initWithTitle:item.nombremenu];
    item2.width = [NSNumber numberWithFloat:width * 0.25f];
    
    Item *item3 = [[Item alloc] initWithTitle:item.descripcionoffline];
    item3.width = [NSNumber numberWithFloat:width * 0.5f];
    
    NSArray *cols = [[NSArray alloc] initWithObjects:item1, item2, item3, nil];
    
//    NSString *newStr = [[MenuDetailViewController class] adjustPadTextInLabel:cell.rowLabel cols:cols];
//    
//    cell.rowLabel.text = newStr;
    
    [[MenuDetailViewController class] generateLabelFromView:cell.rowContentView cols:cols font:[UIFont systemFontOfSize:13.0f] textColor:[UIColor darkGrayColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kSegueIdentifierWeb sender:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kTableViewCellHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MenuDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableViewCellHeaderIdentifier];
    
    float width = (self.tableView.bounds.size.width - (43.0f + 24.0f));
    
    Item *item1 = [[Item alloc] initWithTitle:@"ID"];
    item1.width = [NSNumber numberWithFloat:width * 0.25];
    
    Item *item2 = [[Item alloc] initWithTitle:[[LocalizableManager localizedString:@"row_type_label"] capitalizedString]];
    item2.width = [NSNumber numberWithFloat:width * 0.25];
    
    Item *item3 = [[Item alloc] initWithTitle:[[LocalizableManager localizedString:@"row_desc_label"] capitalizedString]];
    item3.width = [NSNumber numberWithFloat:width * 0.5];
    
    NSArray *cols = [[NSArray alloc] initWithObjects:item1, item2, item3, nil];
    
    [[MenuDetailViewController class] generateLabelFromView:headerView.contentLabelView cols:cols font:[UIFont boldSystemFontOfSize:13.0f] textColor:[UIColor whiteColor]];
    
//    NSString *newStr = [[MenuDetailViewController class] adjustPadTextInLabel:headerView.sectionLabel cols:cols];
//    
//    headerView.sectionLabel.text = newStr;
    
    return headerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    __weak DetailInfoItem *item = [self.data objectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSArray *where = [[NSArray alloc] initWithObjects:
                           [[TableClause alloc] initWithKey:@"rowid" value:item.rowid operatorCondition:@"=" operatorExpression:nil],
                           nil];
        
        [[DataBaseManagerSqlite class] deleteFromClassName:NSStringFromClass([DetailInfoItem class])
                                                     where:where];
        
        self.data = [DataBaseManagerSqlite selectFromClassName:NSStringFromClass([DetailInfoItem class]) where:nil];
        
        [tableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[LocalizableManager localizedString:@"btn_delete_label"] capitalizedString];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    __weak DetailInfoItem *item = [self.data objectAtIndex:indexPath.row];
    
    if ([segue.identifier isEqualToString:kSegueIdentifierWeb]) {
        
        __weak WebViewController *vc = (WebViewController *)segue.destinationViewController;
        vc.htmlBody = item.htmldetalle;
        vc.titleLocalizedString = item.idmenu;
    }
}

#pragma mark - IBActions

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {

    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    sender.title = [[LocalizableManager localizedString:(self.tableView.isEditing ? @"btn_ok_label" : @"btn_edit_label")] capitalizedString];
    
    self.deleteBarButton.title = [[LocalizableManager localizedString:(self.tableView.isEditing ? @"btn_delete_label" : @"")] capitalizedString];
    self.deleteBarButton.enabled = self.tableView.isEditing;
}

- (IBAction)deleteBarButtonPressed:(UIBarButtonItem *)sender {

    [[DataBaseManagerSqlite class] deleteFromClassName:NSStringFromClass([DetailInfoItem class])
                                                 where:nil];
    
    [self.tableView setEditing:NO animated:YES];
    
    [self refreshData];
}

@end
