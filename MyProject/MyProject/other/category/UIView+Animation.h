//
//  UIView+Animation.h
//  meishi
//
//  Created by yunqi on 15/6/12.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
- (void)animateEnlargeView;
- (void)animateEnlargeViewWithDuring:(float )during  Scale:(float)scale alpha:(float)alpha;


- (void)animateClose;
- (void)animateCloseWithDuring:(float )during  Scale:(float)scale;
@end
