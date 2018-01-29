//
//  SYErrorView.m
//  Foodie
//
//  Created by 张国军 on 2017/5/11.
//  Copyright © 2017年 SY. All rights reserved.
//

#import "SYErrorView.h"

@interface SYErrorView()

@property (nonatomic, strong) UIButton * retryBtn;

@end

@implementation SYErrorView

+ (instancetype) createTestErrorView
{
    SYErrorView * errorView = [[SYErrorView alloc] init];
    [errorView initSubviews];
    return errorView;
}

- (void)initSubviews
{
    self.backgroundColor = FNColor(243, 243, 243);
    self.retryBtn = [[UIButton alloc]init];
    [self.retryBtn addTarget:self action:@selector(retryRequestClick) forControlEvents:UIControlEventTouchUpInside];
    [self.retryBtn setBackgroundImage:[UIImage imageNamed:@"result_NoLoading"] forState:UIControlStateNormal];
    self.retryBtn.size = CGSizeMake(71, 125);
    [self addSubview:self.retryBtn];
}

-(void)layoutSubviews
{
    self.retryBtn.center = self.center;
}

- (void)retryRequestClick
{
    [self retryControl];
}

- (void) startLoad
{
    [super startLoad];
    [self showActivity];
    self.subviews.lastObject.y -= 64;
    self.retryBtn.hidden = YES;
}

- (void) loadingWithProgress:(CGFloat)progress totalProgress:(CGFloat)totalProgress
{
    [super loadingWithProgress:progress totalProgress:totalProgress];
    self.retryBtn.hidden = YES;
}

- (void) completeLoad:(BOOL)bComplete
{
    [super completeLoad:bComplete];
    if(!bComplete)
    {
        [self hidenActivity];
        self.retryBtn.hidden = NO;
    }
    else
    {
        [self hidenActivity];
        self.retryBtn.hidden = YES;
    }
}

@end
