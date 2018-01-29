//
//  MSFlowScrollView.h
//  meishi
//
//  Created by yunqi on 15/9/14.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MSFlowScrollViewDataSource;
@protocol MSFlowScrollViewDelegate;
@interface MSFlowScrollView : UIView
@property(assign,nonatomic)CGSize contentSize;;
@property (assign,nonatomic) NSInteger currentPage;
@property (assign,nonatomic) BOOL scrollEnabled;//default is YES
@property (assign,nonatomic) BOOL cycleEnabled;//是否可循环滚动，default is YES
@property (weak,nonatomic) id<MSFlowScrollViewDataSource> dataSource;
@property (weak,nonatomic) id<MSFlowScrollViewDelegate> delegate;


PROPERTY_ASSIGN CFTimeInterval animationDuration;
@property (nonatomic, getter = isAutoAnimation) BOOL autoAnimation;

-(id)dequeueReusableView;
-(void)reloadData;
-(void)scrollToIndex:(NSInteger)index;
//-(void)reloadCurrentIndex;
@end

@protocol MSFlowScrollViewDataSource<NSObject>
-(UIView*)viewForYRADScrollView:(MSFlowScrollView*)adScrollView atPage:(NSInteger)pageIndex;
//-(void)reloadCurrentView:(MSFlowScrollView *)adScrollView view:(UIView *)view atPage:(NSInteger)pageIndex;//此方法不必实现 特殊使用
-(NSUInteger)numberOfViewsForYRADScrollView:(MSFlowScrollView*)adScrollView;
@optional
- (CGSize)sizeForPageInFlowView:(MSFlowScrollView *)flowView atPage:(NSInteger)index;//此方法是为了实现动态改变高度--不需要此功能的直接设置contentSize就行了
@end

@protocol MSFlowScrollViewDelegate<NSObject>
-(void)adScrollView:(MSFlowScrollView*)adScrollView didClickedAtPage:(NSInteger)pageIndex;
-(void)adScrollView:(MSFlowScrollView*)adScrollView didScrollToPage:(NSInteger)pageIndex;

-(void)adScrollView:(MSFlowScrollView*)adScrollView autoSize:(CGSize)size;
@end
