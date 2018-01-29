//
//  SYITIConfigCell.m
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "XConfigCell.h"
@interface XConfigCell()
{
    
}

@end
@implementation XConfigCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftName=[[UILabel alloc]init];
        self.leftName.textColor=[UIColor blackColor];
        self.leftName.font=UIFontWithBoldSize(15);
        self.leftName.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.leftName];
        
        self.leftImageView=[[UIImageView alloc]init];
        [self addSubview:self.leftImageView];
        
        
        self.rigthName=[[UILabel alloc]init];
        self.rigthName.textColor=[UIColor blackColor];
        self.rigthName.font=UIFontWithBoldSize(15);
        self.rigthName.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.rigthName];
        
        self.rigthImageView=[[UIImageView alloc]init];
        [self addSubview:self.rigthImageView];

        
    }
    return self;
}
-(void)setConfigModel:(XCellConfigModel *)configModel
{
    _configModel=configModel;
    
    self.leftName.textColor=configModel.leftConfig.textColor;
    self.leftName.textAlignment=configModel.leftConfig.alignment;
    self.leftName.font=configModel.leftConfig.font;
    self.leftName.text=configModel.leftConfig.title;
    if ([configModel.leftConfig.Image isKindOfClass:[NSString class]]) {
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:configModel.leftConfig.Image]];
    }
    if ([configModel.leftConfig.Image isKindOfClass:[UIImage class]]) {
        self.leftImageView.image=configModel.leftConfig.Image;
    }
    
    
    self.rigthName.textColor=configModel.rightConfig.textColor;
    self.rigthName.textAlignment=configModel.rightConfig.alignment;
    self.rigthName.font=configModel.rightConfig.font;
    self.rigthName.text=configModel.rightConfig.title;
    if ([configModel.rightConfig.Image isKindOfClass:[NSString class]]) {
        [self.rigthImageView sd_setImageWithURL:[NSURL URLWithString:configModel.rightConfig.Image]];
    }
    if ([configModel.rightConfig.Image isKindOfClass:[UIImage class]]) {
        self.rigthImageView.image=configModel.rightConfig.Image;
    }
    self.leftImageView.contentMode=configModel.leftConfig.contentMode;
    self.rigthImageView.contentMode=configModel.rightConfig.contentMode;
    self.lineImage.backgroundColor=self.configModel.lineColor;
    
    [self setNeedsLayout];

}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.lineImage.frame=CGRectMake(0, 0, self.width, self.configModel.lineHeight);
    self.lineImage.y=self.height-self.lineImage.height;
    CGFloat heigth=self.height-self.configModel.lineHeight;;
    self.leftImageView.hidden=self.configModel.leftConfig.Image?NO:YES;
    self.leftName.hidden=SYStringisEmpty(self.configModel.leftConfig.title)?YES:NO;;
    self.rigthImageView.hidden=self.configModel.rightConfig.Image?NO:YES;
    self.rigthName.hidden=SYStringisEmpty(self.configModel.rightConfig.title)?YES:NO;
    self.leftImageView.frame=CGRectMake(self.configModel.leftConfig.margin, 0, self.configModel.leftConfig.imageSize.width, self.configModel.leftConfig.imageSize.height);
    self.leftName.frame=CGRectMake(self.leftImageView.right+self.configModel.leftConfig.margin_image_title, 0, 200, heigth);
    self.rigthImageView.frame=CGRectMake(self.width-self.configModel.rightConfig.margin-self.configModel.rightConfig.imageSize.width, 0, self.configModel.rightConfig.imageSize.width, self.configModel.rightConfig.imageSize.height);
    self.rigthName.frame=CGRectMake(self.rigthImageView.x-self.configModel.rightConfig.margin_image_title-self.width/2, 0, self.width/2, heigth);
    self.leftImageView.centerY=heigth/2;
    self.leftName.centerY=heigth/2;
    self.rigthImageView.centerY=heigth/2;
    self.rigthName.centerY=heigth/2;
    self.leftImageView.layer.cornerRadius=self.configModel.leftConfig.cornerRadius;
    self.rigthImageView.layer.cornerRadius=self.configModel.rightConfig.cornerRadius;
    self.rigthImageView.layer.masksToBounds=YES;
    if (self.rigthImageView.hidden==YES&&self.rigthName.hidden==YES&&self.configModel.leftConfig.alignment==NSTextAlignmentCenter) {
        self.leftName.centerX=self.width/2;
    }
}
@end
