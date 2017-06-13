//
//  AttachmentViewController.m
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "AttachmentViewController.h"
#import "FileWebViewController.h"
#import "Constants.h"
#import "SectionItem.h"
#import "AttachItem.h"
#import "NotificationAttachItem.h"
#import "NotificationItem.h"
#import "MenuDetailItem.h"
#import "TabCollectionViewCell.h"
#import "ThumbCollectionViewCell.h"
#import "PreferencesManager.h"
#import "NetworkManagerReachability.h"
#import "UIAlertViewManager.h"
#import "LocalizableManager.h"
#import "PhotoViewController.h"
#import "TitleCollectionReusableView.h"
#import "DownloadActivity.h"
#import "ShowFileActivity.h"
#import "ShareManager.h"
#import "FileManager.h"
#import "CustomPageViewController.h"

#define kTabCollectionViewCell @"TabCollectionViewCell"
#define kThumbCollectionViewCell @"ThumbCollectionViewCell"
#define kThumbCollectionReusableViewCell @"TitleCollectionReusableView"

@interface AttachmentViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIDocumentInteractionControllerDelegate>

/*
 *@brief NSArray of *SectionItem
 */

@property (nonatomic, strong) NSArray *data;
/**
 *@brief NSArray of *NSString
 **/
@property (nonatomic, strong) NSArray *itemsTypes;
/**
 *@brief NSArray of *AttachItem
 **/
@property (nonatomic, strong) NSArray *itemsForTypes;

@property (nonatomic, strong) UIDocumentInteractionController *documentController ;
@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    
//    [self.tabCollectionView registerClass:[TabCollectionViewCell class] forCellWithReuseIdentifier:kTabCollectionViewCell];
//    [self.thumbCollectionView registerClass:[ThumbCollectionViewCell class] forCellWithReuseIdentifier:kThumbCollectionViewCell];
    
    [UIAlertViewManager progressHUDSetMaskBlack];    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self refreshBarButtonPressed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.tabCollectionView.contentInset = UIEdgeInsetsZero;
    self.tabCollectionView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
    self.thumbCollectionView.contentInset = UIEdgeInsetsZero;
    self.thumbCollectionView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
//    self.thumbCollectionView.frame = CGRectMake(0, 0, 200, 379);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

//    NSInteger numberOfSections = ([[self.itemsForTypes lastObject] isKindOfClass:[NSArray class]] ? self.itemsForTypes.count : 1);
    
    NSInteger numberOfSections = 1;
    
    if (collectionView.tag == 100) {
        
        numberOfSections = 1;
    }
    else {
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
        
            numberOfSections = self.itemsForTypes.count;
        }
        else {
            
            numberOfSections = 1;
        }
    }
    
    return numberOfSections;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *headerTitle = @"";
    
    if (collectionView.tag == 100) {
        
        headerTitle = @"";
    }
    else {
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [self.itemsForTypes objectAtIndex:indexPath.section];
            
            headerTitle = sectionItem.title;
        }
        else {
            
            headerTitle = @"";
        }
    }
    
    TitleCollectionReusableView *header = (TitleCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kThumbCollectionReusableViewCell forIndexPath:indexPath];
    
    header.titleLabel.text = headerTitle;
    
    return header;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSInteger numberOfItemsInSection = 0;
    
    if (collectionView.tag == 100) {
        
        numberOfItemsInSection = self.itemsTypes.count;
    }
    else {
     
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [self.itemsForTypes objectAtIndex:section];
            
            numberOfItemsInSection = sectionItem.items.count;
        }
        else {
            
            numberOfItemsInSection = self.itemsForTypes.count;
        }
    }
    
    return numberOfItemsInSection;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize sizeForHeaderInSection = CGSizeZero;
    
    if (collectionView.tag == 100) {
        
        sizeForHeaderInSection = CGSizeZero;
    }
    else {
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            sizeForHeaderInSection = CGSizeMake(44.0f, 44.0f);
        }
        else {
            
            sizeForHeaderInSection = CGSizeZero;
        }
    }
    
    return sizeForHeaderInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(collectionView.tag == 100 ? kTabCollectionViewCell : kThumbCollectionViewCell)forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[TabCollectionViewCell class]]) {
        
        __weak NSString *type = [self.itemsTypes objectAtIndex:indexPath.item];
        
        TabCollectionViewCell *tabCell = (TabCollectionViewCell *)cell;
        
        tabCell.tabLabel.text = type;
        
        cell = tabCell;
    }
    else if ([cell isKindOfClass:[ThumbCollectionViewCell class]]) {
        
        __weak AttachItem *item = nil;
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [self.itemsForTypes objectAtIndex:indexPath.section];
            item = [sectionItem.items objectAtIndex:indexPath.item];
        }
        else {
         
            item = [self.itemsForTypes objectAtIndex:indexPath.item];
        }
        
        ThumbCollectionViewCell *thumbCell = (ThumbCollectionViewCell *)cell;
        
        thumbCell.lockButton.hidden = ![item.boolseguridad boolValue];
        thumbCell.thumbNameLabel.numberOfLines = 2;
        thumbCell.thumbNameLabel.text = item.nombreadjunto;
        
        NSString *ext = [[item.nombreadjunto pathExtension] lowercaseString];
        
        NSString *imageNamed = @"ic_file";
        
        if ([ext rangeOfString:@"png"].location != NSNotFound ||
            [ext rangeOfString:@"jpg"].location != NSNotFound ||
            [ext rangeOfString:@"bmp"].location != NSNotFound ||
            [ext rangeOfString:@"gif"].location != NSNotFound ||
            [ext rangeOfString:@"tiff"].location != NSNotFound) {
            
            imageNamed = @"ic_file_image";
        }
        else if ([ext rangeOfString:@"pdf"].location != NSNotFound) {
            
            imageNamed = @"ic_file_pdf";
        }
        else if ([ext rangeOfString:@"mp3"].location != NSNotFound) {
            
            imageNamed = @"ic_file_audio";
        }
        else if ([ext rangeOfString:@"zip"].location != NSNotFound) {
            
            imageNamed = @"ic_file_compress";
        }
        else if ([ext rangeOfString:@"xls"].location != NSNotFound) {
            
            imageNamed = @"ic_file_excel";
        }
        else if ([ext rangeOfString:@"doc"].location != NSNotFound) {
            
            imageNamed = @"ic_file_word";
        }
        else if ([ext rangeOfString:@"ppt"].location != NSNotFound) {
            
            imageNamed = @"ic_file_ppt";
        }
        else if ([ext rangeOfString:@"txt"].location != NSNotFound) {
            
            imageNamed = @"ic_file_txt";
        }
        else if ([ext rangeOfString:@"mp4"].location != NSNotFound ||
                 [ext rangeOfString:@"avi"].location != NSNotFound ||
                 [ext rangeOfString:@"mpeg"].location != NSNotFound ||
                 [ext rangeOfString:@"qt"].location != NSNotFound ||
                 [ext rangeOfString:@"qt"].location != NSNotFound) {
            
            imageNamed = @"ic_file_video";
        }
        
        NSData *imageData = [self dataFromBase64EncodedString:item.imgadjunto];
        
        thumbCell.imageView.image = (item.imgadjunto.length > 0  ?
                                     [UIImage imageWithData:imageData] :
                                     [UIImage imageNamed:imageNamed]);
        
        cell = thumbCell;
    }
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    __weak AttachmentViewController *wkself = self;
    
    if (collectionView == wkself.tabCollectionView) {
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    
        if (indexPath.item == 0) {
            
//            if (self.data.count >= 10) {
            
                NSSet *filteredData = [NSSet setWithArray:[wkself.data valueForKey:@"nombregrupo"]];
                
                NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (__weak NSString *group in filteredData) {
                    
                    NSArray *groups = [wkself.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"nombregrupo MATCHES %@", group]];
                    
                    SectionItem *section = [[SectionItem alloc] initWithTitle:group selected:NO items:groups];
                    
                    [data addObject:section];
                }
                
                wkself.itemsForTypes = data;
//            }
//            else {
//                
//                wkself.itemsForTypes = wkself.data;
//            }
        }
        else {
         
            __weak NSString *itemType = [wkself.itemsTypes objectAtIndex:indexPath.item];
            
            NSArray *subData = [wkself.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tipoadjunto MATCHES %@", itemType]];
            
            NSSet *filteredData = [NSSet setWithArray:[subData valueForKey:@"nombregrupo"]];
            
            NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (__weak NSString *group in filteredData) {
                
                NSArray *groups = [subData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"nombregrupo MATCHES %@", group]];
                
                SectionItem *section = [[SectionItem alloc] initWithTitle:group selected:NO items:groups];
                
                [data addObject:section];
            }
            
            wkself.itemsForTypes = data;
        }
        
        [wkself.thumbCollectionView reloadData];
    }
    else if (collectionView == wkself.thumbCollectionView) {
        
//        NotificationAttachItem
        
//        if ()
        
        __weak Item *item = nil;
        
        if ([[wkself.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [wkself.itemsForTypes objectAtIndex:indexPath.section];
            item = [sectionItem.items objectAtIndex:indexPath.item];
        }
        else {
            
            item = [wkself.itemsForTypes objectAtIndex:indexPath.item];
        }
        
        if ([item isKindOfClass:[AttachItem class]]) {
            
            [UIAlertViewManager progressHUShow];
            
            [[ShareManager class] requestWithAttach:(AttachItem *)item completion:^(AttachItem *data, NSError *error) {
                
                [wkself successAttachRequestWithData:data error:error sender:indexPath];
            }];
        }
        else if ([item isKindOfClass:[NotificationAttachItem class]]) {
            
            [[ShareManager class] requestWithNotificationAttach:(NotificationAttachItem *)item completion:^(NotificationAttachItem *data, NSError *error) {
                
                [wkself successAttachRequestWithData:data error:error sender:indexPath];
            }];
        }
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Network

- (void)requestAttachmentsWithMenuDetailItem:(MenuDetailItem *)item completion:(void(^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamListAttach_ididioma,
                                  [country uppercaseString], kUrlPathParamListAttach_idpais,
                                  userId, kUrlPathParamListAttach_idusuario,
                                  item.idmenu, kUrlPathParamListAttach_idmenu,
                                  item.idmenudetalle, kUrlPathParamListAttach_idmenudetalle,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getAttachmentsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getAttachmentsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                    }
                }];
            }
            else  {
                
               if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}

- (void)successRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak AttachmentViewController *wkself = self;
    
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
            
            wkself.data = data;
            
            NSSet *filteredData = [NSSet setWithArray:[data valueForKey:@"tipoadjunto"]];
            
            wkself.itemsTypes = [[[NSArray alloc] initWithObjects:[[LocalizableManager localizedString:@"lbl_all"] capitalizedString], nil] arrayByAddingObjectsFromArray:[filteredData allObjects]];
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself.tabCollectionView reloadData];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                
                [wkself.tabCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:(UICollectionViewScrollPositionCenteredVertically)];
                
                [wkself collectionView:wkself.tabCollectionView didSelectItemAtIndexPath:indexPath];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
                
                if (data.count == 0) {
                    
                    [wkself.pgvc.titleSegmented setEnabled:NO forSegmentAtIndex:wkself.index];
                    [wkself.pgvc.titleSegmented setSelectedSegmentIndex:0];
                    [wkself.pgvc scrollToPage:0 animated:YES];
                }
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

- (void)requestNotificatiomAttachmentsWithNotificationItem:(NotificationItem *)item completion:(void(^)(NSArray *data , NSError *error))completion {
    
    NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
    NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
    NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
    
    NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [lang uppercaseString], kUrlPathParamNotiListAttach_ididioma,
                                  [country uppercaseString], kUrlPathParamNotiListAttach_idpais,
                                  userId, kUrlPathParamNotiListAttach_idusuario,
                                  item.idnotificacion, kUrlPathParamNotiListAttach_idnotificacion,
                                  nil];
    
    [UIAlertViewManager progressHUShow];
    
    [NetworkManagerReachability getNotificationAttachmentsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
        
        if (error) {
            
            if (error.code == kCFURLErrorUserCancelledAuthentication) {
                
                [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                    
                    if (error) {
                        
                        if (completion) completion(data, error);
                    }
                    else {
                        
                        [NetworkManagerReachability getNotificationAttachmentsWithPostDict:postDataDict completion:^(NSArray *data , NSError *error) {
                            
                            if (completion) completion(data, error);
                        }];
                    }
                }];
            }
            else  {
                
                if (completion) completion(data, error);
            }
        }
        else {
            
            if (completion) completion(data, error);
        }
    }];
}

- (void)successNotificationRequestWithData:(NSArray *)data error:(NSError *)error {
    
    __weak AttachmentViewController *wkself = self;
    
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
            
            wkself.data = data;
            
            NSSet *filteredData = [NSSet setWithArray:[data valueForKey:@"tipoadjunto"]];
            
            wkself.itemsTypes = [[[NSArray alloc] initWithObjects:[[LocalizableManager localizedString:@"lbl_all"] capitalizedString], nil] arrayByAddingObjectsFromArray:[filteredData allObjects]];
            
            [wkself dispatchOnMainQueue:^{
                
                [wkself.tabCollectionView reloadData];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                
                [wkself.tabCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:(UICollectionViewScrollPositionCenteredVertically)];
                
                [wkself collectionView:wkself.tabCollectionView didSelectItemAtIndexPath:indexPath];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
    }
}

- (void)successAttachRequestWithData:(Item *)data error:(NSError *)error sender:(id)sender {
    
    __weak AttachmentViewController *wkself = self;
    
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
            
            AttachItem *attachItem = (AttachItem *)data;
            
            NSURL *urlFile = [[FileManager class] appendPathComponentAtDocumentDirectory:[kFolderNameAttachments stringByAppendingPathComponent:attachItem.nombreadjunto]];
            
            NSData *fileContent = (attachItem.fileContent.length > 0 ? attachItem.fileContent : [wkself dataFromBase64EncodedString:attachItem.archivoadjunto]);
            
            [[FileManager class] writeData:fileContent atFilePath:urlFile.path];
            
            [wkself dispatchOnMainQueue:^{
                
                //                        wkself.documentController = [UIDocumentInteractionController interactionControllerWithURL:urlFile];
                
                //                        com.adobe.pdf (kUTTypePDF) public.data, public.composite-​content 'PDF ', .pdf, application/pdf, Apple PDF pasteboard type PDF data.
                //                        com.microsoft.word.v public.data 'W8BN', .doc, application/msword Microsoft Word data.
                //                        com.microsoft.excel.xls public.data 'XLS8', .xls, application/vnd.ms-excel Microsoft Excel data.
                
                //                        NSString *ext = [urlFile pathExtension];
                //
                //                        wkself.documentController.UTI = ([ext rangeOfString:@"pdf" options:NSCaseInsensitiveSearch].location != NSNotFound ?
                //                                                         @"com.adobe.pdf" :
                //                                                         ([ext rangeOfString:@"xls" options:NSCaseInsensitiveSearch].location != NSNotFound ?  @"com.microsoft.excel.xls" :
                //                                                           ([ext rangeOfString:@"doc" options:NSCaseInsensitiveSearch].location != NSNotFound ?  @"com.microsoft.word.doc" : nil)));
                //
                //                        wkself.documentController.delegate = wkself;
                //
                //                        [wkself.documentController presentOpenInMenuFromRect:CGRectZero inView:wkself.view animated:YES];
                
                [wkself performSegueWithIdentifier:@"segue_to_fileweb" sender:sender];
                
            }];
            
            [UIAlertViewManager progressHUDDismissWithCompletion:nil];
        }
        else {
            
            [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
        }
        
    }
}

- (void)refreshBarButtonPressed:(id)sender {
    
    __weak AttachmentViewController *wkself = self;
    
    if ([wkself.model isKindOfClass:[MenuDetailItem class]]) {
     
        [wkself requestAttachmentsWithMenuDetailItem:(MenuDetailItem *)wkself.model completion:^(NSArray *data, NSError *error) {
            
            [wkself successRequestWithData:data error:error];
        }];
    }
    else if ([wkself.model isKindOfClass:[NotificationItem class]]) {
        
        [wkself requestNotificatiomAttachmentsWithNotificationItem:(NotificationItem *)wkself.model completion:^(NSArray *data, NSError *error) {
            
            [wkself successNotificationRequestWithData:data error:error];
        }];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_to_photo"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        __weak AttachItem *item = nil;
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [self.itemsForTypes objectAtIndex:indexPath.section];
            item = [sectionItem.items objectAtIndex:indexPath.item];
        }
        else {
            
            item = [self.itemsForTypes objectAtIndex:indexPath.item];
        }
        
        __weak PhotoViewController *vc = segue.destinationViewController;
        vc.model = item;
        
        vc.titleLocalizedString = item.nombreadjunto;
        
        __weak ThumbCollectionViewCell *cell = (ThumbCollectionViewCell *)[self.thumbCollectionView cellForItemAtIndexPath:indexPath];
        
        vc.image = cell.imageView.image;
    }
    else if ([segue.identifier isEqualToString:@"segue_to_fileweb"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        __weak AttachItem *item = nil;
        
        if ([[self.itemsForTypes lastObject] isKindOfClass:[SectionItem class]]) {
            
            __weak SectionItem *sectionItem = [self.itemsForTypes objectAtIndex:indexPath.section];
            item = [sectionItem.items objectAtIndex:indexPath.item];
        }
        else {
            
            item = [self.itemsForTypes objectAtIndex:indexPath.item];
        }
        
        
        NSURL *urlFile = [[FileManager class]
                          appendPathComponentAtDocumentDirectory:[kFolderNameAttachments stringByAppendingPathComponent:item.nombreadjunto]];
        
        __weak FileWebViewController *vc = segue.destinationViewController;
        
        vc.urlFile = urlFile;
        
        vc.titleLocalizedString = item.nombreadjunto;
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
    self.documentController = nil;
}

@end
