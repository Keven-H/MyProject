//
//  XErrorView.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XView.h"
#import "XErrorViewDelegate.h"

/**
 *  基础错误view
 */
//@interface XErrorView : XView<XErrorViewDelegate>
@interface XErrorView : UIView<XErrorViewDelegate>

/**
 *  重试触发
 */
- (void) retryControl;

@end
