//
//  XInputCheckerer.h
//  XTestApp
//
//  Created by 兰彪 on 15/6/2.
//  Copyright © 2015年 lanbiao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  检查器错误
 */
typedef NS_ENUM(NSInteger,XInputCheckerErrorType) {
    /**
     *  默认没有错误
     */
    XInputCheckerErrorTypeNone = 0,
    /**
     *  内容为空
     */
    XInputCheckerErrorTypeNull = XInputCheckerErrorTypeNone + 1,
    /**
     *  长度太短
     */
    XInputCheckerErrorTypeSoShort = XInputCheckerErrorTypeNull + 1,
    /**
     *  长度太长
     */
    XInputCheckerErrorTypeSoLong = XInputCheckerErrorTypeSoShort + 1,
    /**
     *  太小
     */
    XInputCheckerErrorTypeSoSmall = XInputCheckerErrorTypeSoLong + 1,
    /**
     *  太大
     */
    XInputCheckerErrorTypeSoMax = XInputCheckerErrorTypeSoSmall + 1,
    
    /**
     *  不符合约束要求
     */
    XInputCheckerErrorTypeRegex = XInputCheckerErrorTypeSoMax + 1,
};


typedef void(^checkResponseBlock)(XInputCheckerErrorType errorType);


/**
 *  文本输入
 */
@interface XInputChecker : NSObject<UITextViewDelegate,UITextFieldDelegate>

/**
 *  构造密码的合法性检查器
 *
 *  @param minLength 最小的长度
 *  @param maxLength 最大的长度
 *
 *  @return 返回密码检查器
 */
+ (XInputChecker *) passWordCheckerWithMinLength:(NSInteger) minLength
                                       maxLength:(NSInteger) maxLength
                              checkResponseBlock:(checkResponseBlock) block;

/**
 *  构造电话号码的合法性检查
 *
 *  @return 返回电话号码校验器
 */
+ (XInputChecker *) telCheckerWithCheckResponseBlock:(checkResponseBlock) block;

/**
 *  构造邮箱的合法性检查
 *
 *  @return 返回邮箱校验器
 */
+ (XInputChecker *) mailCheckerWithCheckResponseBlock:(checkResponseBlock) block;

/**
 *  构造金额的合法性检查
 *
 *  @param max                最大金额
 *  @param min                最小金额
 *  @param validDecimalLength 有效小数点位数
 *
 *  @return 返回金额校验器
 */
+ (XInputChecker *) moneyCheckerWithMax:(double) max
                                    min:(double) min
                     validDecimalLength:(NSInteger) validDecimalLength
                     checkResponseBlock:(checkResponseBlock) block;

/**
 *  构造浮点型的合法性检查
 *
 *  @param max                最大浮点数
 *  @param min                最小浮点数
 *  @param validDecimalLength 有效小数点位数
 *
 *  @return 返回浮点型校验器
 */
+ (XInputChecker *) doubleCheckerWithMax:(double) max
                                    min:(double) min
                     validDecimalLength:(NSInteger) validDecimalLength
                      checkResponseBlock:(checkResponseBlock) block;

/**
 *  构造整形的合法性检查
 *
 *  @param max 最大整数
 *  @param min 最小整数
 *
 *  @return 返回整形校验器
 */
+ (XInputChecker *) intCheckerWithMax:(NSInteger) max
                                  min:(NSInteger) min
                   checkResponseBlock:(checkResponseBlock) block;

/**
 *  构造字符串长度合法检查器，长度单位为1个ASCll码，汉字为2个ASCll
 *
 *  @param max 最大长度
 *  @param min 最小长度
 *
 *  @return 返回字符串长度检查器
 */
+ (XInputChecker *) stringLengthCheckerWithMax:(NSInteger) max
                                           min:(NSInteger) min
                            checkResponseBlock:(checkResponseBlock) block;
@end
