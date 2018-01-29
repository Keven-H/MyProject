//
//  SYNavigationitemLeftView.m
//  Foodie
//
//  Created by liyunqi on 22/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYNavigationitemLeftView.h"

@implementation SYNavigationitemLeftView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaults];
    }
    return self;
}
-(void)initDefaults
{
    if (!self.goBackItem) {
        self.goBackItem=[[SYNavigationItemBtnView alloc]init];
        self.goBackItem.titleLabel.font=UIFontWithSize(16);
        self.goBackItem.backgroundColor=[UIColor clearColor];
        [self.goBackItem setTitleColor:[UIColor itiColor51_51_51] forState:UIControlStateNormal];
        self.goBackItem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.goBackItem.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        [self addSuViewWithDescendant:self.goBackItem];
    }
    if (!self.goRootItem) {
        self.goRootItem=[[SYNavigationItemBtnView alloc]init];
        self.goRootItem.titleLabel.font=UIFontWithSize(16);
        self.goRootItem.backgroundColor=[UIColor clearColor];
        [self.goRootItem setTitleColor:[UIColor itiColor51_51_51] forState:UIControlStateNormal];
        self.goRootItem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [self addSuViewWithDescendant:self.goRootItem];
        [self.goRootItem setImage:ImageNamed(@"sy_goRoot_h") forState:UIControlStateNormal];
        self.goRootItem.frame=CGRectMake(0, 0, 40, 44);
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.goBackItem.frame=CGRectMake(0, 0, self.goBackItem.width, self.goBackItem.height);
    self.goRootItem.frame=CGRectMake(self.goBackItem.width+self.goBackItem.x, 0, self.goRootItem.width, self.goRootItem.height);
    self.goRootItem.centerY=self.height/2;
    self.goBackItem.centerY=self.height/2;
}
-(void)showBackBtn:(NSString *)title imageStr:(NSString *)strImage
{
    self.goBackItem.hidden=NO;
    self.goBackItem.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    CGSize size=CGSizeZero;
    if (title.length) {
        size=[title sizeWithTextFont:self.goBackItem.titleLabel.font maxWidth:1000];
        [self.goBackItem setTitle:title forState:UIControlStateNormal];
    }
    UIImage *image=nil;
    if (strImage.length) {
         image=[UIImage imageNamed:strImage];
        [self.goBackItem setImage:image forState:UIControlStateNormal];
    }
    self.goBackItem.frame = CGRectMake(0, 0,MIN((size.width+MAX(image.size.width, 40)),100)+15, 44);
    self.frame=CGRectMake(0, 0, self.goBackItem.width+self.goRootItem.width, 44);
}
-(void)resetDefault
{
    [self.goBackItem setBackgroundImage:nil forState:UIControlStateNormal];
    [self.goBackItem setImage:nil forState:UIControlStateNormal];
    [self.goBackItem setImage:nil forState:UIControlStateHighlighted];
    [self.goBackItem setBackgroundImage:nil forState:UIControlStateHighlighted];
    self.goBackItem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
