//
//  CustomPageViewController.m
//  sgs
//
//  Created by Rone Loza on 5/15/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "CustomPageViewController.h"
#import "BaseViewController.h"
#import "MenuDetailInfoViewController.h"
#import "LocalizableManager.h"
#import "Item.h"
#import "AttachmentViewController.h"
#import "Constants.h"
#import "OfficeViewController.h"

@interface CustomPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pager;
@property (nonatomic, strong) NSMutableDictionary *viewControllers;

@end

@implementation CustomPageViewController

- (NSMutableDictionary *)viewControllers {
    
    if (!_viewControllers) {
        
        _viewControllers = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return _viewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak CustomPageViewController *wkself = self;
    
    wkself.currentPage = -1;
    
    if ([wkself.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        wkself.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    wkself.pager = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    wkself.pager.dataSource = wkself;
    wkself.pager.delegate = wkself;
    
    [wkself.pager willMoveToParentViewController:wkself];
    [wkself addChildViewController:wkself.pager];
    
    wkself.pager.view.translatesAutoresizingMaskIntoConstraints = NO;
    [wkself.contentPageView addSubview:wkself.pager.view];
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:wkself.pager.view, @"pager", nil];
    
    [wkself.contentPageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pager]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [wkself.contentPageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pager]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [wkself.pager didMoveToParentViewController:wkself];
    
    [wkself.titleSegmented setSelectedSegmentIndex:wkself.index];
    
    [wkself scrollToPage:wkself.index animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setupLabels {
//    
//    self.title = @"sdfsd";
//}

- (void)setupLabels {
    
    [super setupLabels];
    
    __weak CustomPageViewController *wkself = self;
    
    for (__weak Item *item in wkself.items) {
        
        [wkself.titleSegmented setTitle:[[LocalizableManager localizedString:item.title] capitalizedString] forSegmentAtIndex:[self.items indexOfObject:item]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated
{
    __weak CustomPageViewController *wkself = self;
    
    if (page != wkself.currentPage) {
        
        [wkself.pager setViewControllers:[[NSArray alloc] initWithObjects:[wkself viewControllerAtIndex:page], nil]
                       direction:(page > wkself.currentPage ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse)
                        animated:animated
                      completion:nil];
    }
    
    wkself.currentPage = page;
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    
    __weak CustomPageViewController *wkself = self;
    
    if (index < 0)
    {
        return nil;
    }
    else if (index >= [wkself.items count])
    {
        return nil;
    }
    
    __weak Item *item = [wkself.items objectAtIndex:index];
    
    NSString *key = [[NSString alloc] initWithFormat:@"%d", index];
    
    __weak BaseViewController *viewController = [wkself.viewControllers valueForKey:key];
    
    if (!viewController) {
        
        BaseViewController *vc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, item.storyBoardId);
        
        vc.model = item;
        
        [wkself.viewControllers setObject:vc forKey:key];
        
        viewController = vc;
    }
    
    if ([viewController isKindOfClass:[BaseViewController class]]) {
    
        [(BaseViewController *)viewController setIndex:index];
    }
    
    if ([viewController isKindOfClass:[MenuDetailInfoViewController class]]) {
        
//        [(MenuDetailInfoViewController *)viewController setItem:(MenuDetailItem *)item];
    }
    else if ([viewController isKindOfClass:[AttachmentViewController class]]) {
        
//        [(AttachmentViewController *)viewController setItem:(MenuDetailItem *)item];
    }
    
    viewController.pgvc = wkself;
    viewController.titleLocalizedString = wkself.titleLocalizedString;
    
    return viewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    __weak BaseViewController *p = (BaseViewController *)viewController;
    
    return [self viewControllerAtIndex:(p.index - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    __weak BaseViewController *p = (BaseViewController *)viewController;
    
    return [self viewControllerAtIndex:(p.index + 1)];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
//    [self removeBarButtonItems];
    self.nextViewController = (BaseViewController*)[pendingViewControllers firstObject];
    
    [self.titleSegmented setSelectedSegmentIndex:self.nextViewController.index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        
        self.currentViewController = self.nextViewController;
        self.currentPage = self.nextViewController.index;
        
//        [self viewShown];
    }
    
//    if (self.currentViewController.canShare)
//    {
//        [self addShareBarButtonItem];
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//    }
//    else
//    {
//        [self removeBarButtonItems];
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
    
//    if (self.currentViewController.adShown) {
//        
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
    
    self.nextViewController = nil;
}

#pragma mark - IBActions

- (IBAction)titleSegmentedValueChanged:(UISegmentedControl *)sender {
    
    [self scrollToPage:sender.selectedSegmentIndex animated:YES];
}

- (void)refreshBarButtonPressed:(id)sender {
    
    NSString *key = [[NSString alloc] initWithFormat:@"%d", self.currentPage];
    
    __weak BaseViewController *vc = [self.viewControllers valueForKey:key];
    
    [vc refreshBarButtonPressed:sender];
}

@end
