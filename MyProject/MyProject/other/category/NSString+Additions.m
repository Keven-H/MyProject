//
//  NSString+Additions.m
//  MeiShiJ
//
//  Created by Meishi on 14-5-19.
//  Copyright (c) 2014年 MeiShiJ. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
extern BOOL SYStringisEmpty(NSString *str)
{
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (str == nil) return YES;
    if ([str isKindOfClass:[NSNull class]]) return YES;
    if ([str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) return YES;
    if ([str isEqualToString:@""]) return YES;
    
    return NO;
}

@implementation NSString (dataAdditions)

- (BOOL)isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (id)parseValue
{
    if (SYStringisEmpty(self)) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id rValue = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    return rValue;
}

- (BOOL)isContain:(NSString *)str
{
    //字符串不能为空
    return [self rangeOfString:str].location != NSNotFound;
}

- (BOOL)isContainNull
{
    return [self rangeOfString:@"null"].location != NSNotFound || [self rangeOfString:@"NULL"].location != NSNotFound;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

-(CGSize)sizeWithTextFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return [NSString text:self sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)];
}
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (!font) {
        NSLog(@"计算字体大小font=nil");
        return CGSizeZero;
        
    }
    if (SYStringisEmpty(text)) {
        return CGSizeZero;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        CGRect frame = [text boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        CGSize size = CGSizeMake((int)frame.size.width + 1, frame.size.height);
        
        return size;
    }
#endif
    return [text sizeWithFont:font constrainedToSize:size];
}




-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing
{
    
    
    return [self boundingRectWithSize:size withTextFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
{
    if (self.length<=0) {
        return [[NSMutableAttributedString alloc]init];
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    return attributedStr;
}

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
{
    return [self attributedStringFromStingWithFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}


-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
                    alignment:(NSTextAlignment)alignment
{
    if (SYStringisEmpty(self)) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font
                                                                            lineSpacing:lineSpacing
                                                                              alignment:alignment];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    //    CGSize textSize=[self adjustSizeWithAttributedString:attributedText maxWidth:size.width numberLine:0];
    return textSize;
}
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
{
    NSMutableAttributedString *attributedText= [self attributedStringFromStingWithFont:font];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    return textSize;
}

- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                     lineSpacing:(CGFloat)lineSpacing
                                                       alignment:(NSTextAlignment)alignment

{
    if (self.length<=0) {
        return [[NSMutableAttributedString alloc]init];
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:alignment];
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}
+(NSString *)Currentmillisecond
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",time];
}
+(NSString *)createDateStringyyyyMMdd
{
    return [self createDateStringWithFormat:@"yyyyMMdd"];
}
+(NSString *)createDateStringWithFormat:(NSString *)formatstr
{
    if (SYStringisEmpty(formatstr)) {
        return  @"";
    }
    NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
    [outputFormat setDateFormat:formatstr];
    NSDate *date = [NSDate date];
    return [outputFormat stringFromDate:date];
}
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input

{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

#pragma mark-汉字相关
/**
 *  截取字符串到指定的长度
 *  strtemp 原始字符串
 *  maxlength   最大长度，注意此处表示的中文长度
 */
+ (NSString *) subStringWithString:(NSString *) strtemp
                         maxLength:(NSInteger) maxlenth
{
    NSMutableString *appString = [NSMutableString string];
    NSInteger length = [self convertStringLengthToInt:strtemp];
    if(length <= maxlenth * 2)
        [appString appendString:strtemp];
    else
    {
        if(length > maxlenth * 2 * 2)
        {
            NSInteger endIndex = maxlenth * 2;
            for(;endIndex >= 0 ; endIndex--)
            {
                @autoreleasepool {
                    NSString *tempString = [strtemp substringToIndex:endIndex];
                    NSInteger templength = [self convertStringLengthToInt:tempString];
                    if(templength <= maxlenth * 2)
                    {
                        //                        [MBProgressHelp show:@"标签不能超过12个字符!" icon:nil view:self.superview image:@"mark"];
                        [appString appendString:tempString];
                        break;
                    }
                }
            }
        }
        else
        {
            NSInteger startIndex = 0;
            for(;startIndex < maxlenth * 2; startIndex ++)
            {
                @autoreleasepool {
                    NSString *tempString = [strtemp substringToIndex:startIndex];
                    NSInteger templength = [self convertStringLengthToInt:tempString];
                    if(templength > maxlenth * 2)
                    {
                        //                        [MBProgressHelp show:nil icon:nil view:self.superview image:@"mark"];
                        break;
                    }
                }
            }
            [appString appendString:[strtemp substringToIndex:startIndex - 1]];
        }
    }
    return appString;
}

+ (NSInteger)convertStringLengthToInt:(NSString*)strtemp
{
    int strlength = 0;
    if ([strtemp length] <= 0)
        return 0;
    
    char* bytes = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*bytes)
        {
            bytes++;
            strlength++;
        }
        else
        {
            bytes++;
        }
    }
    return strlength;
}

// 计算汉字的个数
+ (NSInteger)chineseCountOfString:(NSString*)string
{
    int ChineseCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >= 0x4E00 && c <= 0x9FA5) {
            ChineseCount++; // 汉字
        }
    }
    return ChineseCount;
}

// 计算字母的个数
+ (NSInteger)characterCountOfString:(NSString*)string
{
    int characterCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >= 0x4E00 && c <= 0x9FA5) {
        }
        else {
            characterCount++; // 英文
        }
    }
    return characterCount;
}

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isAllEmptyBlank:(NSString *) str
{
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


@end

#pragma mark - base64加密

#pragma GCC diagnostic ignored "-Wselector"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif


@implementation NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
        
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
        
#endif
        
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)base64EncodedString
{
    return [self base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (Base64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString
{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}

@end


#pragma mark - NSDictionary
@implementation NSDictionary (Data)

- (NSString *)JSONRepresentation
{
    NSError *error;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        return [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    }else
    {
        NSLog(@"Got an error: %@", error);
    }
    return nil;
}

@end

@implementation NSArray (Data)

- (NSString *)JSONRepresentation
{
    NSError *error;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        return [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    }else
    {
        NSLog(@"Got an error: %@", error);
    }
    return nil;
}

@end
