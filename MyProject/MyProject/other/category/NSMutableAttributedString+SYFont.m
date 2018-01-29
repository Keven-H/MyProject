//
//  NSMutableAttributedString+SYFont.m
//  Foodie
//
//  Created by liyunqi on 16/3/22.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "NSMutableAttributedString+SYFont.h"

@implementation NSMutableAttributedString (SYFont)

UIFont * GetVariationOfFontWithTrait(UIFont *baseFont,
                                     CTFontSymbolicTraits trait) {
    CGFloat fontSize = [baseFont pointSize];
    CFStringRef
    baseFontName = (__bridge CFStringRef)[baseFont fontName];
    CTFontRef baseCTFont = CTFontCreateWithName(baseFontName,
                                                fontSize, NULL);
    CTFontRef ctFont =
    CTFontCreateCopyWithSymbolicTraits(baseCTFont, 0, NULL,
                                       trait, trait);
    NSString *variantFontName =
    CFBridgingRelease(CTFontCopyName(ctFont,
                                     kCTFontPostScriptNameKey));
    
    UIFont *variantFont = [UIFont fontWithName:variantFontName
                                          size:fontSize];
//    CFRelease(ctFont);
    CFRelease(baseCTFont);
    return variantFont;
};

- (void)setTextColor:(UIColor*)color
{
    [self setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextColor:(UIColor*)color range:(NSRange)range
{
    if (color.CGColor)
    {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName
                     value:(id)color.CGColor
                     range:range];
    }
    
}
-(void)setTextColorWithAttName:(UIColor *)color range:(NSRange)range
{
    //     [self removeAttribute:NSForegroundColorAttributeName range:range];
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)setFont:(UIFont*)font
{
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(UIFont*)font range:(NSRange)range
{
    if (font)
    {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        
        CTFontRef fontRef = CTFontCreateWithName((__bridge void *)font.fontName, font.pointSize, nil);
        if (nil != fontRef)
        {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}
-(void)setBackColor:(UIColor *)color range:(NSRange )range
{
    if (color) {
        [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
    }
}
- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
{
    [self setUnderlineStyle:style
                   modifier:modifier
                      range:NSMakeRange(0, self.length)];
}

- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range
{
    [self removeAttribute:(NSString *)kCTUnderlineColorAttributeName range:range];
    [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                 value:[NSNumber numberWithInt:(style|modifier)]
                 range:range];
    
}
-(void)setXieTi:(UIFont *)font range:(NSRange)range
{
    UIFont *italicFont = GetVariationOfFontWithTrait(font,
                                                     kCTFontTraitItalic);
    [self addAttribute:NSFontAttributeName value:italicFont
                       range:range];
}
-(void)setDeleLine:(NSUnderlineStyle)style range:(NSRange)range
{
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:style] range:range];
    //    [self addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
}
@end
