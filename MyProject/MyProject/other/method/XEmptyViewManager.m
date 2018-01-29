//
//  XEmptyViewManager.m
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "XEmptyViewManager.h"
#import "XEmptyRequestModel.h"
#import "XEmptyView.h"
@interface XEmptyViewManager()
PROPERTY_STRONG NSMutableDictionary *dic;
@end
@implementation XEmptyViewManager

+(instancetype)share
{
    static dispatch_once_t onceToken;
    static XEmptyViewManager *emPtyManager=nil;
    dispatch_once(&onceToken, ^{
        emPtyManager=[[self alloc]init];
    });
    return emPtyManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic=[NSMutableDictionary new];
    }
    return self;
}
-(XEmptyRequestModel *)requestModelWithController:(UIViewController *)controller
{
    return [self.dic objectForKey:NSStringFromClass([controller class])];
}
-(void)removeRequestWithController:(UIViewController *)controller
{
    [self.dic removeObjectForKey:NSStringFromClass([controller class])];
}
-(void)postRequestWithRequestParams:(NSDictionary *) postParams controller:(UIViewController *)controller className:(Class) className responseblock:(SYResponseBlock) responseblock
{
    if (!controller) {
        return;
    }
    XEmptyRequestModel *model=nil;
    if (![self requestModelWithController:controller]) {
         model=[[XEmptyRequestModel alloc]init];
    }else
    {
        model=[self requestModelWithController:controller];
    }
    model.responseBlock = responseblock;
    model.controller=controller;
    model.dic=postParams;
    model.className=className;
    [self.dic setObject:model forKey:NSStringFromClass([controller class])];


//    if (![self requestModelWithController:controller].controller.x_tableView.ly_emptyView) {
//        [self requestModelWithController:controller].controller.x_tableView.ly_emptyView=[XEmptyView diyEmptyView];
//        [[self requestModelWithController:controller].controller.x_tableView ly_startLoading];
//    }
}
-(void)resultRequest:(UIViewController *)controller response:(SYResponse *) response;
{
    if (!controller) {
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        XEmptyRequestModel *model=[self requestModelWithController:controller];
        if (!model) {
            return;
        }
        [controller.view hidenActivity];
        if (response.isSuccess) {
            [self removeRequestWithController:controller];
            if ((controller.x_tableView.ly_emptyView&&controller.x_tableView.ly_emptyView.info)||controller.x_tableView.ly_emptyView==nil) {
                controller.x_tableView.ly_emptyView=[XEmptyView diyEmptyView];
            }
        }else
        {
            if (controller.x_tableView.totalDataCount) {
                if ((controller.x_tableView.ly_emptyView&&controller.x_tableView.ly_emptyView.info)||controller.x_tableView.ly_emptyView==nil) {
                    controller.x_tableView.ly_emptyView=[XEmptyView diyEmptyView];
                }
            }else
            {
                
                if ([response isNetWorkFail]) {
                    if ((controller.x_tableView.ly_emptyView&&!controller.x_tableView.ly_emptyView.info)||controller.x_tableView.ly_emptyView==nil) {
                        controller.x_tableView.ly_emptyView=[XEmptyView diyEmptyActionViewWithbtnClickBlock:^(LYEmptyBaseView *view) {
                            [self clickReload:view.info];
                        } info:[NSDictionary dictionaryWithObject:NSStringFromClass(controller.class) forKey:@"className"]];
                    }
                }else
                {
                    controller.x_tableView.ly_emptyView=[XEmptyView diyServerErrorView];
                }
            }
        }
        [controller.x_tableView ly_endLoading];
    });
   
}
-(void)clickReload:(NSDictionary *)info
{
    if (![info objectForKey:@"className"]) {
        return;
    }
    XEmptyRequestModel *model=[self.dic objectForKey:[info objectForKey:@"className"]];
    [self removeRequestWithController:model.controller];
    if (model.controller.x_tableView.mj_header) {
        [model.controller.x_tableView.mj_header beginRefreshing];
    }else
    {
        [model.controller.view showActivity];
    }
    [[XSubService share]pushResponse:model.dic className:model.className controller:model.controller responseblock:model.responseBlock];
}
@end
