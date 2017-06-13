//
//  PhotoViewController.h
//  sgs
//
//  Created by Rone Loza on 5/18/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"
@class AttachItem;

@interface PhotoViewController : BaseViewController

@property (nonatomic, weak) UIImage *image;

@property (nonatomic, strong) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
//@property (nonatomic, strong) AttachItem *item;

- (IBAction)shareBarButtonPressed:(id)sender;

@end
