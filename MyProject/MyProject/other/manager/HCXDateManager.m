//
//  HCXDateManager.m
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXDateManager.h"
#import "XUserDefaults.h"
#import "XDateDefaultManager.h"
#import "SYTaskTableModelManager.h"
#import "SYLock.h"
#import "SYQueue.h"
#import "HCXAppConfigModel.h"
#import "HCXDeviceRptModel.h"
@interface HCXDateManager()
PROPERTY_STRONG SYLock *taskLock;
/**
 图片上传队列
 */
@property(nonatomic,strong)NSOperationQueue *upImageQueue;
/**
 *  所有本地任务对象列表
 */
@property (nonatomic, strong) SYQueue *taskQueue;

PROPERTY_STRONG NSMutableDictionary *dicCName;
@end
@implementation HCXDateManager
+ (instancetype) shareDataManager
{
    static HCXDateManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[[self class] alloc] init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [dataManager initData];
        });
    });
    return dataManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
#ifdef __IPHONE_11_0
        if ([[UIScrollView appearance]respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
#endif
        self.taskLock=[[SYLock alloc]init];
        _upImageQueue=[[NSOperationQueue alloc]init];
        _upImageQueue.maxConcurrentOperationCount=1;
        NSString *path=[[NSBundle mainBundle]pathForResource:@"controllers" ofType:@"plist"];
        self.dicCName=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
       
    }
    return self;
}
- (void) initData
{
   
    self.taskQueue = [SYQueue createQueue];
    [HCXAccountManager shareAccountManager];
    
    NSArray *taskList = [NSArray arrayWithArray:[[SYTaskTableModelManager shareTableModelManager] getAllTask]];
    for(XTask *task in taskList)
        [self.taskQueue addMember:task];
    
}

-(void) saveModel:(SYBaseModel *) model
{
    [[XDateDefaultManager shareManager ] saveModel:model];
}

- (SYBaseModel *) getModel:(Class) classModel
{
    return [[XDateDefaultManager shareManager] getModel:classModel];
}

- (void) clearModel:(Class) classModel
{
    [[XDateDefaultManager shareManager] clearModel:classModel];
}

- (id) getValueForKey:(NSString *const) key
{
    return [[XDateDefaultManager shareManager] getValueForKey:key];
}

- (BOOL) removeValueForKey:(NSString *const) key
{
    return [[XDateDefaultManager shareManager] removeValueForKey:key];
}

- (BOOL) saveValue:(id) value forKey:(NSString *const) key
{
    return [[XDateDefaultManager shareManager] saveValue:value forKey:key];
}

#pragma  mark 登陆账号相关

-(BOOL)accountIsLogin
{
    return [HCXAccountManager  isLogin];
}

-(void)accountloginOut
{
    return [HCXAccountManager loginOut];
}


-(void)saveAccountWithModel:(HCXAccountUser *)loginUser shouldClear:(BOOL)clear
{
    [HCXAccountManager saveAccountWithModel:loginUser shouldClear:clear];
}


-(void)saveAccountWithUserModel:(HCXUser *)user
{
    [HCXAccountManager saveAccountWithUserModel:user];
}

-(HCXAccountUser *)account
{
    return [HCXAccountManager account];
}

-(HCXUser *)currentUser
{
    return [HCXAccountManager currentUser];
}

-(void)accountSave
{
    [HCXAccountManager write];
}


#pragma mark- 版本号是否改变了
-(BOOL)versionChange
{
    NSString* oldVer = [[XDateDefaultManager shareManager]getValueForKey:@"banbenhao"];
    NSString* newVer = [XAppInfo getAppVersion];
    if (![oldVer isEqualToString:newVer]) {
        [[XDateDefaultManager shareManager]saveValue:newVer forKey:@"banbenhao"];
        return YES;
    }
    return NO;
}
-(NSString *)getCurrentController:(NSString *)pageName
{
    NSString *name=pageName;
    if (!SYStringisEmpty(name)&&[self.dicCName objectForKey:name]) {
        NSDictionary *dic=[self.dicCName objectForKey:name];
        if ([dic isKindOfClass:[NSDictionary class]]&&[dic objectForKey:@"pageid"]) {
            return [dic objectForKey:@"pageid"];
        }
    }
    return nil;

}
-(NSString *)controllerPageID
{
    Class cs=[[HCXControllerManager shareManager]currentViewController].class;
    NSString *name=nil;
    if (cs) {
        name=NSStringFromClass(cs);
    }
    return [self getCurrentController:name];
}
-(NSString *)controllerPageTitle
{
    Class cs=[[HCXControllerManager shareManager]currentViewController].class;
    NSString *name=nil;
    if (cs) {
        name=NSStringFromClass(cs);
    }
    if (!SYStringisEmpty(name)&&[self.dicCName objectForKey:name]) {
        NSDictionary *dic=[self.dicCName objectForKey:name];
        if ([dic isKindOfClass:[NSDictionary class]]&&[dic objectForKey:@"title"]) {
            return [dic objectForKey:@"title"];
        }
    }
    return nil;
}

#pragma mark- 电话列表-
//电话列表
+(NSArray *)merchantPhones:(NSString *)phone
{
    if (SYStringisEmpty(phone)) {
        return [NSArray array];
    }
    return [phone componentsSeparatedByString:@";"];
}
//呼叫电话
+(UIWebView *)webView
{
    static dispatch_once_t onceToken;
    static UIWebView *callWebview = nil;
    dispatch_once(&onceToken, ^{
        callWebview =[[UIWebView alloc] init];
    });
    return callWebview;
}
+(void)callPhoneNum:(NSString *)num
{
    NSString *telUrl = [NSString stringWithFormat:@"tel:%@",num];
    NSURL *telURL =[NSURL URLWithString:telUrl];// tel:// 或者 tel: 都行
    [[self webView] loadRequest:[NSURLRequest requestWithURL:telURL]];
}
//呼叫提示列表
+(void)callPhonesWithPhons:(NSString *)phone
{
    NSArray *list=[self merchantPhones:phone];
    if (list.count) {
        if (list.count==1) {
            [self callPhoneNum:list.firstObject];
        }else
        {
            [LBXAlertAction showActionSheetWithTitle:nil message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitle:list chooseBlock:^(NSInteger buttonIdx) {
                if (buttonIdx!=0) {
                    [self callPhoneNum:[list objectAtIndex:buttonIdx-1]];
                }
            }];
        }
    }
}


#pragma mark-token
-(NSString *)deviceToken
{
    return [[XDateDefaultManager shareManager]getValueForKey:@"eat_deviceToken"];
}
-(void)saveDeviceToken:(NSString *)token
{
    [[XDateDefaultManager shareManager]saveValue:token forKey:@"eat_deviceToken"];
}

-(void)clearDeviceToken
{
    [[XDateDefaultManager shareManager]removeValueForKey:@"eat_deviceToken"];
}



- (void) clearAllCacheData
{
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager].imageCache clearDisk];
}

- (float) getCacheItemsSize
{
    return [[[SDWebImageManager sharedManager]imageCache] getSize];
}

#pragma mark 任务相关
- (NSArray *) allTasks
{
    __block NSArray *taskArray = nil;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        taskArray = [weakSelf.taskQueue allMembers];
    }];
    return taskArray;
}

- (NSArray *) taskWithClassName:(NSString*) className
{
    __block NSArray *taskArray = [NSArray array];
    if(!className)
        return taskArray;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        taskArray = [weakSelf.taskQueue memberWithClassName:className];
    }];
    return taskArray;
}

- (XTask *) taskWithID:(NSString *) taskID
{
    __block XTask *task = nil;
    if(!taskID)
        return task;
    
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        task = (XTask*)[weakSelf.taskQueue memberWithID:taskID];
    }];
    return task;
}

- (BOOL) addTask:(XTask *) task
{
    if(![task validateID])
        return NO;
    
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        bSucess = [[SYTaskTableModelManager shareTableModelManager] addTask:task];
        if(bSucess)
            [weakSelf.taskQueue addMember:task];
    }];
    return bSucess;
}

- (BOOL) addNonInsertTaskDataBase:(XTask *) task
{
    if(![task validateID])
        return NO;
    
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        [weakSelf.taskQueue addMember:task];
    }];
    return bSucess;
}

- (BOOL) updateTask:(XTask *) task
{
    if(![task validateID])
        return NO;
    
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        bSucess = [[SYTaskTableModelManager shareTableModelManager] updateWithTask:task];
        if(bSucess)
            [weakSelf.taskQueue updateMember:task];
    }];
    return bSucess;
}

- (BOOL) removeTask:(XTask*) task
{
    if(![task validateID])
        return NO;
    
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        bSucess = [[SYTaskTableModelManager shareTableModelManager] removeTask:task];
        if(bSucess)
        {
//            [weakSelf removeAssetImageWithID:task.ID];
            [weakSelf.taskQueue removeMember:task];
        }
    }];
    return bSucess;
}

- (BOOL) removeTaskWithTaskID:(NSString *) taskID
{
    if(taskID.length <= 0)
        return NO;
    
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        XTask *task = (XTask*)[weakSelf.taskQueue memberWithID:taskID];
        bSucess = [[SYTaskTableModelManager shareTableModelManager] removeTask:task];
        if(bSucess)
        {
            //            [weakSelf removeAssetImageWithID:taskID];
            [weakSelf.taskQueue removeMember:task];
        }
    }];
    return bSucess;
}

- (BOOL) removeAllTask
{
    __block BOOL bSucess = NO;
    __weak typeof(self) weakSelf = self;
    [_taskLock lock:^{
        BOOL bSucess = [[SYTaskTableModelManager shareTableModelManager] removeAllTask];
        if(bSucess)
        {
//            [weakSelf removeAllAssets];
            [weakSelf.taskQueue removeAllMembers];
        }
    }];
    return bSucess;
}


- (void) addAsyncTask:(void(^)(void)) block
{
    if(block)
        [_upImageQueue addOperationWithBlock:block];

}
-(BOOL)pushSwitch
{
    if ([self.class pushNotificationPermissionAuthorizationStatus]!=ClusterAuthorizationStatusAuthorized) {
        return NO;
    }
    HCXDeviceRptModel *model=(HCXDeviceRptModel *)[[HCXDateManager shareDataManager]getModel:[HCXDeviceRptModel class]];
    if (model&&model.isPush.length) {
        if (model.isPush.integerValue==1) {
            return YES;
        }
    }
    return NO;
}

/**
 设置push开关
 */

+ (ClusterAuthorizationStatus) pushNotificationPermissionAuthorizationStatus
{

    if (true) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
            // iOS8+
            if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                return ClusterAuthorizationStatusAuthorized;
            } else {
                return ClusterAuthorizationStatusDenied;
            }
        } else {
            
            // Add compiler check to avoid warnings, if deployment target >= 8.0
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
            // iOS 7
            if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone) {
                return ClusterAuthorizationStatusDenied;
            } else {
                return ClusterAuthorizationStatusAuthorized;
            }
#else
            // Impossible state to be in: iOS 8 device, but somehow doesn't respond to isRegisteredForRemoteNotifications?
            return ClusterAuthorizationStatusDenied;
#endif
        }
    } else {
        return ClusterAuthorizationStatusUnDetermined;
    }
}
-(void)setPushSwitch:(void(^)(BOOL result))block open:(BOOL)open
{
    
    if ([self.class pushNotificationPermissionAuthorizationStatus]!=ClusterAuthorizationStatusAuthorized) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (block) {
//                block(NO);
//            }
//            [[UIApplication sharedApplication].keyWindow showMessage:@"设置中未打开推送"];
            [[SYClusterManager  sharedPermissions]openLocationSetting];
//        });
        return ;
    }
//    [[UIApplication sharedApplication].keyWindow showActivity];
    [[HCXSubService share]loadClosepush:open?@"1":@"0" className:[SYResponse class] responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
//        [[UIApplication sharedApplication].keyWindow hidenActivity];
        if (response.isSuccess) {
            HCXDeviceRptModel *model=(HCXDeviceRptModel *)[[HCXDateManager shareDataManager]getModel:[HCXDeviceRptModel class]];
            if (model==nil) {
                model=[[HCXDeviceRptModel alloc]init];
            }
            model.isPush=open?@"1":@"0";
            [[HCXDateManager shareDataManager]saveModel:model];
            if (block) {
                block(YES);
            }
        }else
        {
            if (block) {
                block(YES);
            }
            [[UIApplication sharedApplication].keyWindow showMessage:response.responseMsg];
        }
    }];
}
-(NSString *)thisCityCodeOpen:(NSString *)codename
{
    if (SYStringisEmpty(codename)) {
        return nil;
    }
    NSString *name=codename;
    HCXAppConfigModel *model=(HCXAppConfigModel *)[[HCXDateManager shareDataManager]getModel:[HCXAppConfigModel class]];
    if (model) {
        for (HCXAppConfigCity *cityModel in model.openedCity) {
            if ([name rangeOfString:cityModel.name].length) {
                return cityModel.code;
            }
        }
    }
    return nil;
}
-(void)CityCodeOpen:(void(^)(BOOL result,NSInteger code,NSString *msg,NSDictionary *info))block
{
    if ([SYClusterManager locationPermissionisStatus]!=ClusterAuthorizationStatusAuthorized) {
        if (block) {
            block(NO,1,@"尚未开启定位",nil);
        }
    }else
    {
        
        [[SYLocationManager Share]currentLocationWithSucessCallBack:^(CLLocationCoordinate2D currentPosition) {
            [[SYLocationManager Share] ConvertPlaceTempCityWithLatitude:currentPosition.latitude lontitude:currentPosition.longitude andresults:^(NSString *firstPlace, SYlocationModel *model, CLPlacemark *placeMark) {
                NSString * rest=[self thisCityCodeOpen:model.city];
                if (block) {
                    NSMutableDictionary *dic=[NSMutableDictionary new];
                    [dic setObject:model.city forKey:@"cityName"];
                    block(rest?YES:NO,rest?rest.integerValue:4,rest?rest:@"用户所在城市无权益",dic);
                }

            } andFailed:^(NSString *failedDescription) {
                if (block) {
                    block(NO,3,@"获取城市失败",nil);
                }
            }];
        } andLocatedFail:^(NSString *errorDescription, SYLocationErrorType errorType) {
            if (block) {
                block(NO,2,@"定位失败",nil);
            }
        }];
    }
}


#pragma mark - userAgent相关
+(void)resetUserAgent
{
    [self addNewsWebViewUserAgentWithcontent:[self userAgent]];
}

+ (void)addNewsWebViewUserAgentWithcontent:(NSString*)content
{
    if (SYStringisEmpty(content)) {
        return;
    }
    NSDictionary* dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:content, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString*)userAgent
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[[SYHttpRequestManager shareHttpRequestManager]addDefaultParam:[NSMutableDictionary new]]];
    
    
    NSString* addUserAgent = [[NSDictionary dictionaryWithObject:dic forKey:@"hcx:"] JSONRepresentation];
    addUserAgent=@"";
    
    for (NSString *key in dic.allKeys) {
        addUserAgent=[NSString stringWithFormat:@"%@ %@/%@",addUserAgent,key,[dic objectForKey:key]];
    }
    
    NSString* oldAgent = [self loadOldUserAgent];
    if (![oldAgent hasSuffix:addUserAgent]) {
        addUserAgent = [oldAgent stringByAppendingString:addUserAgent];
    }
    
    return addUserAgent;
}
+ (NSString*)loadOldUserAgent
{
   NSString *  defaultuserAgent=[[self webView] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    return defaultuserAgent;
}
+(BOOL)appRegisterSwitch
{
    NSString *key=[NSString stringWithFormat:@"registerswitch_%@",[SYClientInfo appVersion]];
    NSString *value=[[XDateDefaultManager shareManager]getValueForKey:key];
    if (value==nil||value.integerValue==1) {
        //审核期间
        return YES;
    }
    return NO;
}
+(void)appRegisterSwitch:(BOOL)open
{
    if ([self appRegisterSwitch]) {
        if (open) {
            NSString *key=[NSString stringWithFormat:@"registerswitch_%@",[SYClientInfo appVersion]];
            [[XDateDefaultManager shareManager]saveValue:@"0" forKey:key];
        }
    }
}

+ (NSInteger)hourOfDate:(NSDate *)date
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *locationString = [formatter stringFromDate:date];
    NSInteger hour = [locationString integerValue];
    return hour;
}

+ (NSString *)getCurrentMLDDate
{
    // 得到小时
    NSInteger hour = [self hourOfDate:[NSDate date]];
    NSString *str=@"";
        if (hour>=0&&hour<5)
        {
            str=@"晚安";
        }
        else if (hour>=5&&hour<8)
        {
            str=@"早晨好";
        }
        else if (hour>=8&&hour<11)
        {
            str=@"上午好";
        }
        else if (hour>=11&&hour<13)
        {
            str=@"中午好";
        }
        else if(hour>=13&&hour<19)
        {
            str=@"下午好";
        }else
        {
            str=@"晚上好";
        }
    return str;

}


@end
