//
//  UIColor+ITIColor.m
//  myFrameworkDemo
//
//  Created by liyunqi on 20/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "UIColor+ITIColor.h"

@implementation UIColor (ITIColor)
+(UIColor *)itiColor62_142_189
{
    return FNColor(62, 142, 189);
}
+(UIColor *)itiColorCellLineBackground
{
//
    return [self hexStringToColor:@"DEDEDE"];
}
+(UIColor *)itiColor51_51_51
{
    return FNColor(51, 51, 51);
}
+(UIColor *)itiColorCellBackground
{
    return   FNColor(243, 243, 243);
}
+(UIColor *)itiColor240_239_245
{
    return FNColor(240, 239, 245);
}

+(UIColor *)itiBCBCBC
{
    return [self hexStringToColor:@"bcbcbc"];
}
+(UIColor *)itiFFCD00
{
    return [self hexStringToColor:@"FFCD00"];
}



+(UIColor *)C_1
{
    return [self hexStringToColor:@"FFCD00"];
}
+(UIColor *)C_2
{
    return [self hexStringToColor:@"2D3240"];
}
+(UIColor *)C_3
{
    return [self hexStringToColor:@"333333"];
} 
+(UIColor *)C_4
{
    return [self hexStringToColor:@"666666"];
}
+(UIColor *)C_5
{
    return [self hexStringToColor:@"999999"];
}
+(UIColor *)C_6
{
    return [self hexStringToColor:@"CACACA"];
}
+(UIColor *)F7F7F7
{
    return [self hexStringToColor:@"F7F7F7"];
}
+(UIColor *)FFAC30
{
    return [self hexStringToColor:@"FFAC30"];
}
+(UIColor *)F58051
{
    return [self hexStringToColor:@"F58051"];
}
+(UIColor *)FF5B5F
{
    return [self hexStringToColor:@"FF5B5F"];
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
