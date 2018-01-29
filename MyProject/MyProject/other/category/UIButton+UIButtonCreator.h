//
//  UIButton+BtnCreator.h
//  CoustomButtom
//
//  Created by YC_L on 16/4/5.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonCreator)

+ (nonnull UIButton*)ButtonWithFrame:(CGRect)frame image:(nullable UIImage *)image;

+ (nonnull UIButton*)ButtonWithFrame:(CGRect)frame image:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton*)ButtonWithFrame:(CGRect)frame font:(nullable UIFont *)font title:(nullable NSString *)title bgImage:(nullable UIImage *)bgImage;

+ (nonnull UIButton*)ButtonWithFrame:(CGRect)frame font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor;

+ (nonnull UIButton*)ButtonWithFrame:(CGRect)frame title:(nullable NSString *)title;

+ (nonnull UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame tag:(NSInteger)tag image:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame tag:(NSInteger)tag titleColor:(nullable UIColor *)titleColor titleFont:(nullable UIFont *)titleFont title:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton*)ButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame bgImage:(nullable UIImage *)bgImage titleColor:(nullable UIColor *)titleColor titleFont:(nullable UIFont *)titleFont title:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame title:(nullable NSString *)title titleFont:(nullable UIFont *)titleFont target:(nullable id)target action:(nullable SEL)action;

+ (nonnull UIButton *)ButtonWithFrame:(CGRect)frame
                                title:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                        titleColorNor:(nullable UIColor *)titleColorNor
                        titleColorSel:(nullable UIColor *)titleColorSel
                   backGroundImageNor:(nullable NSString *)backGroundImageNorStr
                   backGroundImageSel:(nullable NSString *)backGroundImageSelStr
                               target:(nullable id)target
                               action:(nullable SEL)action;

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
                               action:(nullable SEL)action;

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
                               action:(nonnull SEL)action;

@end
