//
//  SYShareQRCodeContentView.m
//  Foodie
//
//  Created by liyunqi on 11/7/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareQRCodeContentView.h"
#import "UIImage+SYUIImageCategory.h"
@interface SYShareQRCodeContentView()
{
    UIImageView *imageView;
    UILabel *desLable;
    UIView *view;
}
@end
@implementation SYShareQRCodeContentView
- (instancetype)init
{
    self = [super init];
    if (self) {
        view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        view.clipsToBounds=YES;
        view.layer.cornerRadius=5;
        view.layer.masksToBounds=YES;
        [self addSubview:view];
        self.leftMargin=10;
        self.topMargin=10;
        imageView=[[UIImageView alloc]init];
        [view addSubview:imageView];
        desLable=[[UILabel alloc]init];
        desLable.backgroundColor=[UIColor clearColor];
        desLable.font=UIFontWithSize(13);
        desLable.textColor=FNColor(81, 81, 81);
        desLable.text=@"长按图片,识别二维码,了解更多详情";
        desLable.height=[desLable.text sizeWithTextFont:desLable.font maxWidth:1000].height;
        desLable.numberOfLines=1;
        desLable.textAlignment=NSTextAlignmentCenter;
        [view addSubview:desLable];
    }
    return self;
}
-(void)resetQRStr:(NSString *)str
{
    float imageWidth=112;
    float viewTop=24;
    float imageLabel=21;
    float buttom=24;
    self.frame=CGRectMake(0,0, SCREEN_WIDTH, imageWidth+viewTop+imageLabel+buttom+desLable.height+self.topMargin*2);
    view.frame=CGRectMake(self.leftMargin, self.topMargin, self.width-self.leftMargin*2, self.height-self.topMargin*2);
    desLable.frame=CGRectMake(0, view.height-desLable.height-buttom, view.width, desLable.height);
    imageView.frame=CGRectMake(0, viewTop,imageWidth, imageWidth);
    imageView.image=[UIImage qrCodeImageWithContent:str codeImageSize:imageView.width*[UIScreen mainScreen].scale logo:nil logoFrame:CGRectZero red:117 green:117 blue:117];
    imageView.centerX=view.width/2;
}
@end
