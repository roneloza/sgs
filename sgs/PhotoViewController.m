//
//  PhotoViewController.m
//  sgs
//
//  Created by Rone Loza on 5/18/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "PhotoViewController.h"
#import "LocalizableManager.h"
#import "Constants.h"
#import "AttachItem.h"
#import "PreferencesManager.h"
#import "UIAlertViewManager.h"
#import "NetworkManagerReachability.h"
#import "ShareManager.h"
#import "FileManager.h"
#import "NSData+Base64.h"

@interface PhotoViewController ()

@property (nonatomic, weak) UIToolbar *toolbar;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak PhotoViewController *wkself = self;
    
    wkself.photoImageView.image = (wkself.image ? wkself.image : [UIImage imageWithData:wkself.imageData]);
    
    [UIAlertViewManager progressHUShow];
    
    [[ShareManager class] requestWithAttach:wkself.model completion:^(AttachItem *data, NSError *error) {
        
        if (!error) {
            
            NSURL *urlFile = [[FileManager class] appendPathComponentAtDocumentDirectory:[kFolderNameAttachments stringByAppendingPathComponent:data.nombreadjunto]];
            
            NSData *fileContent = [NSData dataFromBase64String:data.archivoadjunto];
            
            [[FileManager class] writeData:fileContent atFilePath:urlFile.path];
            
            [wkself dispatchOnMainQueue:^{
                
                wkself.photoImageView.image = (data.archivoadjunto.length > 0 ?
                                               [UIImage imageWithData:fileContent] :
                                               wkself.photoImageView.image);
                
                [wkself.photoImageView setNeedsDisplay];
                
                [UIAlertViewManager progressHUDDismissWithCompletion:nil];
            }];
        }
        else {
            
            if (error.code == kCFURLErrorNotConnectedToInternet) {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_notConnectedToInternet"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
            else {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_errorService"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_close_label"] otherButtonTitles:nil onDismiss:nil];
            }
        }
    }];
}

- (void)setupLabels {
    
    [super setupLabels];
    
    self.navigationController.navigationBar.topItem.title = @"";
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

- (IBAction)shareBarButtonPressed:(id)sender {
    
    __weak PhotoViewController *wkself = self;
    
    [[ShareManager class] shareImage:wkself.photoImageView.image inViewController:wkself completion:nil];
}

@end
