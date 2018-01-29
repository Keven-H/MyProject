//
//  UIView+Animation.m
//  meishi
//
//  Created by yunqi on 15/6/12.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
- (void)animateEnlargeView {
    [self animateEnlargeViewWithDuring:0.2 Scale:0.3 alpha:0.3];
}
- (void)animateEnlargeViewWithDuring:(float )during  Scale:(float)scale alpha:(float)alpha
{
    self.alpha = alpha;
    self.transform = CGAffineTransformMakeScale(scale, scale);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:during];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.alpha = 1.0;
    [UIView commitAnimations];
}
- (void)closeAnimationDidStop {
    [self removeFromSuperview];
}
- (void)animateClose {
    [self animateCloseWithDuring:0.3 Scale:0.3];
}
- (void)animateCloseWithDuring:(float )during  Scale:(float)scale
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:during];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeAnimationDidStop)];
    self.transform = CGAffineTransformMakeScale(scale, scale);
    self.alpha = 0.0;
    [UIView commitAnimations];

}
@end
