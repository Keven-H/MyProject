//
//  HCXAccountManager.m
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXAccountManager.h"
#import "SYLock.h"
#import "XDateDefaultManager.h"
@interface HCXAccountManager()
{
    
}
/**
 *  当前登陆用户ID
 */
@property(nonatomic,strong)HCXAccountUser *accountUser;
//PROPERTY_STRONG HCXAccountUser *accountClientUser;
@property(nonatomic,strong)NSString *tokenID;
@property(nonatomic,strong)SYLock *dataLock;

@end

@implementation HCXAccountManager

+ (HCXAccountManager *) shareAccountManager
{
    static HCXAccountManager *accountManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManager = [[HCXAccountManager alloc] init];
    });
    return accountManager;
}

- (instancetype) init
{
    if(self = [super init])
    {
        self.dataLock = [[SYLock alloc] init];
        [self resetDefaultUser];
    }
    return self;
}
-(void)resetDefaultUser
{
    self.accountUser=[self read];
    self.tokenID = [[XDateDefaultManager shareManager] readToken];
}

//user写入
- (void) write
{
    __weak typeof(self) weakSelf = self;
    [_dataLock lock:^{
//        if (self.accountClientUser.deviceToken.length>0) {
//            self.accountUser.deviceToken=[self.accountClientUser.deviceToken copy];
//        }
        [[XDateDefaultManager shareManager] saveCurrentUser:weakSelf.accountUser];
        [[XDateDefaultManager shareManager] saveToken:weakSelf.tokenID];
    }];
}

//存储里面读取
- (HCXAccountUser *) read
{
    __block HCXAccountUser *user;
    [_dataLock lock:^{
        user = [[XDateDefaultManager shareManager] readCurrentUser];
    }];
    return user;
}

- (void) clear
{
    [_dataLock lock:^{
        //        [[SYCacheFileManager shareCacheFileManager] clearCurrentUser];
        [[XDateDefaultManager shareManager] clearToken];
    }];
}
-(BOOL)isLogin
{
    if (self.tokenID.length) {
        return YES;
    }
    return NO;
}
-(void)loginOut
{
    [self clear];
    [self resetDefaultUser];
}

+(BOOL)isLogin
{
    return [[HCXAccountManager shareAccountManager] isLogin];
}

+(void)loginOut
{
    [[HCXAccountManager shareAccountManager] loginOut];
}


+(void)saveAccountWithUserModel:(HCXUser *)user
{
    if (!user) {
        return;
    }
    [HCXAccountManager shareAccountManager].accountUser.user=user;
    [[HCXAccountManager shareAccountManager] write];
}
+(HCXAccountUser *)loginAccount
{
    return [HCXAccountManager shareAccountManager].accountUser;
}
+(HCXAccountUser *)account
{
    if ([self isLogin]) {
        return [HCXAccountManager loginAccount];
    }
    return nil;
}

+(HCXUser *)currentUser
{
    return [HCXAccountManager account].user;
}

+(void)saveAccountWithModel:(HCXAccountUser *)loginUser shouldClear:(BOOL)clear;
{
    if (!loginUser) {
        return;
    }
    if (clear&&![[HCXAccountManager loginAccount].user.ID isEqualToString:loginUser.user.ID]) {

    }
    [HCXAccountManager shareAccountManager].accountUser=loginUser;
    [HCXAccountManager shareAccountManager].tokenID=loginUser.token;
    [[HCXAccountManager shareAccountManager] write];
    [[HCXAccountManager shareAccountManager] resetDefaultUser];
}
+(void)write
{
    [[HCXAccountManager shareAccountManager] write];;
}


@end
