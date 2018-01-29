//
//  SYMessageBoxManager.m
//  Foodie
//
//  Created by lanbiao on 16/7/13.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYLock.h"
#import "SYMessageBoxManager.h"

@interface SYMessageBoxManager ()
/**
 *  是否已经显示提示框
 */
@property (nonatomic,assign) BOOL bShowing;

/**
 *  强制更新到的新版本
 */
@property (nonatomic,strong) NSString *toVersion;

/**
 *  强制更新的url
 */
@property (nonatomic,strong) NSString *updateUrl;

/**
 *  状态锁
 */
@property (nonatomic,strong) SYLock *lock;
@end

@implementation SYMessageBoxManager

+ (instancetype) shareMessageBoxManager
{
    static SYMessageBoxManager *timeOutManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeOutManager = [[SYMessageBoxManager alloc] init];
    });
    return timeOutManager;
}

- (instancetype) init
{
    if(self = [super init])
    {
        _lock = [[SYLock alloc] init];
    }
    return self;
}

- (void) gotoLogin
{
    [HCXLoginManager loginOut];
    self.bShowing = NO;
}

- (void) gotoForceUpdate:(NSString *)str
{

    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:str];
        if(url)
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    });
}

- (void) showUpdateDialogVersion:(HCXAppUpgradeModel *)upmodel;
{
    if (upmodel.source!=1) {
        return;
    }
    if (SYStringisEmpty(upmodel.version)||(SYStringisEmpty(upmodel.title)&&SYStringisEmpty(upmodel.content))) {
        return;
    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [LBXAlertAction showAlertWithTitle:upmodel.title msg:upmodel.content buttonsStatement:upmodel.fourceUpgrade==1?@[@"前往更新"]:@[@"取消",@"前往更新"] chooseBlock:^(NSInteger buttonIdx) {
//            if (upmodel.fourceUpgrade==1) {
//                [self gotoForceUpdate:upmodel.url];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    exit(0);
//                });
//            }else
//            {
//                if (buttonIdx==1) {
//                     [self gotoForceUpdate:upmodel.url];
//                }
//            }
//        }];
//    });
}

- (void) showDialog:(MessageBoxType) type
            tipText:(NSString *) tipText
{
    NSString *title=@"账号异常";
    NSString *oktitle=@"确定";
    switch (type) {
        case MessageBoxType_TokenTimeOut:
            tipText = @"您的账号可能在其他设备登陆，若非本人操作，请尽快修改密码";
            oktitle=@"重新登录";
            break;
        case MessageBoxType_AcountShutDown:
            tipText = @"您的账号被冻结";
            break;
        case MessageBoxType_ForceUpdate:
            
            break;
        default:
            tipText = @"";
            break;
    }
    if (type==MessageBoxType_TokenTimeOut||type==MessageBoxType_AcountShutDown) {
        if (![[HCXDateManager shareDataManager]accountIsLogin]) {
            return;
        }
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_lock lock:^{
            if(weakSelf.bShowing)
                return ;
            weakSelf.bShowing = YES;
            [LBXAlertAction showAlertWithTitle:title msg:tipText buttonsStatement:@[oktitle] chooseBlock:^(NSInteger buttonIdx) {
                if(type == MessageBoxType_ForceUpdate)
                {
                    [weakSelf gotoForceUpdate:nil];
                }
                else if(type == MessageBoxType_TokenTimeOut ||
                        type == MessageBoxType_AcountShutDown)
                {
                    [weakSelf gotoLogin];
                }
            }];
        }];
    });
}


@end
