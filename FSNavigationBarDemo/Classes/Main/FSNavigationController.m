//
//  FSNavigationController.m
//  FSNavigationBarDemo
//
//  Created by 四维图新 on 16/3/26.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSNavigationController.h"

@interface FSNavigationController ()

@end

@implementation FSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.childViewControllers.lastObject;
}





@end
