//
//  UIView+xframe.h
//  myFrameworkDemo
//
//  Created by liyunqi on 28/03/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (xframe)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGSize size;

@property CGPoint origin;//获得视图的起点坐标

@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat bottom;//获得视图的底部y
@property CGFloat right;//获得视图的右部x


///
-(void)addSuViewWithDescendant:(UIView *)view;
@end
