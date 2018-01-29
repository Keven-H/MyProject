//
//  UIViewController+PushTransition.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 15/7/17.
//  Copyright © 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PushTransitionGestureRecognizerTypePan, //拖动模式
    PushTransitionGestureRecognizerTypeScreenEdgePan, //边界拖动模式
} PushTransitionGestureRecognizerType;


@interface UIViewController (PushTransition)<UINavigationControllerDelegate>

/**
 *  关联手势推入推出，并且指定模式
 *
 *  @param type 边缘或全域
 */
+ (void)validatePanPackWithPushTransitionGestureRecognizerType:(PushTransitionGestureRecognizerType)type;

@end
