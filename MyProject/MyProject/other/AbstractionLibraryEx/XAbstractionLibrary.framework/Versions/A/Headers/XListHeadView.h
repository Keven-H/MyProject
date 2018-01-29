//
//  XListHeadView.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/3/1.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import "XView.h"

/**
 *  当前下拉控件所出的状态
 */
typedef NS_ENUM(NSInteger, XListHeadViewState){
    /**
     *  默认
     */
    XListHeadViewStateNormal,
    /**
     *  拉动
     */
    XListHeadViewStatePulling,
    /**
     *  正在加载
     */
    XListHeadViewStateLoading
};


@class XListHeadView;
@protocol XListHeadViewDelegate <NSObject>
@optional
- (void)didTriggerRefresh:(XListHeadView *) refreshView;
@end


/**
 *  下拉控件
 */
@interface XListHeadView : XView

/**
 *  构建自己的页眉
 */
+ (XListHeadView *) createListHeadView;

/**
 *  是否正在加载过程中
 */
@property (nonatomic,assign) BOOL bLoading;

/**
 *  下拉控件状态
 */
@property (nonatomic,assign) XListHeadViewState state;

/**
 *  回调代理
 */
@property (nonatomic,weak) id<XListHeadViewDelegate> delegate;

/**
 *  与系统方法意思相同
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  与系统方法意思相同
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;

/**
 *  与系统方法意思相同
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

/**
 *  有些场景会使用该方法，比如刚进入页面时立刻进行刷新操作，此时需要顶部的下拉效果
 */
- (void)scrollViewDataSourceDidStartRefreshing:(UIScrollView *)scrollView;

/**
 *  下拉控件加载完成时，需要调用该方法
 */
- (void)scrollViewDataSourceDidFinishRefreshing:(UIScrollView *)scrollView;

@end
