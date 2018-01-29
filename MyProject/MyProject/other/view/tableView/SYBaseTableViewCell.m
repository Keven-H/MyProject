//
//  SYBaseTableViewCell.m
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYBaseTableViewCell.h"
#define SYBaseTableViewCell_line_height 0.5
@implementation SYBaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initDefalultSetting];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefalultSetting];
    }
    return self;
}
-(void)initDefalultSetting
{
    self.layer.masksToBounds=YES;
    self.contentView.layer.masksToBounds=YES;
    self.backgroundColor =[UIColor itiColorCellBackground];
    self.backgroundColor=[UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.lineImage = [[UIImageView alloc] init];
    self.lineImage.backgroundColor = [UIColor itiColorCellLineBackground];
    [self addSubview:self.lineImage];
    self.baseMarkView=[[UIImageView alloc]init];
    self.baseMarkView.image=ImageNamed(@"Case_list_arrow");
    self.baseMarkView.contentMode=UIViewContentModeScaleAspectFit;
    self.baseMarkView.size=CGSizeMake(17, 17);
    [self addSubview:self.baseMarkView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineImage.frame = CGRectMake(0,
                                      CGRectGetHeight(self.contentView.frame) - SYBaseTableViewCell_line_height,
                                      CGRectGetWidth(self.contentView.frame), SYBaseTableViewCell_line_height);
    self.baseMarkView.frame=CGRectMake( self.width-15-self.baseMarkView.size.width,0, self.baseMarkView.size.width, self.baseMarkView.size.height);
    self.baseMarkView.centerY=self.height/2;
    self.baseMarkView.hidden=YES;
}
-(UITableView *)tableView
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        if ([next isKindOfClass:[UITableView class]]) {
            return (UITableView*)next;
        }
    }
    return nil;
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+(CGFloat)getCellHeight:(id)model
{
    return 0;
}
@end
