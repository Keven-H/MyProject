//
//  SYShareQRCodeView.m
//  Foodie
//
//  Created by liyunqi on 11/3/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareQRCodeView.h"
#import "UIImage+SYUIImageCategory.h"
@interface SYShareQRCodeView()
{
    UIImageView *imageView;
    UILabel *desLable;
    SYImageObjView *avatarView;
}
@end
@implementation SYShareQRCodeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        imageView=[[UIImageView alloc]init];
        [self addSubview:imageView];
        desLable=[[UILabel alloc]init];
        desLable.backgroundColor=[UIColor clearColor];
        desLable.font=UIFontWithSize(10);
        desLable.textColor=FNColor(153, 153, 153);
        desLable.text=@"长按图片，识别二维码\n查看笔记详情";
        desLable.height=[desLable.text sizeWithTextFont:desLable.font maxWidth:1000].height;
        desLable.numberOfLines=0;
        [self addSubview:desLable];
        avatarView=[[SYImageObjView alloc]init];
        avatarView.placeType=SYImageViewPlaceImage_default;
        avatarView.layer.cornerRadius=2;
        avatarView.layer.masksToBounds=YES;
        [self addSubview:avatarView];
    }
    return self;
}
-(void)resetWithStr:(NSString *)qrstr avatar:(NSString *)avatar
{
//    [avatarView setImageWithPath:avatar];
    avatarView.image=ImageNamed(@"sy_share_login");
    imageView.image=[UIImage qrCodeImageWithContent:qrstr codeImageSize:self.height*[UIScreen mainScreen].scale logo:nil logoFrame:CGRectZero red:0 green:0 blue:0];
    [self setNeedsLayout];
}
-(void)setLeftMargin:(float)leftMargin
{
    _leftMargin=leftMargin;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame=CGRectMake(self.leftMargin, 0, self.height, self.height);
    desLable.frame=CGRectMake(imageView.width+imageView.x+12, 0, 200, imageView.height);
    avatarView.frame=CGRectMake(self.width-self.leftMargin-imageView.width, 2, imageView.width-4, imageView.width-4);
}
@end
