//
//  SYlocationModel.h
//  Foodie
//
//  Created by liyunqi on 16/3/29.
//  Copyright © 2016年 SY. All rights reserved.
//



@interface SYlocationModel : SYBaseModel
PROPERTY_ASSIGN float lat;
PROPERTY_ASSIGN float lng;
PROPERTY_STRONG NSString *time;
PROPERTY_STRONG NSString *city;
PROPERTY_STRONG NSString *cityCode;
PROPERTY_STRONG NSString *citiTime;
@end
