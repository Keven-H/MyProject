//
//  UIView+SYClickMargin.m
//  Foodie
//
//  Created by liyunqi on 16/3/14.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "UIButton+SYClickMargin.h"
#import <objc/runtime.h>
#define sy_btn_margin 5
static  char key_sy_enlarged;
@implementation UIButton (SYClickMargin)
@dynamic enlargeEdge;
@dynamic enlargedMargin;
-(void)setEnlargedMargin:(CGFloat)enlargedMargin
{
    [self setEnlargeEdge:UIEdgeInsetsMake(enlargedMargin, enlargedMargin, enlargedMargin, enlargedMargin)];
}
-(void)setEnlargeEdge:(UIEdgeInsets)enlargeEdge
{
    objc_setAssociatedObject(self, &key_sy_enlarged, NSStringFromUIEdgeInsets(enlargeEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGRect)enlargedRect
{
    NSString *edgeStr=objc_getAssociatedObject(self, &key_sy_enlarged);
    if (edgeStr) {
        UIEdgeInsets edgeInsets=UIEdgeInsetsFromString(edgeStr);
        CGRect enlargedrect=CGRectMake(self.bounds.origin.x-edgeInsets.left, self.bounds.origin.y-edgeInsets.top, self.frame.size.width+edgeInsets.left+edgeInsets.right, self.frame.size.height+edgeInsets.top+edgeInsets.bottom);
        return enlargedrect;
    }
    return self.bounds;
}
-(BOOL)haveEnlarged
{
    NSString *edgeStr=objc_getAssociatedObject(self, &key_sy_enlarged);
    if (edgeStr) {
        return YES;
    }else
    {
//        self.enlargedMargin=sy_btn_margin;
    }
    return NO;
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.alpha<=0.01||!self.userInteractionEnabled||self.hidden) {
        return nil;
    }
    if (![self haveEnlarged]) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint([self enlargedRect], point)?self :nil;
}

@end
