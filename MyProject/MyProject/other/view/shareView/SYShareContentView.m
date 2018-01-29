//
//  SYShareContentView.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareContentView.h"
#import "SYShareItemsView.h"
#import "SYShareOption.h"
@interface SYShareContentView()<SYShareItemsViewDelegate>
PROPERTY_STRONG SYShareItemsView *shareView;
@end
@implementation SYShareContentView
+(SYShareContentView *)showShareView:(SYShareOption *)option showItem:(SYShareContentType)showType doneBlock:(syshareContentBlock)clickBlock;
{
    SYShareContentView *view=[[SYShareContentView alloc]init];
    if (option) {
        view.shareView.option=option;
    }
    view.shareView.option.contentType=showType;
    view.shareView.option.doneBlock=clickBlock;
    //XShareManager
    [[HCXShareManager share]  resetShareOption:view.shareView.option];
    [view showWithType:showViewType_drawer];
    return view;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
-(void)initDefault
{
    self.shareView=[[SYShareItemsView alloc]init];
    self.shareView.delegate=self;
    self.shareView.backgroundColor=[UIColor clearColor];
}
-(void)resetSubView
{
    self.contentView.layer.cornerRadius=0;
    self.contentView.width=SCREEN_WIDTH;
    [self.contentView removeAllSubViews];
    [self.contentView addSuViewWithDescendant:self.shareView];
    self.shareView.width=SCREEN_WIDTH;
    [self.shareView reset];
    self.shareView.frame=CGRectMake(0, 0, self.shareView.width, self.shareView.height);
    self.shareView.centerX=self.contentView.width/2;
    self.contentView.height=self.shareView.height;
    
}
-(void)SYShareItemsViewDelegateClickClose
{
    [self closeWithType:showViewType_drawer];
}
@end
