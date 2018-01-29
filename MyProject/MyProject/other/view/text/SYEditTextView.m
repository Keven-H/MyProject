//
//  SYEditTextView.m
//  Foodie
//
//  Created by liyunqi on 10/12/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYEditTextView.h"

@interface SYEditTextView()<UITextViewDelegate>
{
    
}

@end
@implementation SYEditTextView
@synthesize text=_text;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefault];
    }
    return self;
}
-(void)initDefault
{
    if (self.mtextView) {
        return;
    }

    _usedChineseChar=YES;
    _delegateUseSelf=NO;
    _maxNum=1000;
    
    _margin=0;
    //输入文字框
    self.mtextView = [[SYPlaceHolderTextView alloc]init];
    self.mtextView.delegate = self;
    self.mtextView.backgroundColor=[UIColor clearColor];
    self.mtextView.font = UIFontWithSize(16);
    self.mtextView.textColor = XColorAlpa(51, 51, 51, 1);
    self.mtextView.text = @"";
//    self.mtextView.textContainerInset = UIEdgeInsetsMake(0, -6, 0, 16);
    [self addSubview:self.mtextView];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.finishButton.enlargeEdge=UIEdgeInsetsMake(10, 20, 10, 20);
    self.finishButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self addSubview:self.finishButton];
    [self.finishButton setTitleColor:XColor(102, 102, 120) forState:UIControlStateNormal];
    self.finishButton.titleLabel.font=UIFontWithSize(10);


    self.mtextView.placeHolderStr=@"请输入文字";
    [self resetSub];
    
}
-(void)resetSub
{
    self.finishButton.hidden=NO;
    if (self.doneStyle==SYEditTextViewDoneStyle_all||self.doneStyle==SYEditTextViewDoneStyle_done) {
        [self.finishButton setImage:[UIImage imageNamed:@"shuruOk"] forState:UIControlStateNormal];
    }else
    {
        [self.finishButton setImage:nil forState:UIControlStateNormal];
    }
    if (self.maxNum<=0||self.numChangeModel==UITextFieldViewModeNever) {
        self.finishButton.hidden=YES;
        [self setNeedsLayout];
        return;
    }
    if (self.numChangeModel==UITextFieldViewModeWhileEditing&&[self.mtextView isFirstResponder]) {
        self.finishButton.hidden=YES;
        [self setNeedsLayout];
        return;
    }
}
-(void)setMargin:(float)margin
{
    _margin=margin;
    [self resetSub];
}
-(void)setMaxNum:(NSInteger)maxNum
{
    if (maxNum<=0) {
        maxNum=0;
    }
    _maxNum=maxNum;
}
-(NSString *)text
{
    return self.mtextView.text;
}

-(void)setText:(NSString *)text
{
    _text =text;
    self.mtextView.text=text;
    [self resetText];
}
-(void)setNumChangeModel:(UITextFieldViewMode)numChangeModel
{
    _numChangeModel=numChangeModel;
    [self resetSub];
}
-(void)setDoneStyle:(SYEditTextViewDoneStyle)doneStyle
{
    _doneStyle=doneStyle;
    [self resetSub];
}
-(void)setDoneInsets:(UIEdgeInsets)doneInsets
{
    _doneInsets=doneInsets;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.finishButton.hidden) {
        self.mtextView.frame=CGRectMake(self.margin, 0, self.width-self.margin*2,self.height );
    }else
    {
        float height=MAX([self.finishButton imageForState:UIControlStateNormal].size.height, 12);
        self.finishButton.frame=CGRectMake(self.width-self.margin-120-self.doneInsets.right, self.height-height-self.doneInsets.bottom, 120, height);
        self.mtextView.frame=CGRectMake(self.margin, 0, self.width-self.margin*2, MIN(self.height, self.finishButton.y+self.mtextView.textContainerInset.bottom+self.mtextView.contentInset.bottom));
    }
}
-(void)finishButtonClick
{
    if ([self.finishButton imageForState:UIControlStateNormal]) {
        [UIView registKeyBoard];
    }
}

#pragma delegate
-(void)resetText
{
    if (self.maxNum<=0) {
        return;
    }
    if (self.usedChineseChar) {
        NSInteger textLength = [NSString convertStringLengthToInt:self.mtextView.text];
        NSString* lang = self.mtextView.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 中文
            UITextRange* selectedRange = [self.mtextView markedTextRange];
            UITextPosition* position =
            [self.mtextView positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (textLength > self.maxNum*2) {
                    self.mtextView.text = [NSString subStringWithString:self.mtextView.text maxLength:self.maxNum];
                }
            }
        }
        else {
            if (textLength > self.maxNum*2) {
                self.mtextView.text = [NSString subStringWithString:self.mtextView.text maxLength:self.maxNum];
            }
        }
        textLength = [NSString convertStringLengthToInt:self.mtextView.text];
        [self.finishButton setTitle:[NSString stringWithFormat:@"%@/%@",NSStringFromInt((textLength + 1)/2),NSStringFromInt(self.maxNum)] forState:UIControlStateNormal];
    }else
    {
        UITextRange *markRange = self.mtextView.markedTextRange;

        NSInteger pos = [self.mtextView offsetFromPosition:markRange.start
                                      toPosition:markRange.end];
        NSInteger nLength = self.mtextView.text.length - pos;
        if (nLength>self.maxNum) {
            self.text = [self.mtextView.text substringToIndex:self.maxNum ];
        }
         [self.finishButton setTitle:[NSString stringWithFormat:@"%@/%@",NSStringFromInt(self.mtextView.text.length),NSStringFromInt(self.maxNum)] forState:UIControlStateNormal];
    }

    if ([self.finishButton imageForState:UIControlStateNormal]) {
        [self.finishButton setImagePosition:SYImagePositionRight spacing:10];
    }
}
-(id)delegetaValue
{
    if (self.delegateUseSelf) {
        return self;
    }
    return self.mtextView;
}
-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self resetSub];
    [self resetText];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self resetSub];
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.editViewDelegate textViewDidEndEditing:[self delegetaValue]];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self resetSub];
    [self resetText];
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.editViewDelegate textViewDidBeginEditing:[self delegetaValue]];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self resetText];
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.editViewDelegate textViewDidChange:[self delegetaValue]];
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return  [self.editViewDelegate textViewShouldEndEditing:[self delegetaValue]];
    }
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return  [self.editViewDelegate textViewShouldBeginEditing:[self delegetaValue]];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.editViewDelegate&&[self.editViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
      return  [self.editViewDelegate textView:[self delegetaValue] shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

@end
