//
//  SYTextSimpleEmoticonParser.m
//  Foodie
//
//  Created by liyunqi on 19/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYTextSimpleEmoticonParser.h"
//#import "SYLock.h"
#import <NSAttributedString+YYText.h>
#import "NSMutableAttributedString+SYFaceAtt.h"
@interface SYTextSimpleEmoticonParser()
{
    NSRegularExpression *_regex;
    NSDictionary *_mapper;
    NSLock  *lock;
}
@end
@implementation SYTextSimpleEmoticonParser
- (instancetype)init {
    self = [super init];
    lock  = [[NSLock alloc]init];
    return self;
}
- (NSDictionary *)emoticonMapper {
    NSDictionary *mapper = _mapper;
    return mapper ;
}

- (void)setEmoticonMapper:(NSDictionary *)emoticonMapper {
    [lock lock];
    _mapper = [emoticonMapper copy];
    if (_mapper.count == 0) {
        _regex = nil;
    } else {
        NSMutableString *pattern = @"(".mutableCopy;
        NSArray *allKeys = _mapper.allKeys;
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"$^?+*.,#|{}[]()\\"];
        for (NSUInteger i = 0, max = allKeys.count; i < max; i++) {
            NSMutableString *one = [allKeys[i] mutableCopy];

            for (NSUInteger ci = 0, cmax = one.length; ci < cmax; ci++) {
                unichar c = [one characterAtIndex:ci];
                if ([charset characterIsMember:c]) {
                    [one insertString:@"\\" atIndex:ci];
                    ci++;
                    cmax++;
                }
            }
            
            [pattern appendString:one];
            if (i != max - 1) [pattern appendString:@"|"];
        }
        [pattern appendString:@")"];
        _regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    }
    [lock unlock];
}

// correct the selected range during text replacement
- (NSRange)_replaceTextInRange:(NSRange)range withLength:(NSUInteger)length selectedRange:(NSRange)selectedRange {
    // no change
    if (range.length == length) return selectedRange;
    // right
    if (range.location >= selectedRange.location + selectedRange.length) return selectedRange;
    // left
    if (selectedRange.location >= range.location + range.length) {
        selectedRange.location = selectedRange.location + length - range.length;
        return selectedRange;
    }
    // same
    if (NSEqualRanges(range, selectedRange)) {
        selectedRange.length = length;
        return selectedRange;
    }
    // one edge same
    if ((range.location == selectedRange.location && range.length < selectedRange.length) ||
        (range.location + range.length == selectedRange.location + selectedRange.length && range.length < selectedRange.length)) {
        selectedRange.length = selectedRange.length + length - range.length;
        return selectedRange;
    }
    selectedRange.location = range.location + length;
    selectedRange.length = 0;
    return selectedRange;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)range {
    if (text.length == 0) return NO;
    
    NSDictionary *mapper;
    NSRegularExpression *regex;
    [lock lock];
    mapper=_mapper;
    regex=_regex;
    [lock unlock];
    if (mapper.count == 0 || regex == nil) return NO;
    
    NSArray *matches = [regex matchesInString:text.string options:kNilOptions range:NSMakeRange(0, text.length)];
    if (matches.count == 0) return NO;
    
    NSRange selectedRange = range ? *range : NSMakeRange(0, 0);
    NSUInteger cutLength = 0;
    for (NSUInteger i = 0, max = matches.count; i < max; i++) {
        NSTextCheckingResult *one = matches[i];
        NSRange oneRange = one.range;
        if (oneRange.length == 0) continue;
        oneRange.location -= cutLength;
        NSString *subStr = [text.string substringWithRange:oneRange];
        UIImage *emoticon = mapper[subStr];
        if (!emoticon) continue;
        
        CGFloat fontSize = 12;
        CTFontRef font = (__bridge CTFontRef)([text attribute:NSFontAttributeName atIndex:oneRange.location]);
        if (font) fontSize = CTFontGetSize(font);
        NSMutableAttributedString *atr = [NSMutableAttributedString sy_attachmentStringWithEmojiImage:emoticon fontSize:fontSize];
        [atr setTextBackedString:[YYTextBackedString stringWithString:subStr] range:NSMakeRange(0, atr.length)];
        [text replaceCharactersInRange:oneRange withString:atr.string];
        [text removeDiscontinuousAttributesInRange:NSMakeRange(oneRange.location, atr.length)];
        [text addAttributes:atr.attributes range:NSMakeRange(oneRange.location, atr.length)];
        selectedRange = [self _replaceTextInRange:oneRange withLength:atr.length selectedRange:selectedRange];
        cutLength += oneRange.length - 1;
    }
    if (range) *range = selectedRange;
    
    return YES;
}

@end
