//
//  XView.h
//  Pods
//
//  Created by lanbiao on 15/07/21.
//
//

#import <UIKit/UIKit.h>
#import "XTaskDelegate.h"
#import "XErrorViewDelegate.h"
#import "XHttpResponseDelegate.h"

@class XErrorView;
@class XNotNetView;
@interface XView : UIView<XHttpResponseDelegate,XRetryDelegate,XTaskDelegate>

/**
 *  与errorInterfaces结合判断
 */
@property (nonatomic,assign) BOOL bStartErrorListen;

/**
 *  网络状态页、请求失败重试
 */
@property (nonatomic,strong) UIView *exceptionContentView;

/**
 *  添加需要关联错误页的命令
 */
- (void) addErrorCommand:(NSString *) command;

/**
 *  移除指定关联的命令
 */
- (void) removeErrorCommand:(NSString *) command;

/**
 *  移除所有指定关联的命令
 */
- (void) removeAllErrorCommands;

/**
 *  初始化错误页
 *  @return 返回错误页指针
 */
- (XErrorView *) customErrorView;

/**
 *  无网络状态页面
 */
- (XNotNetView *) customNotNetView;

/**
 * 重置exceptionContentView的布局信息
 */
- (void) resetExceptionContentView;

@end
