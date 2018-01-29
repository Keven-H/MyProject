//
//  MSNavigationButton.h
//  meishi
//
//  Created by Mac on 7/30/15.
//  Copyright (c) 2015 Kangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _MSNavigationButtonState{
    MSNavigationButtonState_pre = 0,
    MSNavigationButtonState_back,
}MSNavigationButtonState;

@interface MSNavigationButton : UIButton

PROPERTY_ASSIGN MSNavigationButtonState buttonState;
- (void)setButtonImageWithPreNImage:(UIImage *)preNImage
                          preHImage:(UIImage *)preHImage
                          preSImage:(UIImage *)preSImage
                         backNImage:(UIImage *)backNImage
                         backHImage:(UIImage *)backHImage
                         backSImage:(UIImage *)backSImage;

- (void)setButtonSelected;


+(MSNavigationButton *)buttonWithSize:(CGSize)size preImage:(UIImage *)imagePre backImage:(UIImage *)imageBack target:(id)target sel:(SEL)sel;
@end
