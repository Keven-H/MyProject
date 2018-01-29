//
//  UIView+SYKeyboard.m
//  Foodie
//
//  Created by liyunqi on 02/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "UIView+SYKeyboard.h"
#import <objc/runtime.h>

static void *keyboardRectAssociationKey = &keyboardRectAssociationKey;
static void *keyboardShowAssociationKey = &keyboardShowAssociationKey;
@implementation UIView (SYKeyboard)
- (void)showKeyboard:(keyboardRectBlock)complete
{
    objc_setAssociatedObject(self, keyboardRectAssociationKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //    objc_setAssociatedObject(self, keyboardShowAssociationKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)hideKeyboard
{
    objc_setAssociatedObject(self, keyboardRectAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, keyboardShowAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleWillShowKeyboardNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isshowing:YES];
}

- (void)handleWillHideKeyboardNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isshowing:NO];
}

- (void)keyboardWillShowHide:(NSNotification *)notification isshowing:(BOOL)isshow
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyboardRectBlock rectBlock = objc_getAssociatedObject(self, keyboardRectAssociationKey);
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (rectBlock) rectBlock(keyboardRect,isshow);
    } completion:^(BOOL finished) {
        
    }];
}

@end
