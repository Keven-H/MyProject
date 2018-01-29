//
//  UIView+SYFaceAttributedString.h
//  Foodie
//
//  Created by liyunqi on 13/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SYFaceAttributedString)

//set attributed

/**
 返回带有表情的string
 */
- (NSMutableAttributedString *)faceAttributedStringFromStingWithFont:(UIFont *)font
                                                                                        lineSpacing:(CGFloat)lineSpacing
                                                                                          alignment:(NSTextAlignment)alignment;

/**
 返回带有表情的string
 */
-(NSMutableAttributedString *)faceAttributedWith:(UIFont *)font;


/**
 计算高度

 */
-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing size:(CGSize)size;

/**
 计算高度

 */
-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxWidth:(float)maxWidth;



/**
 计算高度
 */
-(CGSize)faceAttributedStringSize:(UIFont *)font lineSpacing:(CGFloat)lineSpacing size:(CGSize)size maxNumber:(NSInteger)maxNumberline;
@end

@interface NSMutableAttributedString (SYFaceAttributed)


/**
 计算高度
 */
-(CGSize)faceSizeString:(CGSize)size;

-(CGSize)faceSizeStringVerticalForm:(CGSize)size;

/**
 计算高度--设置行数
 */
-(CGSize)faceSizeString:(CGSize)size maxNumberLines:(NSInteger)maxNumberlines isVerticalForm:(BOOL)verticalForm;


/**
 计算高度

 */
-(CGSize)faceSizeStringWithAutoEmoji:(CGSize)size;


/**
  竖型文字计算高度
 */
-(CGSize)faceSizeStringWithAutoEmojiVerticalForm:(CGSize)size;

/**
 用textParse 去筛选 此方法为推荐方法  调用此方法后自身的string可能会发生改变(已去除表情文字)
 */
-(void)faceAttringResetEmoji;

-(NSMutableAttributedString *)faceAttringResetEmojiValue;



+ (CGSize)adjustSizeWithAttributedString:(NSAttributedString *)attributedString size:(CGSize)size numberLine:(NSInteger)numberLine;
@end
