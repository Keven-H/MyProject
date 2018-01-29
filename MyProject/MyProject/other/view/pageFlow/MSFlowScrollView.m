//
//  MSFlowScrollView.m
//  meishi
//
//  Created by yunqi on 15/9/14.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import "MSFlowScrollView.h"

@interface MSFlowScrollView ()<UIScrollViewDelegate>{
    NSMutableSet *_reusableViewSet;
    NSMutableDictionary *_onShowViewDictionary;
    UIScrollView *_scrollView;
    
    NSInteger _totalPageNumber;
    NSInteger _positionIndex;
    NSInteger startIndex;
}

@end
@implementation MSFlowScrollView

-(id)init{
    return [self initWithFrame:CGRectZero];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        startIndex=0;
        // Initialization code
        _reusableViewSet = [[NSMutableSet alloc]initWithCapacity:4];
        _onShowViewDictionary = [[NSMutableDictionary alloc]initWithCapacity:3];
        _cycleEnabled = true;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        _scrollView.layer.masksToBounds=NO;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.scrollsToTop = NO;
        [self addSubview:_scrollView];
        
        _autoAnimation=NO;
        _animationDuration = 3.0;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_scrollView addGestureRecognizer:gesture];
    }
    return self;
}

-(void)layoutSubviews{
    //    _scrollView.frame = self.bounds;
    [super layoutSubviews];
    if (![self canAutoSize]) {
        [self reloadData];
    }else
    {
        self.contentSize=self.bounds.size;
    }
}
-(BOOL)canAutoSize
{
    if ([self.dataSource respondsToSelector:@selector(sizeForPageInFlowView:atPage:)]&&[self.delegate respondsToSelector:@selector(adScrollView:autoSize:)]) {
        return YES;
    }
    return NO;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)setScrollEnabled:(BOOL)scrollEnabled{
    _scrollView.scrollEnabled = scrollEnabled;
}

-(BOOL)scrollEnabled{
    return _scrollView.scrollEnabled;
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value < 0) value = [self.dataSource numberOfViewsForYRADScrollView:self]-1;                   // value＝1为第一张，value = 0为前面一张
    if(value >= [self.dataSource numberOfViewsForYRADScrollView:self]) value = 0;
    
    return value;
}
-(void)handleTap:(UITapGestureRecognizer*)gesture{
    
    CGPoint point=[gesture locationInView:self];
    CGPoint bpoint = [_scrollView convertPoint:point fromView:self];
    if ([_scrollView pointInside:bpoint withEvent:nil]) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(adScrollView:didClickedAtPage:)]) {
            [self.delegate adScrollView:self didClickedAtPage:_currentPage];
        }
    }
}

-(id)dequeueReusableView{
    id obj = [_reusableViewSet anyObject];
    if (obj) {
        [_reusableViewSet removeObject:obj];
    }
    return obj;
}
-(void)scrollToIndex:(NSInteger)index
{
    startIndex=index;
//    [self loadNextPage:index];
}
-(void)reloadData{
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(numberOfViewsForYRADScrollView:)]) {
            _totalPageNumber = [self.dataSource numberOfViewsForYRADScrollView:self];
        }
    }
    [_onShowViewDictionary removeAllObjects];
    [_reusableViewSet removeAllObjects];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _positionIndex=startIndex;
    _currentPage=startIndex;
    if (_cycleEnabled) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*2000*_totalPageNumber, 0);
        _positionIndex = 1000*_totalPageNumber+self.currentPage;
        [_scrollView setContentOffset:CGPointMake(_positionIndex*_scrollView.frame.size.width, 0) animated:NO];
    }else{
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_totalPageNumber, 0);
        _positionIndex = self.currentPage;
        [_scrollView setContentOffset:CGPointMake(_positionIndex*_scrollView.frame.size.width, 0) animated:NO];
    }
    
    if (_totalPageNumber>0) {
        [self setPageToPositionIndex:_positionIndex];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(adScrollView:didScrollToPage:)]) {
            [self.delegate adScrollView:self didScrollToPage:_currentPage];
        }
        if ([self canAutoSize]) {
            [self adjustHeight];
        }
    }
    [self stopAutoAnimating];
    [self startAutoAnimating];
}

-(void)setPageToPositionIndex:(NSInteger)positionIndex{
    [self prepareViewAtPositionIndex:positionIndex];
    [self prepareViewAtPositionIndex:positionIndex-1];
    [self prepareViewAtPositionIndex:positionIndex+1];
    
    
    NSArray *allKeyArray = _onShowViewDictionary.allKeys;
    for (NSInteger i=allKeyArray.count-1;i>=0;i--) {
        NSNumber *key = [allKeyArray objectAtIndex:i];
        NSInteger index = [key integerValue];
        UIView *view = [_onShowViewDictionary objectForKey:key];
        if (ABS(index-positionIndex)>1) {
            view.hidden = true;
            [_reusableViewSet addObject:view];
            [_onShowViewDictionary removeObjectForKey:key];
        }else{
            view.hidden = false;
        }
    }
}

-(NSInteger)pageFromPositionIndex:(NSInteger)positionIndex{
    if (_totalPageNumber==0) {
        return 0;
    }
    NSInteger showIndex = positionIndex;
    if (positionIndex>0) {
        showIndex = positionIndex%_totalPageNumber;
    }else if(positionIndex<0){
        showIndex = positionIndex%_totalPageNumber+_totalPageNumber;
    }
    return showIndex;
}

-(void)prepareViewAtPositionIndex:(NSInteger)positionIndex{
    if (!_cycleEnabled) {
        if (positionIndex<0||positionIndex>_totalPageNumber-1) {
            return;
        }
    }
    NSInteger showIndex = [self pageFromPositionIndex:positionIndex];
    UIView *view = [_onShowViewDictionary objectForKey:@(positionIndex)];
    if (!view&&self.dataSource&&[self.dataSource respondsToSelector:@selector(viewForYRADScrollView:atPage:)]) {
        view = [self.dataSource viewForYRADScrollView:self atPage:showIndex];
        [_scrollView addSubview:view];
        [_onShowViewDictionary setObject:view forKey:@(positionIndex)];
    }
    view.frame = CGRectMake(positionIndex*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    view.hidden = false;
}
-(void)setContentSize:(CGSize)contentSize
{
    _contentSize=contentSize;
    _scrollView.frame=CGRectMake(0, 0, contentSize.width, contentSize.height);
    _scrollView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}
-(void)adjustHeight
{
    if (_scrollView.width<=0) {
        return;
    }
    NSInteger page = (_scrollView.contentOffset.x/_scrollView.frame.size.width);
    CGSize size=[self.dataSource sizeForPageInFlowView:self atPage:[self pageFromPositionIndex:page+1]];
    CGSize cSize=[self.dataSource sizeForPageInFlowView:self atPage:[self pageFromPositionIndex:page]];
    float newSize=cSize.height + (size.height - cSize.height)/_scrollView.width * (_scrollView.contentOffset.x - page * _scrollView.width);
    [self.delegate adScrollView:self autoSize:CGSizeMake(self.width, newSize)];
    for (UIView * view in _onShowViewDictionary.allValues) {
        view.height=newSize;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_totalPageNumber==0) {
        return;
    }
    CGFloat pageWidth = _scrollView.frame.size.width;
    float Preloading=0.5;//为了处理屏幕上可以看到三个view
    if ((self.frame.size.width==self.contentSize.width&&self.layer.masksToBounds)|| [self canAutoSize]) {
        Preloading=0;
    }
    NSInteger page = (_scrollView.contentOffset.x/pageWidth) + Preloading;
    if (page!=_positionIndex) {
        if (!_cycleEnabled) {
            if (page<0||page>_totalPageNumber-1) {
                return;
            }
        }
        _positionIndex = page;
        _currentPage = [self pageFromPositionIndex:_positionIndex];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(adScrollView:didScrollToPage:)]) {
            [self.delegate adScrollView:self didScrollToPage:_currentPage];
        }

        [self setPageToPositionIndex:_positionIndex];
    }
    if ([self canAutoSize]) {
        [self adjustHeight];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self stopAutoAnimating];
    [self startAutoAnimating];
}

//-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return _scrollView;
//}
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


- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration < 1.0 ? 1.0 : animationDuration;
}
- (void)setAutoAnimation:(BOOL)autoAnimation {
    _autoAnimation = autoAnimation;
    [self stopAutoAnimating];
    [self startAutoAnimating];
}
-(void)loadNextPage:(NSInteger)nextPage
{
//    if (self.cycleEnabled) {
        [_scrollView setContentOffset:CGPointMake(nextPage*_scrollView.width, 0) animated:YES];
//    }
    [self startAutoAnimating];
}
-(void)scrollToNextPage
{
//    [self scrollToNextPage];
    [self loadNextPage:_positionIndex+1];
}
- (void)startAutoAnimating {
    if (_autoAnimation&&_cycleEnabled) {
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

@end
