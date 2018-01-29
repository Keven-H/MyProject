//
//  MSNavigationButton.m
//  meishi
//
//  Created by Mac on 7/30/15.
//  Copyright (c) 2015 Kangbo. All rights reserved.
//

#import "MSNavigationButton.h"

@interface MSNavigationButton ()

PROPERTY_STRONG UIImage *preNimage;
PROPERTY_STRONG UIImage *preHimage;
PROPERTY_STRONG UIImage *preSimage;

PROPERTY_STRONG UIImage *backNimage;
PROPERTY_STRONG UIImage *backHimage;
PROPERTY_STRONG UIImage *backSimage;

@end

@implementation MSNavigationButton

//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    
//    UIImage *selectImage = [self backgroundImageForState:UIControlStateSelected];
//    UIImage *normalImage = [self backgroundImageForState:UIControlStateNormal];
//    
//    if (selected) {
//        [self setBackgroundImage:selectImage forState:UIControlStateHighlighted];
//    }else{
//        [self setBackgroundImage:normalImage forState:UIControlStateHighlighted];
//    }
//}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)setButtonSelected
{
    [self setSelected:YES];
    switch (self.buttonState) {
        case MSNavigationButtonState_pre:
        {
            [self setImage:self.preSimage forState:UIControlStateSelected];
        }
            break;
            
        case MSNavigationButtonState_back:
        {
            [self setImage:self.backSimage forState:UIControlStateSelected];
        }
            break;
            
        default:
            break;
    }
}

- (void)setButtonImageWithPreNImage:(UIImage *)preNImage
                          preHImage:(UIImage *)preHImage
                          preSImage:(UIImage *)preSImage
                         backNImage:(UIImage *)backNImage
                         backHImage:(UIImage *)backHImage
                         backSImage:(UIImage *)backSImage
{
    self.preNimage = preNImage;
    self.preHimage = preHImage;
    self.preSimage = preSImage;
    
    self.backNimage = backNImage;
    self.backHimage = backHImage;
    self.backSimage = backSImage;
    [self setButtonState:MSNavigationButtonState_pre];
}

- (void)setButtonState:(MSNavigationButtonState)buttonState
{
    _buttonState = buttonState;
    
    switch (buttonState) {
        case MSNavigationButtonState_pre:
        {
            [self setImage:self.preNimage forState:UIControlStateNormal];
            [self setImage:self.preHimage forState:UIControlStateHighlighted];
            [self setImage:self.preSimage forState:UIControlStateSelected];
        }
            break;
            
        case MSNavigationButtonState_back:
        {
            [self setImage:self.backNimage forState:UIControlStateNormal];
            [self setImage:self.backHimage forState:UIControlStateHighlighted];
            [self setImage:self.backSimage forState:UIControlStateSelected];
        }
            break;
            
        default:
            break;
    }
}
+(MSNavigationButton *)buttonWithSize:(CGSize)size preImage:(UIImage *)imagePre backImage:(UIImage *)imageBack target:(id)target sel:(SEL)sel
{
    MSNavigationButton *btn = [MSNavigationButton buttonWithType:UIButtonTypeCustom];
    btn.size=size;
    [btn setButtonImageWithPreNImage:imagePre
                           preHImage:imagePre
                           preSImage:imagePre
                          backNImage:imageBack
                          backHImage:imageBack
                          backSImage:imageBack];
    if (target&&sel) {
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
@end
