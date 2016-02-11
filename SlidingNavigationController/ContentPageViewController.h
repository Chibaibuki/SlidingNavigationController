//
//  ContentPageViewController.h
//  SlidingNavigationController
//
//  Created by 高向孚 on 16/2/8.
//  Copyright © 2016年 ByStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView * contentTabelView;

@end
