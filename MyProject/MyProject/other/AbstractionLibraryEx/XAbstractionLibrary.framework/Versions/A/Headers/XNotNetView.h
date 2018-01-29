//
//  XNotNetView.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 2017/3/15.
//  Copyright © 2017年 lanbiao. All rights reserved.
//

#import "XView.h"
#import "XErrorViewDelegate.h"

/**
 *  无网络页面
 */
//@interface XNotNetView : XView<XErrorViewDelegate>
@interface XNotNetView : UIView<XErrorViewDelegate>

/**
 *  重试触发操作
 */
- (void) retryControl;
@end
