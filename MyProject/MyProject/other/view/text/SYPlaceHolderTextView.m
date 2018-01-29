//
//  SYPlaceHolderTextView.m
//  Foodie
//
//  Created by liyunqi on 10/12/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYPlaceHolderTextView.h"
@interface SYPlaceHolderTextView()
PROPERTY_STRONG UILabel *placeHolderLabel;
@end
@implementation SYPlaceHolderTextView
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
-(void)setPlaceHolderStr:(NSString *)placeHolderStr
{
    _placeHolderStr=placeHolderStr;
    self.placeHolderLabel.text=placeHolderStr;
    [self updatePlaceholderLabel];
}
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor=placeHolderColor;
    self.placeHolderLabel.textColor=placeHolderColor;
    [self updatePlaceholderLabel];
}
-(void)initDefault
{

    if (self.placeHolderLabel) {
        return;
    }
    self.placeHolderLabel=[[UILabel alloc]init];
    self.placeHolderLabel.backgroundColor=[UIColor clearColor];
    self.placeHolderLabel.textColor=XColor(153, 153, 153);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePlaceholderLabel)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];

}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self updatePlaceholderLabel];
}
-(void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    [super setTextContainerInset:textContainerInset];
    [self updatePlaceholderLabel];
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updatePlaceholderLabel];
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self updatePlaceholderLabel];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self updatePlaceholderLabel];
}
- (void)updatePlaceholderLabel {
    if (self.text.length) {
        [self.placeHolderLabel removeFromSuperview];
        return;
    }
    [self insertSubview:self.placeHolderLabel atIndex:0];
    self.placeHolderLabel.font = self.font;
    self.placeHolderLabel.textAlignment = self.textAlignment;
    CGFloat lineFragmentPadding;
    UIEdgeInsets textContainerInset;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        lineFragmentPadding = self.textContainer.lineFragmentPadding;
        textContainerInset = self.textContainerInset;
    }
    else {
        lineFragmentPadding = 5;
        textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    }
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat y = textContainerInset.top;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
    self.placeHolderLabel.frame = CGRectMake(x, y, width, height);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updatePlaceholderLabel];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
