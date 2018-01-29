//
//  UIView+SYKeyboard.h
//  Foodie
//
//  Created by liyunqi on 02/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^keyboardRectBlock)(CGRect keyboardRect, BOOL isShowing);


@interface UIView (SYKeyboard)
- (void)showKeyboard:(keyboardRectBlock)complete;
- (void)hideKeyboard;

@end
