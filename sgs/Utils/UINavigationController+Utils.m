//
//  UINavigationController+AddOn.m
//  ElComercioMovil
//
//  Created by RLoza on 8/19/14.
//  Copyright (c) 2014 Empresa Editora El Comercio. All rights reserved.
//

#import "UINavigationController+Utils.h"

@implementation UINavigationController (Utils)

- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.viewControllers objectAtIndex:numberOfViewControllers - 2];
}

- (UIViewController *)rootViewController {
    
    NSInteger numberOfViewControllers = self.viewControllers.count;
        
        if (numberOfViewControllers < 1)
            return nil;
        else
            return [self.viewControllers objectAtIndex:numberOfViewControllers - 1];
}

@end
