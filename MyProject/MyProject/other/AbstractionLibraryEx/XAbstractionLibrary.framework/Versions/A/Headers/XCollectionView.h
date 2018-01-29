//
//  XCollectionView.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/27.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XListView.h"
#import "XListHeadView.h"
#import "XListLoadMoreView.h"

/**
 *  全面扩展UICollectionView类
 */
@interface XCollectionView : UICollectionView

/**
 *  样式
 */
@property (nonatomic,assign) XListViewStyle  listStyle;

/**
 *  上下拉回调代理
 */
@property (nonatomic,weak) id<XListCallBackDelegate> listDelegate;


/**
 *  是否开启预加载
 */
@property (nonatomic,assign) BOOL bPerLoad;

/**
 *  预加载率,默认为2，表明当滚动到距离下边缘小于2倍的时候开始预加载
 */
@property (nonatomic,assign) CGFloat perLoadRate;

/**
 *  不建议使用
 */
- (id) init __attribute__((unavailable("init not available")));

/**
 *  不建议使用
 */
- (id) initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder not available")));

/**
 *  刷新或加载更多结束
 */
- (void) finishLoad;

/**
 *  刷新列表
 */
- (void) reloadData;

/**
 *  构造新的页眉
 */
- (XListHeadView *) loadListHeadView;

/**
 *  构造新的页脚
 */
- (XListLoadMoreView *) loadListMoreView;

@end
