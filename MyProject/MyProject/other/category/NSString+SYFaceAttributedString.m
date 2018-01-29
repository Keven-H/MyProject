//
//  UIView+SYFaceAttributedString.m
//  Foodie
//
//  Created by liyunqi on 13/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "NSString+SYFaceAttributedString.h"
#import <NSAttributedString+YYText.h>
#import "SYEmojiVIewObject.h"
@implementation  NSString(SYFaceAttributedString)
- (NSMutableAttributedString *)faceAttributedStringFromStingWithFont:(UIFont *)font
                                                         lineSpacing:(CGFloat)lineSpacing
                                                           alignment:(NSTextAlignment)alignment
{
    
   
    NSMutableAttributedString *text =[self faceAttributedWith:font];
    
    [text setLineSpacing:lineSpacing range:NSMakeRange(0, text.length)];
    [text setAlignment:alignment range:NSMakeRange(0, text.length)];
    
    return text;
}
-(NSMutableAttributedString *)faceAttributedWith:(UIFont *)font
{

    NSMutableAttributedString *text =[SYEmojiVIewObject attingWithStr:self font:font codeType:SYAttString_none];
    return text;
}
-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing size:(CGSize)size
{
    return [[self faceAttributedStringFromStingWithFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft]faceSizeString:size];
}

-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxWidth:(float)maxWidth
{
    return [self faceAttributedStringSize:font lineSpacing:lineSpacing size:CGSizeMake(maxWidth, MAXFLOAT)];
}

-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing size:(CGSize)size maxNumber:(NSInteger)maxNumberline
{
    return [[self faceAttributedStringFromStingWithFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft]faceSizeString:size maxNumberLines:maxNumberline isVerticalForm:NO];
}

@end

@implementation  NSMutableAttributedString (SYFaceAttributed)
-(CGSize)faceSizeString:(CGSize)size
{
    return [self faceSizeString:size maxNumberLines:0 isVerticalForm:NO];
}
-(CGSize)faceSizeStringVerticalForm:(CGSize)size
{
    return [self faceSizeString:size maxNumberLines:0 isVerticalForm:YES];
}
-(CGSize)faceSizeString:(CGSize)size maxNumberLines:(NSInteger)maxNumberlines isVerticalForm:(BOOL)verticalForm
{
    YYTextContainer *container = [YYTextContainer containerWithSize:size];
    container.maximumNumberOfRows=maxNumberlines;
    container.verticalForm=verticalForm;
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self];
    return layout.textBoundingSize;
}
-(CGSize)faceSizeStringWithAutoEmoji:(CGSize)size
{
    [self faceAttringResetEmoji];
    return  [self faceSizeString:size];
}
-(CGSize)faceSizeStringWithAutoEmojiVerticalForm:(CGSize)size
{
    [self faceAttringResetEmoji];
    return [self faceSizeString:size maxNumberLines:0 isVerticalForm:YES];
}
-(void)faceAttringResetEmoji
{
//    [[SYEmojiVIewObject textParse]parseText:self selectedRange:NULL];
    [[SYEmojiVIewObject syTextParse] parseText:self selectedRange:NULL];
}
-(NSMutableAttributedString *)faceAttringResetEmojiValue
{
    [self faceAttringResetEmoji];
    return self;
}

+ (CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString size:(CGSize)size numberLine:(NSInteger)numberLine
{
    if (!attributedString.length) {
        return CGSizeZero;
    }
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    
    CGSize maxSize = size;
    
    
    CFRange range = CFRangeMake(0, 0);
    if (numberLine > 0 && framesetter)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, maxSize.width, maxSize.height));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
        if (nil != lines && CFArrayGetCount(lines) > 0)
        {
            NSInteger lastVisibleLineIndex = MIN(numberLine, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            range = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        CFRelease(frame);
        CFRelease(path);
    }
    
    CGSize newsize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, maxSize, NULL);
    CFRelease(framesetter);
    return CGSizeMake(floor(newsize.width) + 1, floor(newsize.height) + 1);
    
    
}
@end
