//
//  SYNotNetView.m
//  Foodie
//
//  Created by 张国军 on 2017/5/11.
//  Copyright © 2017年 SY. All rights reserved.
//

#import "SYNotNetView.h"

@interface SYNotNetView()

@property (nonatomic, strong) UIButton * retryBtn;
@property (strong, nonatomic) UILabel *noNetLabel;
@property (strong, nonatomic) UILabel *retryLabel;
@end

@implementation SYNotNetView

+ (instancetype) createTestNotNetView
{
    SYNotNetView * notNetView = [[SYNotNetView alloc]init];
    [notNetView initSubviews];
    return notNetView;
}

-(void)initSubviews
{
    self.backgroundColor = FNColor(243, 243, 243);
    self.retryBtn = [[UIButton alloc]init];
    [self.retryBtn addTarget:self action:@selector(retryRequestClick) forControlEvents:UIControlEventTouchUpInside];
    [self.retryBtn setBackgroundImage:[UIImage imageNamed:@"All_NONetWork"] forState:UIControlStateNormal];
    self.retryBtn.size = CGSizeMake(74, 82);
    [self addSubview:self.retryBtn];
    
    self.noNetLabel = [[UILabel alloc]init];
    self.noNetLabel.font = UIFontWithSize(15);
    self.noNetLabel.textColor = FNColor(136, 136, 136);
    self.noNetLabel.text = @"网络连接失败";
    self.noNetLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.noNetLabel];
    
    self.retryLabel = [[UILabel alloc]init];
    self.retryLabel.font = UIFontWithSize(15);
    self.retryLabel.textColor = FNColor(136, 136, 136);
    self.retryLabel.text = @"点击重新加载";
    self.retryLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.retryLabel];
}

-(void)layoutSubviews
{
    self.retryBtn.center = self.center;
    self.noNetLabel.frame = CGRectMake(0, self.retryBtn.bottom + 16, self.width, 15);
    self.retryLabel.frame = CGRectMake(0, self.noNetLabel.bottom + 4, self.width, 15);
}

- (void) retryRequestClick
{
    [self retryControl];
}

@end
