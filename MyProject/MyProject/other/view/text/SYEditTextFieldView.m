//
//  SYEditTextFieldView.m
//  Foodie
//
//  Created by liyunqi on 01/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYEditTextFieldView.h"
@interface SYEditTextFieldView()
{
     SYEditFieldChange block;
}
@end
@implementation SYEditTextFieldView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefautl];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initDefautl];
    }
    return self;
}
-(void)setClearImage:(UIImage *)clearImage
{
    if (!clearImage) {
        return;
    }
    UIButton *button = [self valueForKey:@"_clearButton"];
    [button setImage:clearImage forState:UIControlStateNormal];
}
-(void)setMaxNum:(NSInteger)maxNum
{
    if (maxNum<=0) {
        maxNum=0;
    }
    _maxNum=maxNum;
}
-(void)setChangeBlock:(SYEditFieldChange)changeBlock
{
    block=changeBlock;
}
-(void)setPlaceColor:(UIColor *)placeColor
{
    _placeColor=placeColor;
    [self setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)initDefautl
{
    self.usedChineseChar=NO;
    self.maxNum=0;
     [self addTarget:self action:@selector(textFieldEditChanged) forControlEvents:UIControlEventEditingChanged];
}


-(void)textFieldEditChanged
{
    if (self.maxNum<=0) {
        return;
    }
    if (self.usedChineseChar) {
        NSInteger textLength = [NSString convertStringLengthToInt:self.text];
        NSString* lang = self.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 中文
            UITextRange* selectedRange = [self markedTextRange];
            UITextPosition* position =
            [self positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (textLength > self.maxNum*2) {
                    self.text = [NSString subStringWithString:self.text maxLength:self.maxNum];
                }
            }
        }
        else {
            if (textLength > self.maxNum*2) {
                self.text = [NSString subStringWithString:self.text maxLength:self.maxNum];
            }
        }
    }else
    {
        UITextRange *markRange = self.markedTextRange;
        
        NSInteger pos = [self offsetFromPosition:markRange.start
                                                 toPosition:markRange.end];
        NSInteger nLength = self.text.length - pos;
        if (nLength>self.maxNum) {
            self.text = [self.text substringToIndex:self.maxNum ];
        }

    }
    if (block) {
        block(self.text,0);
    }
}
@end
