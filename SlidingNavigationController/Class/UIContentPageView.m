//
//  UIContentPageView.m
//  SlidingNavigationController
//
//  Created by 高向孚 on 16/2/9.
//  Copyright © 2016年 ByStudio. All rights reserved.
//

#import "UIContentPageView.h"

@implementation UIContentPageView

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view{
    return YES;
}
// called before scrolling begins if touches have already been delivered to a subview of the scroll view. if it returns NO the touches will continue to be delivered to the subview and scrolling will not occur
// not called if canCancelContentTouches is NO. default returns YES if view isn't a UIControl
// this has no effect on presses

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
