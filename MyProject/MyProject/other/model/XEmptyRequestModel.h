//
//  XEmptyRequestModel.h
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface XEmptyRequestModel : XData
PROPERTY_STRONG NSDictionary *dic;
PROPERTY_WEAK UIViewController *controller;
PROPERTY_ASSIGN Class className;
PROPERTY_COPY  SYResponseBlock responseBlock;
@end
