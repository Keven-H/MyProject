//
//  UILabel+UILabelCreator.m
//  CoustromLabel
//
//  Created by YC_L on 16/4/6.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import "UILabel+UILabelCreator.h"

@implementation UILabel (UILabelCreator)

+ (id)initLabelDefault{
    UILabel * label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor clearColor]];
    
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font center:(CGPoint)center textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [self initLabelDefault];
    [label setText:text];
    [label setTextColor:textColor];
    [label setFont:font];
    [label setCenter:center];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] initWithFrame:frame] ;
    [label setText:text];
    [label setTextAlignment:textAlignment];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] initWithFrame:frame] ;
    [label setText:text];
    [label setFont:font];
    [label setTextAlignment:textAlignment];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] initWithFrame:frame] ;
    [label setText:text];
    [label setTextColor:textColor];
    [label setTextAlignment:textAlignment];
    [label setFont:font];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] initWithFrame:frame] ;
    [label setTextColor:textColor];
    [label setTextAlignment:textAlignment];
    [label setFont:font];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)LabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] initWithFrame:frame] ;
    [label setTextColor:textColor];
    [label setFont:font];
    [label setText:text];
    [label setTextAlignment:textAlignment];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

@end
