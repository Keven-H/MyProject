//
//  SYBaseEventController.h
//  Foodie
//
//  Created by liyunqi on 20/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
//此基累专门处理一些app通用事件(比如游客，登录模式的数据，通知等)
@interface SYBaseEventController : XViewController
-(void)loginStatusChange;
@end
