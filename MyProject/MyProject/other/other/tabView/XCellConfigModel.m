//
//  ITICellConfigModel.m
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "XCellConfigModel.h"
@implementation XCellConfigModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftConfig=[[XCellConfigItemModel alloc]init];
        self.leftConfig.alignment=NSTextAlignmentLeft;
        self.leftConfig.textColor=[UIColor whiteColor];
        self.leftConfig.font=UIFontWithSize(14);
        self.leftConfig.imageSize=CGSizeZero;
        self.leftConfig.margin=15;
        self.leftConfig.contentMode=UIViewContentModeScaleAspectFill;
        
        self.rightConfig=[[XCellConfigItemModel alloc]init];
        self.rightConfig.alignment=NSTextAlignmentRight;
        self.rightConfig.textColor=[UIColor greenColor];
        self.rightConfig.font=UIFontWithSize(14);
        self.rightConfig.imageSize=CGSizeZero;
        self.cellClass=[XConfigCell class];
        self.cellHeight=44;
        self.rightConfig.margin=10;
        self.rightConfig.contentMode=UIViewContentModeScaleAspectFill;
        
        self.lineColor = FNColor(243, 243, 242);
        self.lineHeight=0.5;
        self.rightConfig.margin_image_title=5;
    }
    return self;
}
@end

@implementation XCellConfigItemModel
-(void)setImage:(id)Image
{
    _Image=Image;
    if ([Image isKindOfClass:[UIImage class]]) {
        UIImage *img=(UIImage *)Image;
        _imageSize=img.size;
    }
}
@end
