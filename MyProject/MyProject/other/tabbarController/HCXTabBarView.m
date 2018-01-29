//
//  HCXTabBarView.m
//  EatEquity
//
//  Created by liyunqi on 04/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXTabBarView.h"
@interface HCXTabBarView()
{
    
}
PROPERTY_STRONG UIView *bgView;
@end
@implementation HCXTabBarView

-(void)awakeFromNib
{
    [super awakeFromNib];
     _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    
    [self addSuViewWithDescendant:self.bgView];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame=self.bounds;
}

@end
