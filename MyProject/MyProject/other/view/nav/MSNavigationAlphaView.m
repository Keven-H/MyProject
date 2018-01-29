//
//  MSNavigationAlphaView.m
//  meishi
//
//  Created by Mac on 7/10/15.
//  Copyright (c) 2015 Kangbo. All rights reserved.
//

#import "MSNavigationAlphaView.h"

@interface MSNavigationAlphaView ()
{
    UIStatusBarStyle barStyle;
}
PROPERTY_STRONG UIView *contentView;
@end

@implementation MSNavigationAlphaView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _barCanAlpha=YES;
        self.userInteractionEnabled = YES;
        self.scrollHeigth=100;
//        self.layer.zPosition = MAXFLOAT;
        
        self.contentView = [[UIView alloc] init];
//        self.contentView.backgroundColor = FNColor(255, 255, 255);
        self.contentView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.contentView];
        barStyle=  [[UIApplication sharedApplication] statusBarStyle];
    
    }
    return self;
}
-(void)setScrollView:(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=scrollView;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if (object == self.scrollView&&[keyPath isEqualToString:@"contentOffset"]) {
        [self updateNavigationView:self ScrollView:self.scrollView alphaOffset:self.scrollHeigth];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (void)setBackgroundColor:(UIColor *)backgroundColor
//{
////    [super setBackgroundColor:backgroundColor];
//    
//    self.contentView.backgroundColor = backgroundColor;
//}

- (void)setContentBackGroundColor:(UIColor *)contentBackGroundColor
{
    _contentBackGroundColor = contentBackGroundColor;
    self.contentView.backgroundColor = contentBackGroundColor;
}

- (void)setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;
    self.contentView.alpha = contentAlpha;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    if (_leftItem != nil) {
        CGFloat marginX = 15;
        CGFloat marginY = (CGRectGetHeight(self.frame) - 20 - CGRectGetHeight(_leftItem.frame)) / 2;
        _leftItem.frame = CGRectMake(marginX,
                                     20 + marginY,
                                     CGRectGetWidth(_leftItem.frame),
                                     MIN(CGRectGetHeight(self.frame) - 20, CGRectGetHeight(_leftItem.frame)));
        
    }
    if (_leftOtheritem) {
        _leftOtheritem.frame=CGRectMake(44+10, 0, _leftOtheritem.width, _leftOtheritem.height);
        _leftOtheritem.centerY=20+(self.height-20)/2;
    }
    
    if (_rightItem != nil) {
        CGFloat marginRightX =  SCREEN_WIDTH - CGRectGetWidth(_rightItem.frame) - 3;
        CGFloat marginRightY = (CGRectGetHeight(self.frame) - 20 - CGRectGetHeight(_rightItem.frame)) / 2;
        CGFloat heightRightY = MIN(CGRectGetHeight(self.frame) - 17, CGRectGetHeight(_rightItem.frame));
        _rightItem.frame = CGRectMake(marginRightX-10,
                                      20 + marginRightY,
                                      CGRectGetWidth(_rightItem.frame),
                                      heightRightY);
    }
    
    if (_bottomItem != nil) {
        CGFloat marginRightX =  SCREEN_WIDTH - CGRectGetWidth(_bottomItem.frame) - 42;
        CGFloat marginRightY = (CGRectGetHeight(self.frame) - 20 - CGRectGetHeight(_bottomItem.frame)) / 2;
        CGFloat heightRightY = MIN(CGRectGetHeight(self.frame) - 17, CGRectGetHeight(_bottomItem.frame));
        _bottomItem.frame = CGRectMake(marginRightX-10,
                                      20 + marginRightY,
                                      CGRectGetWidth(_bottomItem.frame),
                                      heightRightY);
    }
    
    if (_titleView != nil) {
        CGFloat minx = 80;
        if (_leftItem) {
            minx = CGRectGetMaxX(_leftItem.frame) + 10;
        }
        CGFloat rightMargin = SCREEN_WIDTH - 10;
        if (_rightItem) {
            rightMargin = CGRectGetMinX(_rightItem.frame);
        }
        _titleView.frame = CGRectMake((SCREEN_WIDTH - (rightMargin - minx)) / 2,
                                      CGRectGetHeight(self.frame) - _titleView.height,
                                      rightMargin - minx,
                                      _titleView.height);
    }
    
}

-(void)setLeftOtheritem:(UIControl *)leftOtheritem
{
    if (_leftOtheritem) {
        [_leftOtheritem removeFromSuperview];
    }
    _leftOtheritem=leftOtheritem;
    if (_leftOtheritem) {
        [self addSuViewWithDescendant:_leftOtheritem];
        [self setNeedsLayout];
    }
}
- (void)setLeftItem:(UIControl *)leftItem
{
    if (_leftItem) {
        [_leftItem removeFromSuperview];
    }
    _leftItem = leftItem;
    if (leftItem != nil) {
        [self addSuViewWithDescendant:self.leftItem];
        [self setNeedsLayout];
    }
}

- (void)setRightItem:(UIControl *)rightItem
{
    if (_rightItem) {
        [_rightItem removeFromSuperview];
    }
    _rightItem = rightItem;
    if (rightItem != nil) {
        [self addSuViewWithDescendant:rightItem];
        [self setNeedsLayout];
    }
}

- (void)setBottomItem:(UIControl *)bottomItem
{
    if (_bottomItem) {
        [_bottomItem removeFromSuperview];
    }
    _bottomItem = bottomItem;
    if (bottomItem != nil) {
        [self addSuViewWithDescendant:bottomItem];
        [self setNeedsLayout];
    }
}

- (void)setTitleView:(UIView *)titleView
{
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    if (titleView != nil) {
        [self addSuViewWithDescendant:titleView];
        [self setNeedsLayout];
    }
}
-(void)unAuto
{
    self.barCanAlpha=NO;
    self.scrollHeigth=0;
     [[UIApplication sharedApplication] setStatusBarStyle:barStyle];
    self.contentAlpha=1;
    [self upDataViewShow];
}
-(void)upDataViewShow
{
    [self upDataLabelTitlColor:NO];
    if ([self.leftItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *leftBtn = (MSNavigationButton *)self.leftItem;
        leftBtn.buttonState = MSNavigationButtonState_back;
        leftBtn.alpha = 1;
    }
    if ([self.leftOtheritem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *leftBtn = (MSNavigationButton *)self.leftOtheritem;
        leftBtn.buttonState = MSNavigationButtonState_back;
        leftBtn.alpha = 1;
    }
    
    if ([self.rightItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *rightBtn = (MSNavigationButton *)self.rightItem;
        [rightBtn setButtonState:MSNavigationButtonState_back];
        rightBtn.alpha = 1;
    }
    
    if ([self.bottomItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *bottomBtn = (MSNavigationButton *)self.bottomItem;
        [bottomBtn setButtonState:MSNavigationButtonState_back];
        bottomBtn.alpha = 0;
    }
}
-(void)upDataLabelTitlColor:(BOOL)alphaSet
{
    if (![self.titleView.class isSubclassOfClass:[UILabel class]]) {
        return;
    }
    UILabel *label=(UILabel *)self.titleView;
    if (alphaSet) {
        label.textColor=[UIColor whiteColor];
    }else
    {
        label.textColor=XColor(51, 51, 51);
    }
}
-(void)initTitleLabel
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = UIFontWithSize(18);
    self.titleLabel.textColor = XColor(51, 51, 51);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0, 0, 120, 44);
    self.titleView =self.titleLabel;
}
- (void)updateNavigationView:(MSNavigationAlphaView *)view ScrollView:(UIScrollView *)scrollView alphaOffset:(CGFloat)offset
{
    if (self.scrollHeigth<=0||self.barCanAlpha==NO) {
        self.contentAlpha=1;
        [[UIApplication sharedApplication] setStatusBarStyle:barStyle];
        return;
    }
    CGFloat offsetx = scrollView.contentOffset.y;
    
    if (offsetx < 0) {
        view.contentAlpha = 0;
        [self upDataLabelTitlColor:YES];
//        view.titleView.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else if (offsetx > offset){
        [UIView animateWithDuration:.3 animations:^{
//            view.titleView.alpha = 1;
            view.contentAlpha = 1;
            [self upDataLabelTitlColor:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
    }
    else{
//        view.titleView.alpha = 0;
        view.contentAlpha = offsetx / offset;
        [self upDataLabelTitlColor:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    //处理left
    if ([view.leftItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *leftBtn = (MSNavigationButton *)view.leftItem;
        
        if (offsetx <= 0) {
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = 1;
        }
        else if (offsetx > 0 && offsetx <= offset / 2){
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = (1 - offsetx/(offset/2));
        }
        else if (offsetx > offset/2 && offsetx <= offset){
            leftBtn.buttonState = MSNavigationButtonState_back;
            leftBtn.alpha = (offsetx - offset/2) / (offset/2);
        }
        else if (offsetx > offset){
            leftBtn.buttonState = MSNavigationButtonState_back;
            leftBtn.alpha = 1;
        }
        else{
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = 1;
        }
    }
    //处理leftOther
    if ([view.leftOtheritem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *leftBtn = (MSNavigationButton *)view.leftOtheritem;
        if (offsetx <= 0) {
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = 1;
        }
        else if (offsetx > 0 && offsetx <= offset / 2){
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = (1 - offsetx/(offset/2));
        }
        else if (offsetx > offset/2 && offsetx <= offset){
            leftBtn.buttonState = MSNavigationButtonState_back;
            leftBtn.alpha = (offsetx - offset/2) / (offset/2);
        }
        else if (offsetx > offset){
            leftBtn.buttonState = MSNavigationButtonState_back;
            leftBtn.alpha = 1;
        }
        else{
            leftBtn.buttonState = MSNavigationButtonState_pre;
            leftBtn.alpha = 1;
        }
    }

    
    //处理right
    if ([view.rightItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *rightBtn = (MSNavigationButton *)view.rightItem;
        
        if (offsetx <= 0) {
            [rightBtn setButtonState:MSNavigationButtonState_pre];
            rightBtn.alpha = 1;
        }
        else if (offsetx > 0 && offsetx <= offset / 2){
            [rightBtn setButtonState:MSNavigationButtonState_pre];
            rightBtn.alpha = (1 - offsetx/(offset/2));
        }
        else if (offsetx > offset/2 && offsetx <= offset){
            [rightBtn setButtonState:MSNavigationButtonState_back];
            rightBtn.alpha = (offsetx - offset/2) / (offset/2);
        }
        else if (offsetx > offset){
            [rightBtn setButtonState:MSNavigationButtonState_back];
            rightBtn.alpha = 1;
        }
        else{
            [rightBtn setButtonState:MSNavigationButtonState_pre];
            rightBtn.alpha = 1;
        }
        //NSLog(@"dfsadfs-dfs------: %f %f %f",offsetx, offset / 2, offset);
    }
    
    //处理bottom
    if ([view.bottomItem isKindOfClass:[MSNavigationButton class]]) {
        MSNavigationButton *bottomBtn = (MSNavigationButton *)view.bottomItem;
        
        if (offsetx <= 0) {
            [bottomBtn setButtonState:MSNavigationButtonState_pre];
            bottomBtn.alpha = 0;
            if (self.sourceAlphaViewType == FNNavigationAlphaViewSourceTypeBuinessDetail) {
                bottomBtn.alpha = 1;
            }
        }
        else if (offsetx > 0 && offsetx <= offset / 2){
            [bottomBtn setButtonState:MSNavigationButtonState_pre];
            bottomBtn.alpha = 0;
            if (self.sourceAlphaViewType == FNNavigationAlphaViewSourceTypeBuinessDetail) {
                bottomBtn.alpha = (1 - offsetx/(offset/2));
            }
        }
        else if (offsetx > offset/2 && offsetx <= offset){
            [bottomBtn setButtonState:MSNavigationButtonState_back];
            bottomBtn.alpha = (offsetx - offset/2) / (offset/2);
        }
        else if (offsetx > offset){
            [bottomBtn setButtonState:MSNavigationButtonState_back];
            bottomBtn.alpha = 1;
        }
        else{
            [bottomBtn setButtonState:MSNavigationButtonState_pre];
            bottomBtn.alpha = 1;
        }
        //NSLog(@"dfsadfs-dfs------: %f %f %f",offsetx, offset / 2, offset);
    }

}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
}
-(void)dealloc
{
    @try {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
      [[UIApplication sharedApplication] setStatusBarStyle:barStyle];
    NSLog(@"%s",__func__);
}

@end
