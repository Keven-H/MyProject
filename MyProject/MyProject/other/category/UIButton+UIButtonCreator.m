//
//  UIButton+BtnCreator.m
//  CoustomButtom
//
//  Created by YC_L on 16/4/5.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import "UIButton+UIButtonCreator.h"

@implementation UIButton (UIButtonCreator)

+ (UIButton*)initBtnDefault{
    UIButton * button = [[UIButton alloc] init];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*)ButtonWithFrame:(CGRect)frame image:(UIImage *)image{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)ButtonWithFrame:(CGRect)frame image:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton*)ButtonWithFrame:(CGRect)frame font:(UIFont *)font title:(NSString *)title bgImage:(UIImage *)bgImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)ButtonWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button.titleLabel setFont:font];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)ButtonWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:buttonType];
    [button setFrame:frame];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame tag:(NSInteger)tag image:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:buttonType];
    [button setFrame:frame];
    [button setTag:tag];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame tag:(NSInteger)tag titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:buttonType];
    [button setFrame:frame];
    [button setTag:tag];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame bgImage:(UIImage *)bgImage titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:buttonType];
    [button setFrame:frame];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
          titleFont:(UIFont *)titleFont
      titleColorNor:(UIColor *)titleColorNor
      titleColorSel:(UIColor *)titleColorSel
        btnImageNor:(NSString *)imageNorStr
        btnImageSel:(NSString *)imageSelStr
 backGroundImageNor:(NSString *)backGroundImageNorStr
 backGroundImageSel:(NSString *)backGroundImageSelStr
    titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
        borderColor:(UIColor *)borderColor
        borderWidth:(CGFloat)borderWidth
       cornerRadius:(CGFloat)cornerRadius
             target:(nullable id)target
             action:(SEL)action
{
    UIButton * btn = [self initBtnDefault];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:titleFont];
    [btn setTitleColor:titleColorNor forState:UIControlStateNormal];
    [btn setTitleColor:titleColorSel forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:imageNorStr] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageSelStr] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:backGroundImageNorStr] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:backGroundImageSelStr] forState:UIControlStateSelected];
    [btn setTitleEdgeInsets:titleEdgeInsets];
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    btn.layer.cornerRadius = cornerRadius;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame
                                title:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                               target:(nullable id)target
                               action:(nullable SEL)action
{
    UIButton * btn = [self initWithFrame:frame
                                               title:title
                                           titleFont:titleFont
                                       titleColorNor:nil
                                       titleColorSel:nil
                                         btnImageNor:nil
                                         btnImageSel:nil
                                  backGroundImageNor:nil
                                  backGroundImageSel:nil
                                     titleEdgeInsets:UIEdgeInsetsZero
                                         borderColor:nil
                                         borderWidth:0
                                        cornerRadius:0
                                              target:target
                                              action:action];
    
    return btn;
}

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame
                                title:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                        titleColorNor:(nullable UIColor *)titleColorNor
                        titleColorSel:(nullable UIColor *)titleColorSel
                   backGroundImageNor:(nullable NSString *)backGroundImageNorStr
                   backGroundImageSel:(nullable NSString *)backGroundImageSelStr
                               target:(nullable id)target
                               action:(nullable SEL)action
{
    UIButton * btn = [self initWithFrame:frame
                                               title:title
                                           titleFont:titleFont
                                       titleColorNor:titleColorNor
                                       titleColorSel:titleColorSel
                                         btnImageNor:nil
                                         btnImageSel:nil
                                  backGroundImageNor:backGroundImageNorStr
                                  backGroundImageSel:backGroundImageSelStr
                                     titleEdgeInsets:UIEdgeInsetsZero
                                         borderColor:nil
                                         borderWidth:0
                                        cornerRadius:0
                                              target:target
                                              action:action];
    
    return btn;
}

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame
                                title:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                        titleColorNor:(nullable UIColor *)titleColorNor
                        titleColorSel:(nullable UIColor *)titleColorSel
                          btnImageNor:(nullable NSString *)imageNorStr
                          btnImageSel:(nullable NSString *)imageSelStr
                   backGroundImageNor:(nullable NSString *)backGroundImageNorStr
                   backGroundImageSel:(nullable NSString *)backGroundImageSelStr
                               target:(nullable id)target
                               action:(nullable SEL)action
{
    UIButton * btn = [self initWithFrame:frame
                                               title:title
                                           titleFont:titleFont
                                       titleColorNor:titleColorNor
                                       titleColorSel:titleColorSel
                                         btnImageNor:imageNorStr
                                         btnImageSel:imageSelStr
                                  backGroundImageNor:backGroundImageNorStr
                                  backGroundImageSel:backGroundImageSelStr
                                     titleEdgeInsets:UIEdgeInsetsZero
                                         borderColor:nil
                                         borderWidth:0
                                        cornerRadius:0
                                              target:target
                                              action:action];
    
    return btn;
}

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame
                                title:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                        titleColorNor:(nullable UIColor *)titleColorNor
                        titleColorSel:(nullable UIColor *)titleColorSel
                          btnImageNor:(nullable NSString *)imageNorStr
                          btnImageSel:(nullable NSString *)imageSelStr
                   backGroundImageNor:(nullable NSString *)backGroundImageNorStr
                   backGroundImageSel:(nullable NSString *)backGroundImageSelStr
                      titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                          borderColor:(nullable UIColor *)borderColor
                          borderWidth:(CGFloat)borderWidth
                         cornerRadius:(CGFloat)cornerRadius
                               target:(nullable id)target
                               action:(nonnull SEL)action
{
    UIButton * btn = [self initWithFrame:frame
                                               title:title
                                           titleFont:titleFont
                                       titleColorNor:titleColorNor
                                       titleColorSel:titleColorSel
                                         btnImageNor:imageNorStr
                                         btnImageSel:imageSelStr
                                  backGroundImageNor:backGroundImageNorStr
                                  backGroundImageSel:backGroundImageSelStr
                                     titleEdgeInsets:titleEdgeInsets
                                         borderColor:borderColor
                                         borderWidth:borderWidth
                                        cornerRadius:cornerRadius
                                              target:target action:action];
    
    return btn;
}

@end
