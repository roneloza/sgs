//
//  ECNavigationViewController.m
//  ClubSuscriptores
//
//  Created by RLoza on 11/4/14.
//  Copyright (c) 2014 Empresa Editora El Comercio. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()


@end

@implementation BaseNavigationViewController

#pragma mark - Life Cicle

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    UIInterfaceOrientationMask supportedInterfaceOrientations = [self.topViewController supportedInterfaceOrientations];
    return supportedInterfaceOrientations;
}

- (void)viewDidLoad {
    
    __weak BaseNavigationViewController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
     
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
     
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
