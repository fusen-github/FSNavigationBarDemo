//
//  ViewController.m
//  FSNavigationBarDemo
//
//  Created by 四维图新 on 16/3/25.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSQQZoneController.h"
#import "UINavigationBar+Extension.h"

#define kImageHeight 230

#define kNavBarNorColor [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

#define kHeight 50

@interface FSQQZoneController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIActivityIndicatorView *actityView;

@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSQQZoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++)
    {
        [array addObject:@"fusen"];
    }
    
    self.dataArray = [array copy];
    
    [self setupTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
    
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:nil action:NULL];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:nil action:NULL];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBarBackgroundColorIsClearColor];
    
    [self setupTitleView];
}


- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    
    self.navigationItem.titleView = titleView;
    
    UIActivityIndicatorView *actityView = [[UIActivityIndicatorView alloc] init];
    
    actityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    self.actityView = actityView;
    
    [actityView sizeToFit];
    
    actityView.hidesWhenStopped = YES;
    
    
    [titleView addSubview:actityView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.text = @"好友动态";
    
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleLabel sizeToFit];
    
    [titleView addSubview:titleLabel];
    
    titleView.frame = CGRectMake(0, 0, actityView.bounds.size.width + titleLabel.bounds.size.width + 30, 44);
    
    actityView.frame = CGRectMake(0, (titleView.bounds.size.height - actityView.bounds.size.height) * 0.5, actityView.bounds.size.width, actityView.bounds.size.height);
    
    titleLabel.frame = CGRectMake(CGRectGetMaxX(actityView.frame) + 5, (44 - titleLabel.frame.size.height) * 0.5, titleLabel.bounds.size.width, titleLabel.bounds.size.height);
}

- (void)setupTableView
{
    CGRect frame = CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.height + 64);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    
    self.tableView = tableView;
    
    tableView.contentInset = UIEdgeInsetsMake(kImageHeight, 0, 0, 0);
    
    tableView.sectionHeaderHeight = kImageHeight;
    
    tableView.showsVerticalScrollIndicator = NO;
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHeight, self.view.bounds.size.width, kImageHeight)];
    
    self.imageView = imageView;
    
    imageView.userInteractionEnabled = YES;
    
    UIImage *img = [UIImage imageNamed:@"bg"];
    
    imageView.image = img;
    
    [tableView addSubview:imageView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"fs--%ld",self.dataArray.count - indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > kHeight - kImageHeight)
    {
        CGFloat alpha = MIN(1, ((offsetY + kImageHeight) / kHeight) - 1);
        
        [self.navigationController.navigationBar setBarOverlayBackgroundColor:[kNavBarNorColor colorWithAlphaComponent:alpha]];
    }
    else
    {
        if (offsetY < (-kImageHeight - 64))
        {
            CGRect frame = self.imageView.frame;
            
            frame.origin.y = offsetY + 64;
            
            frame.size.height = fabs(offsetY + 64);
            
            self.imageView.frame = frame;
            
            self.tableView.sectionHeaderHeight += fabs(offsetY);
            
            if (offsetY < (-kImageHeight - 150))
            {
                [self.actityView startAnimating];
                
                [self requestData];
            }
        }
        
        [self.navigationController.navigationBar setBarOverlayBackgroundColor:[UIColor clearColor]];
    }
    
}

- (void)requestData
{
    if (!self.isLoading)
    {
        self.isLoading = YES;
        
        NSLog(@"正在请求网络，加载数据");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
            
            for (int i = 0; i < 5; i++)
            {
                [array addObject:@"fusen"];
            }
            
            self.dataArray = [array copy];
            
            [self.tableView reloadData];
            
            [self.actityView stopAnimating];
            
            self.isLoading = NO;
        });
    }
}



@end
