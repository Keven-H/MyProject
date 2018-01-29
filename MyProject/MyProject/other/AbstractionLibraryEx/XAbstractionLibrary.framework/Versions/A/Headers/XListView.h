//
//  XListView.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/23.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XScrollList_h
#define XAbstractionLibrary_XScrollList_h

/**
 *  控件样式
 */
typedef NS_ENUM(NSInteger, XListViewStyle){
    /**
     *  默认，没有页眉页脚
     */
    XListViewStyleNone,
    /**
     *  标准 有页眉也有页脚
     */
    XListViewStyleStandard,
    /**
     *  只有页眉
     */
    XListViewStyleHeader,
    /**
     *  只有页脚
     */
    XListViewStyleFooter
};

/**
 *  传递滚动消息
 */
@protocol XScrollViewDelegate <NSObject>
@optional
- (void)willScrollBeginDragging:(UIScrollView *)scrollView;
- (void)scrollDidScroll:(UIScrollView *)scrollView;
- (void)scrollDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

/**
 *  上下啦刷新回调
 */
@protocol XListCallBackDelegate <NSObject>
@optional
- (void) listViewDidTriggerRefresh:(id) listView;
- (void) listViewDidTriggerLoadMore:(id) listView;
@end

#endif
