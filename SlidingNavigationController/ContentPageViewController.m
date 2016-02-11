//
//  ContentPageViewController.m
//  SlidingNavigationController
//
//  Created by 高向孚 on 16/2/8.
//  Copyright © 2016年 ByStudio. All rights reserved.
//

#import "ContentPageViewController.h"

@interface ContentPageViewController () 

@end

@implementation ContentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 473)];
    [self.contentTabelView setDelegate:self];
    [self.contentTabelView setDataSource:self];
    [self.view addSubview:self.contentTabelView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *testCell = [[UITableViewCell alloc]init];
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 33)];
    [testLabel setText:[NSString stringWithFormat:@"Hello %li%@",indexPath.row,self.title]];
    
    
    [testCell addSubview:testLabel];
    
    return testCell;
}


@end
