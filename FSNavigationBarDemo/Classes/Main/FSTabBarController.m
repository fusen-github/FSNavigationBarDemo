//
//  FSTabBarController.m
//  FSNavigationBarDemo
//
//  Created by 四维图新 on 16/3/26.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSTabBarController.h"
#import "FSNavigationController.h"
#import "FSQQZoneController.h"
#import "FSMoveNavBarController.h"

@interface FSTabBarController ()

@end

@implementation FSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSQQZoneController *qqZoneVC = [[FSQQZoneController alloc] init];
    
    [self setupChildViewController:qqZoneVC title:@"仿QQ"];
    
    
    FSMoveNavBarController *moveNavBarVC = [[FSMoveNavBarController alloc] init];
    
    [self setupChildViewController:moveNavBarVC title:@"平移"];
}

- (void)setupChildViewController:(UIViewController *)viewController
                           title:(NSString *)title
{
    viewController.title = title;
    
    FSNavigationController *nav = [[FSNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nav];
}


@end
