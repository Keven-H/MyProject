//
//  UILabel+UILabelCreator.h
//  CoustromLabel
//
//  Created by YC_L on 16/4/6.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabelCreator)

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font center:(CGPoint)center textAlignment:(NSTextAlignment)textAlignment;

+ (id)LabelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

+ (id)LabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

+ (id)LabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

@end
