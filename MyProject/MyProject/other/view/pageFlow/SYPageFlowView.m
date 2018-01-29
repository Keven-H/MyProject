//
//  SYPageFlowView.m
//  Foodie
//
//  Created by liyunqi on 9/1/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYPageFlowView.h"
#define kTagOffset   20
@interface SYPageFlowView()<UIScrollViewDelegate>
{
    BOOL     _needRefresh;
    UIScrollView        *_scrollView;
    BOOL                _needsReload;
    CGSize              _pageSize;
    NSInteger           _pageCount;
    NSRange              _visibleRange;
    NSMutableArray      *_reusableCells;
    NSMutableArray      *_inUseCells;
}
@end
@implementation SYPageFlowView
- (void)dealloc{
    _dataSource = nil;
    _delegate = nil;
    _defaultImageView=nil;
    _inUseCells=nil;
    _reusableCells = nil;
    [self stopAutoAnimating];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_needsReload) {
        //如果需要重新加载数据，则需要清空相关数据全部重新加载
        [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        //重置pageCount
        if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfPagesInFlowView:)]) {
            _pageCount = [_dataSource numberOfPagesInFlowView:self];
        }
        
        //重置pageWidth
        if (_dataSource && [_dataSource respondsToSelector:@selector(sizeForPageInFlowView:)]) {
            _pageSize = [_dataSource sizeForPageInFlowView:self];
        }
        
        _visibleRange = NSMakeRange(0, 0);
        
        [_reusableCells removeAllObjects];
        [_inUseCells removeAllObjects];
        
        if (_pageCount == 0 && _defaultImageView) {
            self.defaultImageView.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
            [_scrollView addSubview:self.defaultImageView];
        }
        
        if (!(_pageCount>_currentPageIndex)) {
            _currentPageIndex=0;
        }
        // 重置_scrollView的contentSize
        NSInteger  offset = 1;
        _scrollView.scrollEnabled = YES;
        if (_pageCount <= 1) {
            offset = 0;
            _scrollView.scrollEnabled = NO;
        }
        switch (_orientation) {
            case FlowViewOrientationHorizontal:
                _scrollView.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
                _scrollView.contentSize = CGSizeMake(_pageSize.width *3,_pageSize.height);
                CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                _scrollView.center = theCenter;
                _scrollView.contentOffset = CGPointMake(_pageSize.width*offset, 0);
                break;
            case FlowViewOrientationVertical:{
                _scrollView.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
                _scrollView.contentSize = CGSizeMake(_pageSize.width ,_pageSize.height * 3);
                CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                _scrollView.center = theCenter;
                _scrollView.contentOffset = CGPointMake(0, _pageSize.height*offset);
                break;
            }
            default:
                break;
        }
        
        [self loadRequiredItems];
        
        [self refreshVisibleCellAppearance];
        if ([_delegate respondsToSelector:@selector(didScrollToPage:inFlowView:)]) {
            [_delegate didScrollToPage:_currentPageIndex inFlowView:self];
        }
    }
    
}

- (void)loadRequiredItems
{
    if (_pageCount <= 0)
        return;
    
    if (_pageCount == 1) {
        UIView  *cell = [_dataSource flowView:self cellForPageAtIndex:0];
        cell.tag = 0 + kTagOffset;
        cell.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        if (cell){
            [_inUseCells addObject:cell];
            [_scrollView addSubview:cell];
        }
        return;
    }
    
    [self initVisibleCellAppearance];
    [self initReuseCell];
    
}

- (void)initVisibleCellAppearance
{
    _visibleRange = NSMakeRange(0, 3);
    
    NSInteger  index = 0;
    index = (_currentPageIndex == 0)?_pageCount-1:_currentPageIndex-1;
    UIView  *cell = [_dataSource flowView:self cellForPageAtIndex:index];
    cell.tag = index + kTagOffset;
    cell.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
    if (cell){
        [_inUseCells addObject:cell];
        [_scrollView addSubview:cell];
    }
    
    index = _currentPageIndex;
    UIView  *cell1 = [_dataSource flowView:self cellForPageAtIndex:index];
    cell1.tag = index + kTagOffset;
    cell1.frame = CGRectMake(_pageSize.width, 0, _pageSize.width, _pageSize.height);
    if (cell1){
        [_inUseCells addObject:cell1];
        [_scrollView addSubview:cell1];
    }
    
    index = (_currentPageIndex == _pageCount-1)?0:_currentPageIndex+1;
    UIView  *cell2 = [_dataSource flowView:self cellForPageAtIndex:index];
    cell2.tag = index + kTagOffset;
    cell2.frame = CGRectMake(_pageSize.width*2, 0, _pageSize.width, _pageSize.height);
    if (cell2){
        [_inUseCells addObject:cell2];
        [_scrollView addSubview:cell2];
    }
    
}

- (void)initReuseCell
{
    if (_pageCount == 2) {
        NSInteger  index = (_currentPageIndex==0)?0:1;
        UIView  *cell1 = [_dataSource flowView:self cellForPageAtIndex:index];
        cell1.tag = index + kTagOffset;
        cell1.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        if (cell1){
            [_reusableCells addObject:cell1];
        }
        
        index = (_currentPageIndex==0)?0:1;
        UIView  *cell2 =  [_dataSource flowView:self cellForPageAtIndex:index];
        cell2.tag = index + kTagOffset;
        cell2.frame = CGRectMake(_pageSize.width*2, 0, _pageSize.width, _pageSize.height);
        if (cell2){
            [_reusableCells addObject:cell2];
        }
    }else if (_pageCount >2){
        NSInteger  i = 0;
        if (_currentPageIndex == 0) {
            i  = _pageCount-2;
        }else if ((_currentPageIndex-1 == 0)) {
            i  = _pageCount-1;
        }else{
            i = _currentPageIndex-2;
        }
        
        UIView  *cell1 = [_dataSource flowView:self cellForPageAtIndex:i];
        cell1.tag = i + kTagOffset;
        cell1.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        if (cell1){
            [_reusableCells insertObject:cell1 atIndex:0];
        }
        
        NSInteger  index = 0;
        if (_currentPageIndex == _pageCount-1) {
            index = 1;
        }else if ((_currentPageIndex+1 == _pageCount-1)) {
            index = 0;
        }else{
            index = _currentPageIndex +2;
        }
        
        UIView  *cell2 = [_dataSource flowView:self cellForPageAtIndex:index];
        cell2.tag = index + kTagOffset;
        cell2.frame = CGRectMake(_pageSize.width*2, 0, _pageSize.width, _pageSize.height);
        if (cell2){
            [_reusableCells addObject:cell2];
        }
    }
    
    
}

- (void)queueReusableCell:(UIView *)cell
{
    if (cell)
    {
        [_reusableCells addObject:cell];
    }
}

#pragma mark - public Method
- (UIView *)dequeueReusableCell
{
    return nil;
    
    //    UIView *cell = [_reusableCells lastObject] ;
    //    if (cell)
    //    {
    //        [_reusableCells removeLastObject];
    //    }
    //
    //    return cell ;
}

- (void)reloadData
{
    _needsReload = YES;
    [self setNeedsLayout];
    [self stopAutoAnimating];
    [self startAutoAnimating];
}

#pragma mark - Private Methods
- (void)initialize{
    self.clipsToBounds = YES;
    
    _autoAnimation=NO;
    _animationDuration = 3.0;
    _needRefresh = YES;
    _pageSize = self.bounds.size;
    _pageCount = 0;
    _currentPageIndex = 0;
    
    _minimumPageAlpha = 1.0;
    _minimumPageScale = 1.0;
    
    _reusableCells = [[NSMutableArray alloc] initWithCapacity:1];
    _inUseCells = [[NSMutableArray alloc] initWithCapacity:1];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //    _scrollView.backgroundColor=[UIColor yellowColor];
    UIView *superViewOfScrollView = [[UIView alloc] initWithFrame:self.bounds];
    [superViewOfScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [superViewOfScrollView setBackgroundColor:[UIColor clearColor]];
    [superViewOfScrollView addSubview:_scrollView];
    [self addSubview:superViewOfScrollView];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_scrollView addGestureRecognizer:tap];
}

- (void)refreshVisibleCellAppearance
{
    if (_minimumPageAlpha == 1.0 && _minimumPageScale == 1.0) {
        return;//无需更新
    }
    switch (_orientation) {
        case FlowViewOrientationHorizontal:{
            CGFloat offset = _scrollView.contentOffset.x;
            
            for (int i = _visibleRange.location; i < _visibleRange.location + _visibleRange.length; i++) {
                UIView *cell = [_inUseCells objectAtIndex:i];
                CGFloat origin = cell.frame.origin.x;
                CGFloat delta = fabs(origin - offset);
                
                CGRect originCellFrame = CGRectMake(_pageSize.width * i, 0, _pageSize.width, _pageSize.height);//如果没有缩小效果的情况下的本该的Frame
                
                if (delta < _pageSize.width) {
                    cell.alpha = 1 - (delta / _pageSize.width) * (1 - _minimumPageAlpha);
                    
                    CGFloat inset = (_pageSize.width * (1 - _minimumPageScale)) * (delta / _pageSize.width)/2.0;
                     cell.layer.transform = CATransform3DMakeScale((_pageSize.width-inset*2)/_pageSize.width,(_pageSize.height-inset*2)/_pageSize.height, 1.0);
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));

                } else {
                    cell.alpha = _minimumPageAlpha;
                    CGFloat inset = _pageSize.width * (1 - _minimumPageScale) / 2.0 ;
                    cell.layer.transform = CATransform3DMakeScale((_pageSize.width-inset*2)/_pageSize.width,(_pageSize.height-inset*2)/_pageSize.height, 1.0);
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                }
            }
            break;
        }
        case FlowViewOrientationVertical:{
            CGFloat offset = _scrollView.contentOffset.y;
            
            for (int i = _visibleRange.location; i < _visibleRange.location + _visibleRange.length; i++) {
                UIView *cell = [_inUseCells objectAtIndex:i];
                CGFloat origin = cell.frame.origin.y;
                CGFloat delta = fabs(origin - offset);
                
                CGRect originCellFrame = CGRectMake(0, _pageSize.height * i, _pageSize.width, _pageSize.height);//如果没有缩小效果的情况下的本该的Frame
                
                if (delta < _pageSize.height) {
                    cell.alpha = 1 - (delta / _pageSize.height) * (1 - _minimumPageAlpha);
                    
                    CGFloat inset = (_pageSize.height * (1 - _minimumPageScale)) * (delta / _pageSize.height)/2.0;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                } else {
                    cell.alpha = _minimumPageAlpha;
                    CGFloat inset = _pageSize.height * (1 - _minimumPageScale) / 2.0 ;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                }
            }
        }
        default:
            break;
    }
    
}

- (UIView *)cellForItemAtCurrentIndex:(NSInteger)currentIndex
{
    UIView  *cell = nil;
    if ([_inUseCells count] == 1) {
        cell = [_inUseCells objectAtIndex:0];
    }else if ([_inUseCells count]>1){
        cell = [_inUseCells objectAtIndex:1];
    }
    return cell;
}

- (void)reloadDataForScrollView:(PageDirectionE)direction
{
    if (direction == PageDirectionPrevious) {
        
        UIView  *oldItem = [_inUseCells objectAtIndex:0] ;
        [_inUseCells removeObjectIdenticalTo:oldItem];
        
        for (NSInteger  i=0; i<[_inUseCells count]; i++) {
            UIView  *v = [_inUseCells objectAtIndex:i];
            v.frame = CGRectMake(_pageSize.width*i, 0, _pageSize.width, _pageSize.height);
        }
        
        UIView *newItem = [_reusableCells lastObject] ;
        [_reusableCells removeObjectIdenticalTo:newItem];
        [_scrollView addSubview:newItem];
        [_inUseCells addObject:newItem];
        //        [newItem release];
        
        oldItem.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        [_reusableCells insertObject:oldItem atIndex:0];
        [oldItem removeFromSuperview];
        //        [oldItem release];
        
        UIView  *reuseCell = [_reusableCells lastObject];
        
        NSInteger  index = 0;
        if (_currentPageIndex == _pageCount-1) {
            index = 1;
        }else if ((_currentPageIndex+1 == _pageCount-1)) {
            index = 0;
        }else{
            index = _currentPageIndex +2;
        }
        reuseCell.tag = index + kTagOffset;
        reuseCell.frame = CGRectMake(_pageSize.width*2, 0, _pageSize.width, _pageSize.height);
        [_delegate didReloadData:reuseCell cellForPageAtIndex:index];
        
    }else if(direction == PageDirectionDown){
        
        UIView  *oldItem = [_inUseCells lastObject] ;
        [_inUseCells removeObjectIdenticalTo:oldItem];
        
        for (NSInteger  i=0; i<[_inUseCells count]; i++) {
            UIView  *v = [_inUseCells objectAtIndex:i];
            v.frame = CGRectMake(_pageSize.width*(i+1), 0, _pageSize.width, _pageSize.height);
        }
        
        UIView *newItem = [_reusableCells objectAtIndex:0] ;
        [_reusableCells removeObjectIdenticalTo:newItem];
        [_scrollView addSubview:newItem];
        [_inUseCells insertObject:newItem atIndex:0];
        //        [newItem release];
        
        oldItem.frame = CGRectMake(_pageSize.width*2, 0, _pageSize.width, _pageSize.height);
        [_reusableCells addObject:oldItem];
        [oldItem removeFromSuperview];
        //        [oldItem release];
        
        UIView  *reuseCell = [_reusableCells objectAtIndex:0];
        NSInteger  i = 0;
        if (_currentPageIndex == 0) {
            i  = _pageCount-2;
        }else if ((_currentPageIndex-1 == 0)) {
            i  = _pageCount-1;
        }else{
            i = _currentPageIndex-2;
        }
        reuseCell.tag = i + kTagOffset;
        reuseCell.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        [_delegate didReloadData:reuseCell cellForPageAtIndex:i];
        
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_pageCount <= 1)
        return;
    //    [self scrollViewDidEndDecelerating:_scrollView];
    [self refreshVisibleCellAppearance];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value < 0) value = _pageCount-1;                   // value＝1为第一张，value = 0为前面一张
    if(value >= _pageCount) value = 0;
    
    return value;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    
    if(_orientation == FlowViewOrientationHorizontal) {
        // 往下翻一张
        if(x >= (2*_scrollView.bounds.size.width)) {
            _currentPageIndex = [self validPageValue:_currentPageIndex+1];
            [self reloadDataForScrollView:PageDirectionPrevious];
        }
        if(x <= 0) {
            _currentPageIndex = [self validPageValue:_currentPageIndex-1];
            [self reloadDataForScrollView:PageDirectionDown];
        }
    }else if(_orientation == FlowViewOrientationVertical) {
        // 往下翻一张
        if(y >= 2 * (_scrollView.bounds.size.height)) {
            _currentPageIndex = [self validPageValue:_currentPageIndex-1];
            [self reloadDataForScrollView:PageDirectionPrevious];
        }
        if(y <= 0) {
            _currentPageIndex = [self validPageValue:_currentPageIndex-1];
            [self reloadDataForScrollView:PageDirectionDown];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(didScrollToPage:inFlowView:)]) {
        [_delegate didScrollToPage:_currentPageIndex inFlowView:self];
    }
    
    if (_orientation == FlowViewOrientationHorizontal) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
    }
    if (_orientation == FlowViewOrientationVertical) {
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.bounds.size.height) animated:NO];
    }
    [self stopAutoAnimating];
    [self startAutoAnimating];
    
}

- (void)scrollToNextPage
{
    
    if (_pageCount<=1) {
        return;
    }
    UIView *newItem = [_reusableCells lastObject] ;
    newItem.frame = CGRectMake(_pageSize.width*3, 0, _pageSize.width, _pageSize.height);
    [_reusableCells removeObjectIdenticalTo:newItem];
    [_scrollView addSubview:newItem];
    [_inUseCells addObject:newItem];
    
    UIView  *oldItem = [_inUseCells objectAtIndex:0] ;
    
    _currentPageIndex = [self validPageValue:_currentPageIndex+1];
    
    __weak id<SYPageFlowViewDelegate> weakDelegate=_delegate;
    __weak SYPageFlowView *weakSelf=self;
    __weak NSMutableArray *weakUseCells=_inUseCells;
    __weak NSMutableArray *weakReusableCells=_reusableCells;
    __block NSInteger weakCurrentIndex=_currentPageIndex;
    __block CGSize weakSize=_pageSize;
    __block NSInteger weakTotalCount=_pageCount;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         for (NSInteger  i=0; i<[weakUseCells count]; i++) {
                             UIView  *v = [weakUseCells objectAtIndex:i];
                             v.frame = CGRectMake(weakSize.width*(i-1), 0, weakSize.width, weakSize.height);
                         }
                         [weakUseCells removeObjectAtIndex:0];
                         [weakSelf refreshVisibleCellAppearance];
                         
                     } completion:^(BOOL finished) {
                         oldItem.frame = CGRectMake(0, 0, weakSize.width, weakSize.height);
                         [weakReusableCells insertObject:oldItem atIndex:0];
                         [oldItem removeFromSuperview];
                         UIView  *reuseCell = [weakReusableCells lastObject];
                         
                         NSInteger  index = 0;
                         if (weakCurrentIndex == weakTotalCount-1) {
                             index = 1;
                         }else if ((weakCurrentIndex+1 == weakTotalCount-1)) {
                             index = 0;
                         }else{
                             index = weakCurrentIndex +2;
                         }
                         reuseCell.tag = index + kTagOffset;
                         reuseCell.frame = CGRectMake(weakSize.width*2, 0, weakSize.width, weakSize.height);
                         
                         //[_delegate didReloadData:reuseCell cellForPageAtIndex:index];
                         if ([weakDelegate respondsToSelector:@selector(didReloadData:cellForPageAtIndex:)]) {
                             [weakDelegate didReloadData:reuseCell cellForPageAtIndex:index];
                         }
                         
                         [weakSelf startAutoAnimating];
                         if ([weakDelegate respondsToSelector:@selector(didAutoScrollToPage:inFlowView:)]) {
                             [_delegate didAutoScrollToPage:_currentPageIndex inFlowView:weakSelf];
                         }
                     }];
    
    
    
}
#pragma mark - Auto Animation
- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration < 1.0 ? 1.0 : animationDuration;
}
- (void)setAutoAnimation:(BOOL)autoAnimation {
    _autoAnimation = autoAnimation;
    [self stopAutoAnimating];
    [self startAutoAnimating];
}
- (void)startAutoAnimating {
    if (_autoAnimation) {
        [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:_animationDuration];
    }
}

- (void)stopAutoAnimating {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:nil];
}
- (void)removeFromSuperview {
    [self stopAutoAnimating];
    [super removeFromSuperview];
}
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *resultView = [super hitTest:point withEvent:event];
    CGPoint bpoint = [_scrollView convertPoint:point fromView:self];
    if (![_scrollView pointInside:bpoint withEvent:event]) {
        return _scrollView;
    }
    return resultView;
    //    return [_scrollView hitTest:point withEvent:event];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGRect  frame = CGRectMake(_scrollView.center.x-_pageSize.width/2,
                               _scrollView.center.y-_pageSize.height/2,
                               _pageSize.width, _pageSize.height);
    CGPoint  point = [gestureRecognizer locationInView:_scrollView];
    if(CGRectContainsPoint(frame, point)){
        return YES;
    }
    return NO;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer{
    
    
    CGPoint tapPoint = [gestureRecognizer locationInView:_scrollView];
    
    float topY   = (_scrollView.height - _scrollView.height)/2;
    BOOL yInCell = NO;
    if (tapPoint.y > topY && tapPoint.y < _scrollView.height-topY){
        yInCell = YES;
    }
    int xInCellNumber = (tapPoint.x - 0)/(_pageSize.width + 0);
    BOOL xInCell = NO;
    if (tapPoint.x > 0 + ((_pageSize.width + 0) * xInCellNumber)
        && tapPoint.x < 0 + ((_pageSize.width + 0) * xInCellNumber) + _pageSize.width) {
        xInCell = YES;
    }
    if (xInCellNumber < 0 || xInCellNumber >= [_dataSource numberOfPagesInFlowView:self]) {
        xInCell = NO;
    }
    if (yInCell && xInCell) {
        if ([_delegate respondsToSelector:@selector(didSelectItemAtIndex:inFlowView:)]) {
            [_delegate didSelectItemAtIndex:[self validPageValue: _currentPageIndex+(xInCellNumber-1)] inFlowView:self];
        }
    }
    
}

@end