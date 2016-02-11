//
//  SlidingNavigationViewController.m
//  scrollViewLearning
//
//  Created by 高向孚 on 16/2/7.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import "SlidingNavigationViewController.h"
@interface SlidingNavigationViewController () <UIScrollViewDelegate>

@end

@implementation SlidingNavigationViewController{
    CGFloat mainScreenWidth;
    CGFloat mainScreenHeight;
    
    NSInteger markTag;
    
    CGFloat originMarkX;
    CGFloat originMarkXLift;
    
    CGFloat labelScrollWid;
    CGFloat labelScrollViewOffset;
    
    CGFloat fontHeight;
    CGFloat fontWidth;
    
    NSMutableArray *labelViewArray;
    UITextField *aTextFiled;
    UIScrollView * contentPageScrollView ;
}

+ (instancetype)initWithLabelArray:(NSArray*)labelarray ViewControllerArray:(NSArray*)vcarray{
    SlidingNavigationViewController *aSlidingNavigationViewController = [[SlidingNavigationViewController alloc]init];
    
    aSlidingNavigationViewController.labelList = [[NSArray alloc]initWithArray:labelarray];
    aSlidingNavigationViewController.vcList = [[NSArray alloc]initWithArray:vcarray];

    aSlidingNavigationViewController.naviBarHeight = 100;
    aSlidingNavigationViewController.statusBarHeight  =  20;
    aSlidingNavigationViewController.labelMarkBarHeight = 1;
    aSlidingNavigationViewController.gapWidth =5;
    aSlidingNavigationViewController.labelScrollViewY = 99;
    aSlidingNavigationViewController.labelSrollViewEdgeWidth = 15;
    aSlidingNavigationViewController.labelFont = [UIFont fontWithName:@"Helvetica" size:17.f];
    
    return aSlidingNavigationViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fontHeight = [self getStringSize:@"测试ABC" font:self.labelFont].height;
    fontWidth  = [self getStringSize:@"..." font:self.labelFont].width;
    mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    mainScreenHeight = [UIScreen mainScreen].bounds.size.height;
    labelViewArray = [[NSMutableArray alloc]init];
    labelScrollViewOffset = 0;
    
    //CreatATagsWidthesList
    self.labelWidthList  = [[NSMutableArray alloc]init];
    for (int i =0; i<self.labelList.count; i++) {
        CGSize aSize = [self getStringSize:self.labelList[i] font:self.labelFont];
        NSLog(@"wid=%lf,hig=%lf",aSize.width,aSize.height);
        [self.labelWidthList addObject:[NSValue valueWithCGSize:aSize]];
    }
    
    //Creat The Navibar Background
    UIView * navigationBarBk = [[UIView alloc]initWithFrame:CGRectMake(0, self.statusBarHeight, mainScreenHeight, self.naviBarHeight)];
    [navigationBarBk setBackgroundColor:[UIColor colorWithRed:229/255.0 green:82/255.0 blue:90/255.0 alpha:1]];

    
    //Set scrollview by a typycal font
    CGFloat tagScrollViewHeight =fontHeight+self.labelMarkBarHeight;
    self.labelScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.labelSrollViewEdgeWidth,self.labelScrollViewY, mainScreenWidth-(self.labelSrollViewEdgeWidth*2),tagScrollViewHeight)];
    CGFloat tagScrollViewWidth= 0;
    
    for (int i=0; i<self.labelWidthList.count; i++) {
        tagScrollViewWidth+=[self.labelWidthList[i] CGSizeValue].width+self.gapWidth;
    }
    labelScrollWid = tagScrollViewWidth;
    [self.labelScrollView setContentSize:CGSizeMake(tagScrollViewWidth,tagScrollViewHeight)];
    [self.labelScrollView setScrollEnabled:NO];
    //Draw tags
    CGFloat originPos = 0.0;
    for (int i=0;i<self.labelList.count ; i++) {
        CGSize aTagSize = [self.labelWidthList[i] CGSizeValue];
        UIButton  * aTag = [[UIButton alloc]initWithFrame:CGRectMake(originPos,0.0, aTagSize.width, aTagSize.height)];
        originPos= originPos+aTagSize.width+self.gapWidth;
        [aTag setTag:i];
        [aTag setTitle:self.labelList[i] forState:UIControlStateNormal];
        [aTag.titleLabel setFont:self.labelFont];
        [aTag.titleLabel setTextColor:[UIColor whiteColor]];
        [aTag addTarget:self action:@selector(changeToSelectedTag:) forControlEvents:UIControlEventTouchUpInside];
        [aTag setAlpha:0.5];
        [labelViewArray addObject:aTag];
        [self.labelScrollView addSubview:aTag];
    }
    [labelViewArray[0] setAlpha:1];
    //DrawBar
    originMarkX = 0;
    originMarkXLift =[self.labelWidthList[markTag] CGSizeValue].width;
    markTag =0;
    self.tagMarkBarView = [[UIView alloc]initWithFrame:CGRectMake(originMarkX,fontHeight, [self.labelWidthList[markTag] CGSizeValue].width, self.labelMarkBarHeight)];
    [self.tagMarkBarView setBackgroundColor:[UIColor blueColor]]; //Color Of MarkBar
    [self.labelScrollView addSubview:self.tagMarkBarView];
    
    //point label
    self.pointLabelLift = [[UILabel alloc]initWithFrame:CGRectMake(0, self.labelScrollViewY, fontWidth, fontHeight)];
    [self.pointLabelLift setText:@"..."];
    [self.pointLabelLift setTextColor:[UIColor whiteColor]];
    [self.pointLabelLift setHidden:YES];
    [self.pointLabelLift setFont:self.labelFont];
    
    self.pointLabelRight = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth-fontWidth, self.labelScrollViewY, fontWidth, fontHeight)];
    [self.pointLabelRight setText:@"..."];
    [self.pointLabelRight setTextColor:[UIColor whiteColor]];
    [self.pointLabelRight setFont:self.labelFont];
    
    if (tagScrollViewWidth > mainScreenWidth-(self.labelSrollViewEdgeWidth*2)) {
        [self.pointLabelRight setHidden:NO];
    }else{
        [self.pointLabelRight setHidden:YES];
    }
    
    //ContentPageScrollView
    
    contentPageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.statusBarHeight+self.naviBarHeight, mainScreenWidth, mainScreenHeight-(self.statusBarHeight+self.naviBarHeight))];
    [contentPageScrollView setBackgroundColor:[UIColor whiteColor]];
    [contentPageScrollView setPagingEnabled:YES];
    [contentPageScrollView setScrollEnabled:YES];
    [contentPageScrollView setCanCancelContentTouches:YES];
    [contentPageScrollView setBounces:NO];
    [contentPageScrollView setContentSize:CGSizeMake(3*mainScreenWidth,0)];
    [contentPageScrollView setDelegate:self];
    
    for (int i=0; i<self.vcList.count; i++) {
        UIViewController * avc = self.vcList[i];
        [avc.view setTag:1000+i];
        [avc.view setFrame:CGRectMake( i*mainScreenWidth,0, mainScreenWidth, mainScreenHeight)];
        [contentPageScrollView addSubview:avc.view];
    }

    
    //TestButton
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.statusBarHeight, 50, 50)];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth/2+50, mainScreenHeight/2, 50, 50)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *preButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth/2-50, mainScreenHeight/2, 50, 50)];
    [preButton setTitle:@"Pre" forState:UIControlStateNormal];
    [preButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [preButton addTarget:self action:@selector(preButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    aTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(50, self.statusBarHeight, 0, 23)];
    [aTextFiled setPlaceholder:@"123"];
    [aTextFiled setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:navigationBarBk];
    [self.view addSubview:self.labelScrollView];
    [self.view addSubview:nextButton];
    [self.view addSubview:preButton];
    [self.view addSubview:self.pointLabelRight];
    [self.view addSubview:self.pointLabelLift];
//    UIViewController * avc = self.vcList[0];
//    [avc.view setFrame:CGRectMake(0, self.naviBarHeight+self.statusBarHeight, mainScreenHeight, mainScreenHeight-(self.statusBarHeight+self.naviBarHeight))];
    
    [self.view addSubview:searchButton];
//    [self.view addSubview:avc.view];
    [self.view addSubview:aTextFiled];
    [self.view addSubview:contentPageScrollView];
    
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
//Actions
-(void)nextButtonClicked{
    
    [self changeToNextTag];
    [self changeNextPage];
    
}

-(void)preButtonClicked{
    [self changeToPreTag];
    [self changePrePage];
}

-(void)changeToSelectedTag:(id)sender{
    NSInteger deltaIndex = [sender tag] - markTag;
    NSLog(@"selected");
    int page = [contentPageScrollView contentOffset].x / mainScreenWidth;
    if (deltaIndex>0) {
        for (int k =0; k<deltaIndex; k++) {
            [self changeToNextTag];
            page++;
        }
    }else if (deltaIndex<0) {
        NSInteger newdelta = -deltaIndex;
        for (int k=0; k<newdelta; k++) {
            [self changeToPreTag];
            page--;
        }
    }
        [contentPageScrollView setContentOffset:CGPointMake(page*mainScreenWidth, 0) animated:YES];
    //[self changeToViewAtIndex:markTag];
}

-(void)searchButtonClicked{
    [UIView beginAnimations:@"Search" context:nil];
    [UIView setAnimationDuration:0.5];
    [aTextFiled setFrame:CGRectMake(50, self.statusBarHeight, 200, 23)];

    [UIView commitAnimations];
}
#pragma mark - TagChanging
//TagChanging
-(void)changeToNextTag{
    if (markTag<=self.labelWidthList.count -2) {
        NSLog(@"next");
        originMarkX = originMarkX + [self.labelWidthList[markTag] CGSizeValue].width + self.gapWidth;
        markTag++;
        originMarkXLift = originMarkX + [self.labelWidthList[markTag]CGSizeValue].width;
        if (labelScrollViewOffset >0) {
            [self.pointLabelLift setHidden:NO];
        }
        if (originMarkXLift >= labelScrollWid-self.labelSrollViewEdgeWidth||labelScrollWid <= (mainScreenWidth - 2*self.labelSrollViewEdgeWidth)) {
            NSLog(@"Full");
            [self.pointLabelRight setHidden:YES];
        }else{
            [self.pointLabelRight setHidden:NO];
        }
        
        [UIView beginAnimations:@"test" context:nil];
        //动画时长
        [UIView setAnimationDuration:0.5];
        if (originMarkXLift>mainScreenWidth-2*self.labelSrollViewEdgeWidth) {
            labelScrollViewOffset =originMarkXLift - (mainScreenWidth-2*self.labelSrollViewEdgeWidth);
            [self.labelScrollView setContentOffset:CGPointMake(labelScrollViewOffset, 0)];
        }
        [labelViewArray[markTag-1] setAlpha:0.5];
        [labelViewArray[markTag] setAlpha:1];
        [self.tagMarkBarView setFrame:CGRectMake(originMarkX, fontHeight, [self.labelWidthList[markTag] CGSizeValue].width, 1)];
        [UIView commitAnimations];
    }
    
}

-(void)changeToPreTag{
    if (markTag>=1) {
        NSLog(@"pre");
        originMarkX = originMarkX - [self.labelWidthList[markTag-1] CGSizeValue].width - self.gapWidth;
        markTag--;
        originMarkXLift = originMarkX + [self.labelWidthList[markTag]CGSizeValue].width;
        
        if (originMarkX == 0) {
            NSLog(@"Emtpy");
            [self.pointLabelLift setHidden:YES];
        }
        
        if (originMarkXLift >= labelScrollWid-self.labelSrollViewEdgeWidth||labelScrollWid <= (mainScreenWidth - 2*self.labelSrollViewEdgeWidth)) {
            NSLog(@"Full");
            [self.pointLabelRight setHidden:YES];
        }else{
            [self.pointLabelRight setHidden:NO];
        }
        
        
        [UIView beginAnimations:@"test" context:nil];
        [UIView setAnimationDuration:0.5];
        if (originMarkX <= labelScrollViewOffset) {
            labelScrollViewOffset -=(labelScrollViewOffset-originMarkX);
            [self.labelScrollView setContentOffset:CGPointMake(labelScrollViewOffset, 0)];
        }
        [labelViewArray[markTag] setAlpha:1];
        [labelViewArray[markTag+1] setAlpha:0.5];
        
        [self.tagMarkBarView setFrame:CGRectMake(originMarkX, fontHeight, [self.labelWidthList[markTag] CGSizeValue].width,1)];
        [UIView commitAnimations];
    }
}

-(void)changeToViewAtIndex:(NSInteger)index{
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==1000+index) {
            [subviews removeFromSuperview];
        }
    }
    UIViewController * avc = self.vcList[index];
    [avc.view setFrame:CGRectMake(0, self.statusBarHeight+self.naviBarHeight, mainScreenHeight, mainScreenHeight-(self.statusBarHeight+self.naviBarHeight))];
    [self.view addSubview:avc.view];
}

#pragma mark - StringSize

- (CGSize)getStringSize:(NSString *)string font:(UIFont *)font{
    CGSize aSize;
    aSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    //iOS7的新特性代码
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(mainScreenWidth, mainScreenHeight)
                                       options:opts
                                    attributes:attributes
                                       context:nil];
    aSize = rect.size;
#else
    //iOS6往前的代码
    aSize = [ sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
#endif
    return aSize;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([[scrollView class]isSubclassOfClass:[UITableView class]]) return;
    int page = scrollView.contentOffset.x / mainScreenWidth;
    
    NSInteger deltaIndex = page - markTag;
    NSLog(@"selected");
    if (deltaIndex>0) {
        for (int k =0; k<deltaIndex; k++) {
            [self changeToNextTag];
        }
    }else if (deltaIndex<0) {
        NSInteger newdelta = -deltaIndex;
        for (int k=0; k<newdelta; k++) {
            [self changeToPreTag];
        }
    }
}

#pragma mark -

-(void)changeNextPage{
    int page = [contentPageScrollView contentOffset].x / mainScreenWidth;
    page++;
    [contentPageScrollView setContentOffset:CGPointMake(page*mainScreenWidth, 0) animated:YES];
    
}

-(void)changePrePage{
    int page = [contentPageScrollView contentOffset].x / mainScreenWidth;
    page--;
    [contentPageScrollView setContentOffset:CGPointMake(page*mainScreenWidth, 0) animated:YES];
    
}



@end
