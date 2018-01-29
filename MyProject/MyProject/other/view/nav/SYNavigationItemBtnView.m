//
//  SYNavigationItemBtnView.m
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYNavigationItemBtnView.h"
@interface SYNavigationItemBtnView()
PROPERTY_STRONG UILabel *badgeView;
@end
@implementation SYNavigationItemBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    if (self=[super init]) {
        _badgeView=[[UILabel alloc]init];
        _badgeView.font=UIFontWithSize(11);
        _badgeView.frame=CGRectMake(0, 0, 6, 6);
        _badgeView.backgroundColor=[UIColor redColor];
        _badgeView.layer.masksToBounds=YES;
        _badgeView.textAlignment=NSTextAlignmentCenter;
        _badgeView.userInteractionEnabled=NO;
        _badgeView.textColor=[UIColor whiteColor];
        _badgeView.layer.cornerRadius=_badgeView.width/2;
        _badgeView.hidden=YES;
        [self addSubview:_badgeView];
        _badgeType=SYbadgeViewType_number;
        _bgdgeNumber=0;
        _maxBadgeNum=9;
    }
    return self;
}
-(void)setBgdgeNumber:(NSInteger)bgdgeNumber
{
    _bgdgeNumber=bgdgeNumber;
    [self resetBadge];
}
-(void)resetBadge
{
    if (self.bgdgeNumber<=0) {
        self.badgeView.hidden=YES;
        return;
    }
    self.badgeView.hidden=NO;
    if (self.badgeType==SYbadgeViewType_none) {
        self.badgeView.frame=CGRectMake(0, 0, 6, 6);
        self.badgeView.text=@"";
    }
    if (self.badgeType==SYbadgeViewType_number) {
        self.badgeView.frame=CGRectMake(0, 0, 14, 14);
        NSString *msg=NSStringFromInt(self.bgdgeNumber);
        if (self.bgdgeNumber>self.maxBadgeNum) {
            msg=@"···";
        }
        self.badgeView.text=msg;
    }
    _badgeView.layer.cornerRadius=_badgeView.width/2;
    [self setNeedsLayout];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.badgeType==SYbadgeViewType_none) {
        _badgeView.frame=CGRectMake(self.width+1, 7, _badgeView.width, _badgeView.height);
    }else
    {
        _badgeView.frame=CGRectMake(self.width-6, 7, _badgeView.width, _badgeView.height);
    }
    
}

@end
