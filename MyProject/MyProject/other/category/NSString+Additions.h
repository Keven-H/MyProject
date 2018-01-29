//
//  NSString+Additions.h
//  MeiShiJ
//
//  Created by Meishi on 14-5-19.
//  Copyright (c) 2014年 MeiShiJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (dataAdditions)

/**
 *  @brief  md5加密
 *
 *  @return 返回加密后的字符串
 */


/**
 是否是纯数字

 */
- (BOOL)isPureInt;
- (NSString *)md5;

/**
 *  @brief  是否包含某一个字符串
 *
 *  @param  要查找的字符串
 *  @return
 */
- (BOOL)isContain:(NSString *)str;

/**
 *  @brief  是否包含null或者NULL
 *  
*/
- (BOOL)isContainNull;

/**
 *  数据解析
 */
- (id)parseValue;


/**
 *  @brief 计算字符串size 方法
 *  @param  text text
 *  @param  font font
 *  @param  size 最大size
 *  @return  text
 *  @author 李云齐
 */
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

-(CGSize)sizeWithTextFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing;

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font;

-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
                    alignment:(NSTextAlignment)alignment;

-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font;
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                     lineSpacing:(CGFloat)lineSpacing
                                                       alignment:(NSTextAlignment)alignment;
+(NSString *)Currentmillisecond;
+(NSString *)createDateStringyyyyMMdd;
+(NSString *)createDateStringWithFormat:(NSString *)formatstr;
/**
 * 过滤表情字符
 */
- (NSString *)disable_emoji:(NSString *)text;


/**
 url encode 反解码
 */
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
//汉子相关
/**
 *  截取字符串到指定的长度
 *  strtemp 原始字符串
 *  maxlength   最大长度，注意此处表示的中文长度
 */
+ (NSString *) subStringWithString:(NSString *) strtemp
                         maxLength:(NSInteger) maxlenth;

/**
 *  计算字符串的长度
 *
 *  @param strtemp NSString
 *
 *  @return NSInteger
 */
+ (NSInteger)convertStringLengthToInt:(NSString*)strtemp;
// 计算汉字的个数
+ (NSInteger)chineseCountOfString:(NSString*)string;
// 计算字母的个数
+ (NSInteger)characterCountOfString:(NSString*)string;
//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isAllEmptyBlank:(NSString *)str;
@end

#pragma mark - base64

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end


@interface NSString (Base64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;

@end

@interface NSDictionary (json)

- (NSString *)JSONRepresentation;

@end

@interface NSArray (json)

- (NSString *)JSONRepresentation;

@end


/**
 *  数据解析
 */
extern BOOL SYStringisEmpty(NSString *str);
