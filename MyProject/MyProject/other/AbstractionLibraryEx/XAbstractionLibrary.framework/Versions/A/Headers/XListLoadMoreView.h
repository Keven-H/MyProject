//
//  XListLoadMoreView.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/23.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  当前更多控件所出的状态
 */
typedef NS_ENUM(NSInteger, XListFooterViewState){
    /**
     *  默认
     */
    XListFooterViewStateNormal,
    /**
     *  拉动
     */
    XListFooterViewStatePulling,
    /**
     *  正在加载
     */
    XListFooterViewStateLoadingMore
};

@protocol XListLoadViewBackCallDelegate;

@interface XListLoadMoreView : UIView

/**
 *  当前更多控件状态
 */
@property (nonatomic,assign) XListFooterViewState state;

/**
 *  YES 正处加载状态 NO非加载状态
 */
@property (nonatomic,assign) BOOL bLoading;

/**
 *  加载更多代理
 */
@property (nonatomic,weak) id<XListLoadViewBackCallDelegate> delegate;

/**
 *  构建滚动控件的上拉更多控件，可以重写改方法.
 */
+ (XListLoadMoreView *) createListMoreView;

/**
 *  滑动消息传递，滚动消息
 *
 *  @param scrollView 滑动控件
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  滑动消息传递，手指离开消息
 *
 *  @param scrollView 滑动控件
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;

/**
 *  滑动消息传递，更多加载完成恢复消息
 *
 *  @param scrollView 滑动控件
 */
- (void)scrollViewDataSourceDidFinishLoadingMore:(UIScrollView *)scrollView;

@end

/**
 *  回调代理
 */
@protocol XListLoadViewBackCallDelegate <NSObject>
/**
 *  更多回调
 *
 *  @param loadMoreView 控件对象
 */
- (void)didTriggerLoadMore:(XListLoadMoreView *)loadMoreView;

/**
 *  判断是否可以加载更多
 *
 *  @param loadMoreView 控件对象
 *
 *  @return YES 可以 NO 不可以
 */
- (BOOL)didSupportLoadMore:(XListLoadMoreView *)loadMoreView;
@end
