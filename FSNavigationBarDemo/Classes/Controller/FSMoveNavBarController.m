//
//  FSMoveNavBarController.m
//  FSNavigationBarDemo
//
//  Created by 四维图新 on 16/3/26.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSMoveNavBarController.h"
#import "UINavigationBar+Extension.h"

#define kNavBarNorColor [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

@interface FSMoveNavBarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSMoveNavBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];
    
    [self setupTableView];
    
}

- (void)setupNavBar
{
    [self.navigationController.navigationBar setBarTintColor:kNavBarNorColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left"
                                                                             style:0
                                                                            target:nil
                                                                            action:NULL];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right"
                                                                             style:0
                                                                            target:nil
                                                                            action:NULL];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.frame = self.view.bounds;
    
    [self.view addSubview:tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat value = offsetY + scrollView.contentInset.top;
    
    if (value > 0)
    {
        if (value > 44)
        {
            [self setNavigationBarTransformProgress:1];
        }
        else
        {
            [self setNavigationBarTransformProgress:(value / 44)];
        }
    }
    else
    {
        [self setNavigationBarTransformProgress:0];
        
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
    
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar setNavBarTranslationY:(-44 * progress)];
    
    [self.navigationController.navigationBar setNavBarElementsAlpha:(1-progress)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs--%ld",indexPath.row];
    
    return cell;
}



@end
