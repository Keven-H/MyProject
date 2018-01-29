//
//  SYPageFlowView.h
//  Foodie
//
//  Created by liyunqi on 9/1/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    FlowViewOrientationHorizontal = 0,
    FlowViewOrientationVertical
}FlowViewOrientation;

typedef enum {
    PageDirectionPrevious = 0,
    PageDirectionDown
} PageDirectionE;
@protocol SYPageFlowViewDelegate;
@protocol  SYPageFlowViewDataSource;
/**
 *  无限循环view
 */
@interface SYPageFlowView : UIView
{
    
}
PROPERTY_WEAK id<SYPageFlowViewDataSource> dataSource;
PROPERTY_WEAK id <SYPageFlowViewDelegate>   delegate;
PROPERTY_STRONG UIImageView         *defaultImageView;
PROPERTY_ASSIGN FlowViewOrientation orientation;
PROPERTY_ASSIGN_READONLY NSInteger currentPageIndex;
PROPERTY_ASSIGN CGFloat minimumPageAlpha;
PROPERTY_ASSIGN CGFloat minimumPageScale;

PROPERTY_ASSIGN CFTimeInterval animationDuration;
@property (nonatomic, getter = isAutoAnimation) BOOL autoAnimation;

- (void)reloadData;
- (UIView *)dequeueReusableCell;
- (UIView *)cellForItemAtCurrentIndex:(NSInteger)currentIndex;

- (void)scrollToNextPage;

@end




@protocol  SYPageFlowViewDelegate<NSObject>
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index;

@optional
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(SYPageFlowView *)flowView;
- (void)didAutoScrollToPage:(NSInteger)pageNumber inFlowView:(SYPageFlowView *)flowView;
- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(SYPageFlowView *)flowView;

@end

@protocol SYPageFlowViewDataSource <NSObject>

- (NSInteger)numberOfPagesInFlowView:(SYPageFlowView *)flowView;
- (CGSize)sizeForPageInFlowView:(SYPageFlowView *)flowView;

- (UIView *)flowView:(SYPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index;
@end
