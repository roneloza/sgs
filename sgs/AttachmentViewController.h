//
//  AttachmentViewController.h
//  sgs
//
//  Created by Rone Loza on 5/17/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "BaseViewController.h"

@class MenuDetailItem;

@interface AttachmentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *tabCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *thumbCollectionView;
//@property (weak, nonatomic) IBOutlet UIView *contentThumbView;

//@property (nonatomic, strong) MenuDetailItem *item;

@end
