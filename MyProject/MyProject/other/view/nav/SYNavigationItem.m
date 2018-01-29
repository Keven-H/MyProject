//
//  SYNavigationView.m
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYNavigationItem.h"
#define SY_NAVBAR_TITLE_FONT UIFontWithBoldSize(17) //标题
#define SY_NAVBAR_ITEM_FONT UIFontWithSize(16) //左右两边title
#define SY_NAVBAR_ITEM_DEFAULT_COLOR FNColor(288, 81, 81)//左右item.title 默认颜色
#define SY_NAVBAR_ITEM_HIGHLIGHTED_COLOR FNColor(198, 53, 53)//左右item.title 选中颜色
#define SY_NAVBAR_LINE_COLOR  FNColor(221, 221, 221) //线颜色
@interface SYNavigationItem()
{
    UILabel *titleVIew;
}
@end
@implementation SYNavigationItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(UILabel *)titleview
{
    if (titleVIew==nil) {
        titleVIew=[[UILabel alloc]init];
        titleVIew.backgroundColor=[UIColor clearColor];
        titleVIew.textColor=[UIColor blackColor];
        titleVIew.textAlignment=NSTextAlignmentCenter;
        titleVIew.frame = CGRectMake(0, 0, 160, 30);
        titleVIew.font=SY_NAVBAR_TITLE_FONT;
    }
    return titleVIew;
}
-(UILabel *)titleLabel
{
    return [self titleview];
}
-(void)setShowController:(UIViewController *)showController
{
    _showController=showController;
    [self resetsubVaules];
}

-(UIImageView *)navBgView
{
    if ([self isTableviewController]) {
        return [self.showController.navigationController.navigationBar viewWithTag:105555];
    }
    //    为了与其他不是此子类的barview保持一致
    //    return [self.showController.navigationController.navigationBar viewWithTag:105555];
    return _backView;
    //    return self.showController.navigationController.navigationBar.overlay;
}
-(BOOL)isTableviewController
{
    return NO;
    return [self.showController.class isSubclassOfClass:[UITableViewController class]];
}

-(void)resetsubVaules
{
    UIImageView *bgView=[self navBgView];
    if (!bgView){
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [self isTableviewController]?-20:0, [UIScreen mainScreen].bounds.size.width, kNavBarDefaultHeight)];
        bgView.contentMode=UIViewContentModeScaleAspectFill;
        bgView.userInteractionEnabled=YES;
        bgView.tag=105555;
        if ([self isTableviewController]) {
            [self.showController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.showController.navigationController.navigationBar setShadowImage:[UIImage new]];
            self.showController.navigationController.navigationBar.tintColor = nil;
            [self.showController.navigationController.navigationBar insertSubview:bgView atIndex:0];
        }else
        {
            [self.showController.view addSubview:bgView];
        }
        _lineView=[[UIView alloc]init];
        _lineView.frame=CGRectMake(0, kNavBarDefaultHeight-0.5, SCREEN_WIDTH, 0.5);
        _lineView.backgroundColor = SY_NAVBAR_LINE_COLOR;
        [bgView addSubview:_lineView];
        //        [self.showController.view addSubview:bgView];
        
        //        [self.showController.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        //        bgView=self.showController.navigationController.navigationBar.overlay;
        
    }
    self.backView=bgView;
}
- (void)addSubviewWithSuperView:(UIView *)superView subView:(UIView *)subView
{
    if (subView == nil) return;
    if (![subView isDescendantOfView:superView]) {
        [superView addSubview:subView];
    }
}

- (void)layoutNavigationView
{
    
    CGFloat marginX = 15;
    if (_leftItemView != nil) {
        float lx=marginX;
        if ([_leftItemView isKindOfClass:[SYNavigationitemLeftView class]]) {
            lx=0;
        }
        _leftItemView.frame = CGRectMake(lx,0,_leftItemView.width,MIN(self.backView.height, _leftItemView.height));
        _leftItemView.centerY=20+(self.backView.height-20)/2;
    }
    
    if (_rigthItemView != nil) {
        
        CGFloat marginRightX =  SCREEN_WIDTH - _rigthItemView.width- marginX;
        _rigthItemView.frame = CGRectMake(marginRightX,0,_rigthItemView.width,MIN(self.backView.height - 20, _rigthItemView.height));
        _rigthItemView.centerY=20+(self.backView.height-20)/2;
    }
    
    if (_centerItemView != nil) {
        CGFloat margin=0;
        CGFloat marginCX=_leftItemView?(_leftItemView.x+_leftItemView.width+margin):marginX;
        CGFloat marginCRX=_rigthItemView?(_rigthItemView.x-margin):(self.backView.width-margin);
        CGFloat centerWidth=MIN(marginCRX-marginCX, _centerItemView.width);
        _centerItemView.frame=CGRectMake(marginCX, 0, centerWidth, MIN(self.backView.height - 20, _centerItemView.height));
        _centerItemView.centerY=20+(self.backView.height-20)/2;
        if (MAX(marginCX,SCREEN_WIDTH- marginCRX) <(SCREEN_WIDTH-_centerItemView.width)/2) {
            _centerItemView.centerX=self.backView.width/2;
        }
    }
}


-(void)createNavLeftBtn
{
    if (!self.navigationLeftBtn) {
        self.navigationLeftBtn=[[SYNavigationitemLeftView alloc]init];
        self.navigationLeftBtn.goBackItem.titleLabel.font=SY_NAVBAR_ITEM_FONT;
        self.navigationLeftBtn.backgroundColor=[UIColor clearColor];
        [self.navigationLeftBtn.goBackItem setTitleColor:[UIColor itiColor51_51_51] forState:UIControlStateNormal];
        self.navigationLeftBtn.hidden=YES;
    }
    [self.navigationLeftBtn resetDefault];
}

-(void)createNavRigthBtn
{
    if (!self.navigationRightBtn) {
        self.navigationRightBtn=[[SYNavigationItemBtnView alloc]init];
        self.navigationRightBtn.backgroundColor=[UIColor clearColor];
        self.navigationRightBtn.titleLabel.font=SY_NAVBAR_ITEM_FONT;
        [self.navigationRightBtn setTitleColor:[UIColor itiColor51_51_51] forState:UIControlStateNormal];
//        [self.navigationRightBtn setTitleColor:FNColor(198, 53, 53)  forState:UIControlStateHighlighted];
        self.navigationRightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        self.navigationRightBtn.hidden=YES;
    }
//    [self.navigationRightBtn setBackgroundImage:nil forState:UIControlStateNormal];
//    [self.navigationRightBtn setImage:nil forState:UIControlStateNormal];
//    [self.navigationRightBtn setImage:nil forState:UIControlStateHighlighted];
//    [self.navigationRightBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
//    self.navigationRightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;

}
-(void)setLeftItemView:(UIView *)leftItemView
{
    if (_leftItemView) {
        [_leftItemView removeFromSuperview];
    }
    _leftItemView=leftItemView;
    if ([self isTableviewController]) {
        if (leftItemView) {
//            [self.showController.navigationItem setItemWithCustomView:leftItemView itemType:left];
        }else
        {
            self.showController.navigationItem.leftBarButtonItem=nil;
        }
    }else
    {
        [self addSubviewWithSuperView:_backView subView:_leftItemView];
        [self layoutNavigationView];
    }
}
-(void)setRigthItemView:(UIView *)rigthItemView
{
    if (_rigthItemView) {
        [_rigthItemView removeFromSuperview];
    }
    _rigthItemView=rigthItemView;
    if ([self isTableviewController]) {
        if (_rigthItemView) {
//            [self.showController.navigationItem setItemWithCustomView:rigthItemView itemType:right];
        }else
        {
            self.showController.navigationItem.rightBarButtonItem=nil;
        }
    }else
    {
        [self addSubviewWithSuperView:_backView subView:_rigthItemView];
        [self layoutNavigationView];
    }
    
}

-(void)setCenterItemView:(UIView *)centerItemView
{
    _centerItemView=centerItemView;
    if ([self isTableviewController]) {
//        [self.showController.navigationItem setItemWithCustomView:_centerItemView itemType:center];
    }else
    {
        [self addSubviewWithSuperView:_backView subView:_centerItemView];
        [self layoutNavigationView];
    }
    
}
-(void)setTitle:(NSString *)title
{
    if (self.centerItemView&&![self.centerItemView isEqual:[self titleview]]) {
        return;
    }
    self.centerItemView=[self titleview];
    titleVIew.text=title;
    //
}

-(void)showLeftButtonWithNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title
{
    [self createNavLeftBtn];
    self.navigationLeftBtn.hidden=NO;
    if (!SYStringisEmpty(HighlightedImage)) {
        [self.navigationLeftBtn.goBackItem setImage:[UIImage imageNamed:HighlightedImage] forState:UIControlStateHighlighted];
    }
    [self.navigationLeftBtn showBackBtn:title imageStr:strNomoralImage];
    self.leftItemView = self.navigationLeftBtn;
}
-(void)showRightButtonWithNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title
{
    [self createNavRigthBtn];
    self.navigationRightBtn.hidden=NO;
    if (!SYStringisEmpty(strNomoralImage)) {
        [self.navigationRightBtn setImage:[UIImage imageNamed:strNomoralImage] forState:UIControlStateNormal];
    }
    if (!SYStringisEmpty(HighlightedImage)) {
        [self.navigationRightBtn setImage:[UIImage imageNamed:HighlightedImage] forState:UIControlStateHighlighted];
    }
    CGSize imageSize=self.navigationRightBtn.currentImage.size;
    self.navigationRightBtn.frame=CGRectMake(0, 0, imageSize.width+10, 44);
    if (!SYStringisEmpty(title)) {
        self.navigationRightBtn.frame = CGRectMake(0, 0, 165/2, 44);
        [self.navigationRightBtn setTitle:title forState:UIControlStateNormal];
        self.navigationRightBtn.backgroundColor=[UIColor clearColor];
        [self.navigationRightBtn.titleLabel sizeToFit];
        self.navigationRightBtn.frame=CGRectMake(0, 0, self.navigationRightBtn.titleLabel.frame.size.width, self.navigationRightBtn.titleLabel.frame.size.height);
    }
    self.rigthItemView=self.navigationRightBtn;
}
-(void)showBackBtn:(NSString *)title imageStr:(NSString *)strImage
{
    [self createNavLeftBtn];
    self.navigationLeftBtn.hidden=NO;
    [self.navigationLeftBtn showBackBtn:title imageStr:strImage];
    self.leftItemView = self.navigationLeftBtn;
}
-(void)adjustContent
{
    CGSize size=self.navigationLeftBtn.size;
    if (self.navigationLeftBtn.goRootItem.hidden) {
        self.navigationLeftBtn.width=self.navigationLeftBtn.goBackItem.width;
    }else
    {
        self.navigationLeftBtn.width=self.navigationLeftBtn.goBackItem.width+self.navigationLeftBtn.goRootItem.width;
    }
    if (!CGSizeEqualToSize(size, self.navigationLeftBtn.frame.size)) {
        [self layoutNavigationView];
    }
}
-(void)dealloc
{
    NSLog(@"%s___from:%s",__FUNCTION__,object_getClassName(self));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
