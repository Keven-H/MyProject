//
//  SYEditTextView.h
//  Foodie
//
//  Created by liyunqi on 10/12/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPlaceHolderTextView.h"
typedef enum
{
    SYEditTextViewDoneStyle_number,
    SYEditTextViewDoneStyle_done,
    SYEditTextViewDoneStyle_all,
}SYEditTextViewDoneStyle;


@class SYEditTextView;
@protocol SYEditTextViewDelegate<NSObject>
@optional
-(void)textViewDidEndEditing:(SYEditTextView *)textView;
-(void)textViewDidBeginEditing:(SYEditTextView *)textView;
-(void)textViewDidChange:(SYEditTextView *)textView;
-(BOOL)textViewShouldEndEditing:(SYEditTextView *)textView;
-(BOOL)textViewShouldBeginEditing:(SYEditTextView *)textView;
- (BOOL)textView:(SYEditTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
@end
@interface SYEditTextView : UIView

PROPERTY_WEAK id<SYEditTextViewDelegate,UITextViewDelegate> editViewDelegate;
PROPERTY_ASSIGN float margin;//default is 0
PROPERTY_ASSIGN NSInteger maxNum;//default 0
PROPERTY_STRONG SYPlaceHolderTextView *mtextView;
PROPERTY_ASSIGN BOOL usedChineseChar;//是否使用中文字符限制 //yes
PROPERTY_STRONG NSString *text;
PROPERTY_ASSIGN UITextFieldViewMode numChangeModel;//数字变化显示模式
PROPERTY_ASSIGN SYEditTextViewDoneStyle doneStyle;

PROPERTY_STRONG UIButton *finishButton;

PROPERTY_ASSIGN UIEdgeInsets doneInsets;

PROPERTY_ASSIGN BOOL delegateUseSelf;//NO
@end
