//
//  NSMutableAttributedString+SYFaceAtt.m
//  Foodie
//
//  Created by liyunqi on 19/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "NSMutableAttributedString+SYFaceAtt.h"
#import <YYKit/YYTextUtilities.h>
#import <YYKit/YYTextRunDelegate.h>
#import <YYKit/NSAttributedString+YYText.h>
@implementation NSMutableAttributedString (SYFaceAtt)
+(CGFloat)getascentWithFontsize:(CGFloat)fontsize
{
    if (fontsize < 16) {
        return 1.25 * fontsize;
    } else if (16 <= fontsize && fontsize <= 24) {
        return 0.5 * fontsize + 12;
    } else {
        return fontsize;
    }
}
+(CGFloat)getdescentWithFontsize:(CGFloat)fontsize
{
    if (fontsize < 16) {
        return 0.390625 * fontsize;
    } else if (16 <= fontsize && fontsize <= 24) {
        return 0.15625 * fontsize + 3.75;
    } else {
        return 0.3125 * fontsize;
    }
    return 0;
}
+ (NSMutableAttributedString *)sy_attachmentStringWithEmojiImage:(UIImage *)image
                                                        fontSize:(CGFloat)fontSize {
    if (!image || fontSize <= 0) return nil;
    
    BOOL hasAnim = NO;
    if (image.images.count > 1) {
        hasAnim = YES;
    } else if (NSProtocolFromString(@"YYAnimatedImage") &&
               [image conformsToProtocol:NSProtocolFromString(@"YYAnimatedImage")]) {
        NSNumber *frameCount = [image valueForKey:@"animatedImageFrameCount"];
        if (frameCount.intValue > 1) hasAnim = YES;
    }
    
    CGFloat ascent = [self getascentWithFontsize:fontSize];
    CGFloat descent = [self getdescentWithFontsize:fontSize];
    CGRect bounding = CGRectMake(0.75, 0, ascent, ascent);
    if (bounding.size.width && (image.size.width >= bounding.size.width)&&image.size.width/image.size.height!=1)
    {
        bounding=CGRectMake(bounding.origin.x, bounding.origin.y, bounding.size.height/image.size.height*image.size.width, bounding.size.height);
    }

    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width + 2 * bounding.origin.x;
    
    YYTextAttachment  *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = UIEdgeInsetsMake(0, bounding.origin.x, 0, bounding.origin.x);
    if (hasAnim) {
        Class imageClass = NSClassFromString(@"YYAnimatedImageView");
        if (!imageClass) imageClass = [UIImageView class];
        UIImageView *view = (id)[imageClass new];
        view.frame = bounding;
        view.image = image;
        view.contentMode = UIViewContentModeScaleAspectFit;
        attachment.content = view;
    } else {
        attachment.content = image;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
//    [atr yy_setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
//    [atr yy_setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

@end
