//
//  TestErrorView.m
//  XTestApp
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "TestErrorView.h"

@interface TestErrorView ()
@property (nonatomic,strong) IBOutlet UILabel *tipLabel1;
@property (nonatomic,strong) IBOutlet UIButton *retryBtn;
@end

@implementation TestErrorView

+ (instancetype) createTestErrorView
{
    TestErrorView *testErrorView = [[[NSBundle mainBundle] loadNibNamed:@"TestErrorView" owner:self options:nil] objectAtIndex:0];
    return testErrorView;
}

- (IBAction) retryRequestClick:(id) sender
{
    [self retryControl];
}

- (void) startLoad
{
    [super startLoad];
    [self showActivity];
    self.subviews.lastObject.y -= 64;
    self.tipLabel1.hidden = NO;
    self.retryBtn.hidden = YES;
}

- (void) loadingWithProgress:(CGFloat)progress totalProgress:(CGFloat)totalProgress
{
    [super loadingWithProgress:progress totalProgress:totalProgress];
    self.tipLabel1.hidden = YES;
    self.retryBtn.hidden = YES;
}

- (void) completeLoad:(BOOL)bComplete
{
    [super completeLoad:bComplete];
    if(!bComplete)
    {
        self.tipLabel1.hidden = YES;
        [self hidenActivity];
        self.retryBtn.hidden = NO;
    }
    else
    {
        self.tipLabel1.hidden = YES;
        [self hidenActivity];
        self.retryBtn.hidden = YES;
    }
}

@end
