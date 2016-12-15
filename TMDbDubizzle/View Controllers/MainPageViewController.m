//
//  MainPageViewController.m
//  TMDbDubizzle
//
//  Created by Priyanka on 2016-12-15.
//  Copyright © 2016 Ranjan. All rights reserved.
//

#import "MainPageViewController.h"

//ViewControllers
#import "ListViewController.h"

//Networking
#import "NetworkingManager.h"

@interface MainPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    ListViewController *listViewController = [self viewControllerAtIndex:0];
    [self setViewControllers:@[listViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
    NSLog(@"----- the nav controller is: %@", self.navigationController);
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = ((ListViewController *)viewController).pageIndex;
    index++;
    if (index == 4) {
        index = 0;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {

    NSInteger index = ((ListViewController *)viewController).pageIndex;
    index--;
    if (index == -1) {
        index = 3;
    }
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - Helpers

- (ListViewController *)viewControllerAtIndex:(NSUInteger)index {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ListViewController *listViewController = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([ListViewController class])];
    [listViewController setupMovieListBasedOnMovieListType:index];
    listViewController.pageIndex = index;
    
    return listViewController;
}

@end
