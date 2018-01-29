//
//  ITICellConfigModel.h
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "SYBaseModel.h"
@class XCellConfigItemModel;
@interface XCellConfigModel : SYBaseModel
PROPERTY_STRONG XCellConfigItemModel* leftConfig;
PROPERTY_STRONG XCellConfigItemModel* rightConfig;
PROPERTY_WEAK id target;
PROPERTY_ASSIGN SEL action;
PROPERTY_ASSIGN CGFloat cellHeight;
PROPERTY_ASSIGN Class cellClass;
PROPERTY_STRONG UIColor *lineColor;
PROPERTY_ASSIGN CGFloat lineHeight;
@end


@interface  XCellConfigItemModel : SYBaseModel
PROPERTY_STRONG id Image;//image or string
PROPERTY_ASSIGN float margin;
PROPERTY_ASSIGN float margin_image_title;
PROPERTY_ASSIGN UIViewContentMode contentMode;
PROPERTY_ASSIGN CGSize imageSize;
PROPERTY_STRONG NSString *title;
PROPERTY_STRONG UIColor *textColor;
PROPERTY_STRONG UIFont *font;
PROPERTY_ASSIGN NSTextAlignment alignment;
PROPERTY_ASSIGN CGFloat cornerRadius;
@end
