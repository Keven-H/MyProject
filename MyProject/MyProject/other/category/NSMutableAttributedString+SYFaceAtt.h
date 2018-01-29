//
//  NSMutableAttributedString+SYFaceAtt.h
//  Foodie
//
//  Created by liyunqi on 19/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableAttributedString (SYFaceAtt)
/**
 内部使用
 
 */
+ (NSMutableAttributedString *)sy_attachmentStringWithEmojiImage:(UIImage *)image
                                                        fontSize:(CGFloat)fontSize;
@end
