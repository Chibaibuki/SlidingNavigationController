//
//  SlidingNavigationViewController.h
//  scrollViewLearning
//
//  Created by 高向孚 on 16/2/7.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SlidingNavigationViewController : UIViewController

@property (strong,nonatomic) NSArray * labelList;
@property (strong,nonatomic) NSArray * vcList;
@property(strong,nonatomic) NSMutableArray *labelWidthList;
@property (strong,nonatomic) NSMutableArray * labelViewList;

@property CGFloat statusBarHeight;
@property CGFloat naviBarHeight;
@property CGFloat gapWidth;
@property CGFloat labelSrollViewEdgeWidth;
@property CGFloat labelScrollViewY;
@property CGFloat labelMarkBarHeight;

@property (strong,nonatomic)UIScrollView * labelScrollView;
@property (strong,nonatomic)UIFont * labelFont;
@property (strong,nonatomic)UILabel * pointLabelLift;
@property (strong,nonatomic)UILabel * pointLabelRight;

@property(strong,nonatomic,readwrite)UIView *tagMarkBarView;

+ (instancetype)initWithLabelArray:(NSArray*)labelarray ViewControllerArray:(NSArray*)vcarray;
@end
