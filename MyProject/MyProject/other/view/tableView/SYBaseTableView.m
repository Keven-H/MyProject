//
//  SYBaseTableView.m
//  Foodie
//
//  Created by liyunqi on 16/3/15.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYBaseTableView.h"
@interface SYBaseTableView()
{
    UILabel *labelNoMoreNumber;
    BOOL NumberViewSourceNum;//有无更多数据源
}
@end
@implementation SYBaseTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultSetting];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [self initDefaultSetting];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultSetting];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefaultSetting];
    }
    return self;
}
-(void)initDefaultSetting
{
#ifdef __IPHONE_11_0
    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    
    self.contentInset = UIEdgeInsetsMake(kNavBarDefaultHeight, 0, 0, 0);
    self.contentOffset=CGPointMake(0, -self.contentInset.top);
    self.backgroundColor=[UIColor clearColor];
    self.separatorColor=[UIColor clearColor];
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (labelNoMoreNumber==nil) {
        labelNoMoreNumber=[[UILabel alloc]init];
        labelNoMoreNumber.numberOfLines=1;
        labelNoMoreNumber.textAlignment=NSTextAlignmentCenter;
        labelNoMoreNumber.font=UIFontWithSize(14);
        labelNoMoreNumber.text=@"没有更多内容了";
        labelNoMoreNumber.backgroundColor=[UIColor clearColor];
        labelNoMoreNumber.textColor=XColor(160, 160, 160);
        labelNoMoreNumber.hidden=YES;
        labelNoMoreNumber.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
        [self addSubview:labelNoMoreNumber];
    }
}
-(NSArray<UIView *> *)subviews
{
    return [super subviews];
}
-(void)setShowNoNumberView:(BOOL)showNoNumberView
{
    _showNoNumberView=showNoNumberView;
    if (_showNoNumberView) {
        [self addContentObserver];
    }
}
-(void)reloadData
{
    [super reloadData];
    [self resetNumberSourece];
}


-(void)resetNoNumberView
{
    if (!self.showNoNumberView||(self.mj_footer&&!self.mj_footer.hidden)) {
        labelNoMoreNumber.hidden=YES;
        return;
    }
    if (self.listStyle==XListViewStyleStandard||self.listStyle==XListViewStyleFooter) {
        labelNoMoreNumber.hidden=YES;
        return;
    }
    if (!NumberViewSourceNum) {
        labelNoMoreNumber.hidden=YES;
        return;
    }
    labelNoMoreNumber.hidden=YES;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [UIView performWithoutAnimation:^{
        if (self.height>0&&self.contentSize.height>0&&self.contentSize.height>=self.height) {
            labelNoMoreNumber.frame=CGRectMake(0, self.contentSize.height, labelNoMoreNumber.width, labelNoMoreNumber.height);
            labelNoMoreNumber.center=CGPointMake(self.width/2, labelNoMoreNumber.center.y);
            labelNoMoreNumber.hidden=NO;
        }
    }];
#else
    if (self.height>0&&self.contentSize.height>0&&self.contentSize.height>=self.height) {
        labelNoMoreNumber.frame=CGRectMake(0, self.contentSize.height, labelNoMoreNumber.width, labelNoMoreNumber.height);
        labelNoMoreNumber.center=CGPointMake(self.width/2, noNumView.center.y);
        labelNoMoreNumber.hidden=NO;
    }
#endif

}
-(NSInteger)numberOfSection:(NSInteger)section
{
    NSInteger number=0;
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        number=[self.dataSource tableView:self numberOfRowsInSection:section];
    }
    return number;
}
-(void)resetNumberSourece
{
    NumberViewSourceNum= self.totalDataCount>0?YES:NO;
}
-(BOOL)hasAddObserver
{
    NSNumber *hasAdd=objc_getAssociatedObject(self, @"hasAddObserver");
    if (hasAdd&&hasAdd.boolValue) {
        return YES;
    }
    return NO;
}
-(void)addContentObserver
{
    if (![self hasAddObserver]) {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:(__bridge void*)self];
        objc_setAssociatedObject(self, @"hasAddObserver", [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ((__bridge id)context == self) {
        if ([@"contentOffset" isEqualToString:keyPath]) {
            [self resetNoNumberView];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

-(void)removeFromSuperview
{
    self.dataSource=nil;
    self.delegate=nil;
    if ([self hasAddObserver]) {
        @try {
            [self removeObserver:self forKeyPath:@"contentOffset"];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    [super removeFromSuperview];
}
-(void)dealloc
{
     NSLog(@"%s___from:%s",__FUNCTION__,object_getClassName(self));
}

@end
