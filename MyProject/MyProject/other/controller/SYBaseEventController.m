//
//  SYBaseEventController.m
//  Foodie
//
//  Created by liyunqi on 20/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYBaseEventController.h"
typedef enum
{
    Event_loginStatus_user,//正常登录
    Event_loginStatus_clientUser,//游客
}Event_loginStatus;
@interface SYBaseEventController ()
{
    NSString *initTimeStr;
}
PROPERTY_ASSIGN Event_loginStatus loginStatus;
@end

@implementation SYBaseEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginStatus=[self currentLoginStutus];
    initTimeStr=[NSString Currentmillisecond];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginStatusMsg) name:SYloginChangeNotification object:nil];
    // Do any additional setup after loading the view.
}
-(NSString *)trackPage
{
    return NSStringFromClass([self class]);
}
-(NSString *)pageEventID
{
    return [NSString stringWithFormat:@"SYBaseController_%@",[self trackPage]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [SYAnalytics startTracPage:[self trackPage]];
//    [SYAnalytics beginEvent:[self pageEventID]];
    [self loginStatusMsg];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [SYAnalytics endTracPage:[self trackPage]];
//    [SYAnalytics endEvent:[self pageEventID]];
}


#pragma mark -游客处理
-(Event_loginStatus)currentLoginStutus
{
//    if ([[SYDataManager shareDataManager] accountIsLogin]) {
//        return Event_loginStatus_user;
//    }
    return Event_loginStatus_clientUser;
}
-(BOOL)canNotificationLoginChange
{
    BOOL canNotification=NO;
    if ([self.navigationController.viewControllers.lastObject isEqual:self]) {
        if (self.loginStatus!=[self currentLoginStutus]) {
            canNotification=YES;
        }
    }
    return canNotification;
}
-(void)loginStatusMsg
{
    if ([self canNotificationLoginChange]) {
        [self loginStatusChange];
        self.loginStatus=[self currentLoginStutus];
    }
    //测试
    
}
-(void)loginStatusChange
{
    NSLog(@"登录状态改变");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [[SYDataModel shareDataModel] removeAllDataModel];
}

-(void)dealloc
{
//    [SYAnalytics  logPageView:[NSString stringWithFormat:@"%@_init_dealloc",[self trackPage]] seconds:[[NSString Currentmillisecond]intValue]-initTimeStr.intValue];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
