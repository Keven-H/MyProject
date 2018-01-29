//
//  SYEmojiVIewObject.h
//  Foodie
//
//  Created by liyunqi on 12/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTextParser.h"
#import "YYTextLayout.h"
#import "SYTextSimpleEmoticonParser.h"
typedef enum
{
    SYAttString_none= 1<<0,
    SYAttString_line=1<<1,
    SYAttString_number=1<<2,
    SYAttString_at=1<<3,
}SYAttStringCode;
@interface SYEmojiVIewObject : NSObject

+ (BOOL)stringContainsEmoji:(NSString *)string ;//是否包含emoji
+(NSArray *)matchesInString:(NSString *)reges string:(NSString *)content;
+ (NSArray*)getEmojiArray;
+(NSArray*)getDefaultImageArray;
+(NSArray *)getDefaultNameArray;

+(NSDictionary *)faceDic;


+(NSMutableAttributedString *)attingWithStr:(NSString *)content font:(UIFont *)font codeType:(SYAttStringCode)codeString;
+(YYTextSimpleEmoticonParser *)textParse;
+(SYTextSimpleEmoticonParser *)syTextParse;

+(BOOL)deleKeyChars:(id)textView;
@end
