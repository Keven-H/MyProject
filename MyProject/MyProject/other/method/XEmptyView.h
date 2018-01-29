//
//  XEmptyView.h
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "LYEmptyView.h"

@interface XEmptyView : LYEmptyView
+ (instancetype)diyEmptyView;

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action;

+ (instancetype)diyEmptyActionViewWithbtnClickBlock:(LYActionTapBlock)btnClickBlock info:(NSDictionary *)info;

+ (instancetype)diyServerErrorView;
@end
