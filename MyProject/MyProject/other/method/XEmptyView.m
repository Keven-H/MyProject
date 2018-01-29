//
//  XEmptyView.m
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "XEmptyView.h"

@implementation XEmptyView

+ (instancetype)diyEmptyView{
    
    return [XEmptyView emptyViewWithImageStr:@"error_sorry" titleStr:nil detailStr:@"没有数据，请稍后再试..."];
}

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action{
    
    return [XEmptyView emptyActionViewWithImageStr:@"error_sorry" titleStr:@"无网络连接" detailStr:@"请检查你的网络连接是否正确!" btnTitleStr:@"重新加载" target:target action:action];
}
+ (instancetype)diyEmptyActionViewWithbtnClickBlock:(LYActionTapBlock)btnClickBlock info:(NSDictionary *)info
{
    XEmptyView *view=[XEmptyView emptyActionViewWithImageStr:@"error_sorry" titleStr:nil detailStr:@"网络断开了\r\n请检查您的网络..." btnTitleStr:@"重新加载" btnClickBlock:btnClickBlock];
    view.info=info;
    return view;;
}
+ (instancetype)diyServerErrorView
{
    return  [XEmptyView emptyViewWithImageStr:@"error_sorry" titleStr:nil detailStr:@"没有数据，请稍后再试..." ];
}

- (void)prepare{
    [super prepare];
    self.detailLabTextColor=[UIColor C_5];
    self.detailLabFont=UIFontWithSize(14);
    
    
//        self.autoShowEmptyView = NO;
    
}

@end
