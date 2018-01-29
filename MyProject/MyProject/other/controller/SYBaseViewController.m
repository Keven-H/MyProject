//
//  SYBaseViewController.m
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYBaseViewController.h"
#import "SYNavigationItemBtnView.h"
#import <objc/runtime.h>
#import "IQKeyboardManager.h"

@interface SYBaseViewController ()
{
    
}
PROPERTY_ASSIGN NSInteger viewControllersTotal;
@end

@implementation SYBaseViewController
-(id)init
{
    self=[super init];
    if (self) {
        [self initDefaultData];
    }
    return self;
}
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil 
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDefaultData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self initDefaultData];
    }
    return self;
}

-(void)initDefaultData
{
    _autoTextResponder=NO;
    _autoStatusBarStyle=YES;
    _navBarHidden=NO;
    _autoShowBack=YES;
    _canShowGoRoot=NO;
    _thisControllerCanGoRoot=NO;;
    _navClearColor=NO;
}

- (void)viewDidLoad {
     [self initNavigationView];
    if (self.navigationController.viewControllers.count>1&&self.autoShowBack) {
            [self SYShowBackButton:YES];
    }
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;

}
-(void)setAutoTextResponder:(BOOL)autoTextResponder
{
    _autoTextResponder=autoTextResponder;
    [self resetAutotText];
}
-(void)resetAutotText
{
    if (self.autoTextResponder==NO) {
        [[IQKeyboardManager sharedManager]disableInViewControllerClass:[self class]];
    }else
    {
        [[IQKeyboardManager sharedManager]removeDisableInViewControllerClass:[self class]];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetNavColor];
    self.navigationController.navigationBarHidden=YES;
    [self.view bringSubviewToFront:self.navBarItem.backView];
    if (self.autoStatusBarStyle) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [self resetAutotText];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]disableInViewControllerClass:[self class]];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)BaseControllerClickNavLeftButton:(UIButton *)btn
{
    [self backViewController];
}
-(void)BaseControllerClickNavRightButton:(UIButton *)btn
{
    
}

- (void)initNavigationView
{
    if (!self.navBarItem ) {
        self.navBarItem = [[SYNavigationItem alloc]init];
        self.navBarItem.showController=self;
        self.navBarItem.backView.backgroundColor=[UIColor whiteColor];
    }
}
-(void)SYLeftBtnWithImageName:(NSString *)imageName  title:(NSString *)title
{
    if (!SYStringisEmpty(imageName)||!SYStringisEmpty(title)) {
        
        [self.navBarItem showLeftButtonWithNomoralImage:imageName HighlightedImage:nil title:title];
        [self.navBarItem.navigationLeftBtn.goRootItem removeAllTargets];
        [self.navBarItem.navigationLeftBtn.goBackItem removeAllTargets];
        [self.navBarItem.navigationLeftBtn.goBackItem addTarget:self action:@selector(BaseControllerClickNavLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBarItem.navigationLeftBtn.goRootItem addTarget:self action:@selector(baseGotoRootController) forControlEvents:UIControlEventTouchUpInside];
        [self resetShowGotoRoot];
    }else{
        self.navBarItem.centerItemView=nil;
    }
}
-(void)SYRightBtnWithImageName:(NSString *)imageName  title:(NSString *)title
{
    if (!SYStringisEmpty(imageName)||!SYStringisEmpty(title)) {
        [self.navBarItem showRightButtonWithNomoralImage:imageName HighlightedImage:nil title:title];
        [self.navBarItem.navigationRightBtn addTarget:self action:@selector(BaseControllerClickNavRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        self.navBarItem.rigthItemView=nil;
    }
}
-(void)SYShowBackButton:(BOOL)showBack
{
    if (showBack) {
        NSString *leftTitle=nil;
        if (!SYStringisEmpty(self.backTitle)) {
            leftTitle = self.backTitle;
        }
        else if(self.navigationController.viewControllers.count>1){
            leftTitle=((UIViewController *)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]).title;
        }
        if (SYStringisEmpty(leftTitle)) {
            leftTitle=@"返回";
        }
        leftTitle=nil;
//        暂时不用
//        leftTitle=nil;
        [self SYLeftBtnWithImageName:@"backArrowRichTextDetail_blackNew" title:leftTitle];
    }else
    {
        [self SYLeftBtnWithImageName:nil title:nil];
    }
}




-(NSInteger)viewControllersTotal
{
    return self.navigationController.viewControllers.count;
}

-(BOOL)GoRootBtnCanShow
{
    BOOL canShow=YES;
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SYBaseViewController class]]) {
            if (((SYBaseViewController *)controller).thisControllerCanGoRoot==NO) {
                canShow=NO;
                break;
            }
        }
    }
    if (self.canShowGoRoot&&canShow&&self.viewControllersTotal>=3) {
        return YES;
    }
    return NO;
}

#pragma mark reset
-(void)resetNavColor
{
    if (self.navClearColor) {
        self.navBarItem.backView.backgroundColor=[UIColor clearColor];
        self.navBarItem.lineView.backgroundColor=[UIColor clearColor];
        self.navBarItem.titleLabel.hidden=YES;
        self.navBarItem.backView.image=nil;
    }else
    {
        self.navBarItem.backView.backgroundColor=Color(248, 248, 248) ;
        self.navBarItem.lineView.backgroundColor=[UIColor clearColor];
        self.navBarItem.titleLabel.hidden=NO;
        self.navBarItem.backView.image=ImageNamed(@"bgnav");
    }
}
-(void)resetShowGotoRoot
{

    if ([self GoRootBtnCanShow]) {
        self.navBarItem.navigationLeftBtn.goRootItem.hidden=NO;
    }else
    {
        self.navBarItem.navigationLeftBtn.goRootItem.hidden=YES;
    }
    UIImage *imageBackNormalW=ImageNamed(@"backArrowRichTextDetail_blackNew");//backArrowRichTextDetail_whiteNew
    UIImage *imageBackNormalB=ImageNamed(@"backArrowRichTextDetail_blackNew");
    if (self.navClearColor) {
        if ([self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]) {
            if ([[self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]isEqual:imageBackNormalW]||[[self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]isEqual:imageBackNormalB]) {
                [self.navBarItem.navigationLeftBtn.goBackItem setImage:imageBackNormalW forState:UIControlStateNormal];
            }
        }
        if ([self.navBarItem.navigationLeftBtn.goRootItem imageForState:UIControlStateNormal]) {
            //sy_goRoot_h
            [self.navBarItem.navigationLeftBtn.goRootItem setImage:ImageNamed(@"sy_goRoot_h") forState:UIControlStateNormal];
        }
    }else
    {
        if ([self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]) {
            if ([[self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]isEqual:imageBackNormalW]||[[self.navBarItem.navigationLeftBtn.goBackItem imageForState:UIControlStateNormal]isEqual:imageBackNormalB]) {
                [self.navBarItem.navigationLeftBtn.goBackItem setImage:imageBackNormalB forState:UIControlStateNormal];
            }
        }
        if ([self.navBarItem.navigationLeftBtn.goRootItem imageForState:UIControlStateNormal]) {
            [self.navBarItem.navigationLeftBtn.goRootItem setImage:ImageNamed(@"sy_goRoot_h") forState:UIControlStateNormal];
        }
    }
    [self.navBarItem adjustContent];
}


#pragma mark set
-(void)setCanShowGoRoot:(BOOL)canShowGoRoot
{
    _canShowGoRoot=canShowGoRoot;
    [self resetShowGotoRoot];
}
-(void)setAutoShowBack:(BOOL)autoShowBack
{
    _autoShowBack=autoShowBack;
    [self SYShowBackButton:_autoShowBack];
}
-(void)setNavBarHidden:(BOOL)navBarHidden
{
    _navBarHidden=navBarHidden;
    self.navBarItem.backView.hidden=navBarHidden;
}
-(void)setNavClearColor:(BOOL)navClearColor
{
    _navClearColor=navClearColor;
    [self resetNavColor];
    [self resetShowGotoRoot];
}
-(void)setThisControllerCanGoRoot:(BOOL)thisControllerCanGoRoot
{
    _thisControllerCanGoRoot=thisControllerCanGoRoot;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.navBarItem.title=title;
}


-(void)baseGotoRootController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark --
#pragma mark XViewController

- (void) resetExceptionContentView{
    [super resetExceptionContentView];
    if(self.exceptionContentView){
        if(self.exceptionContentView.constraints.count > 0){
            for(NSLayoutConstraint *constraint in self.view.constraints)
            {
                if((constraint.firstItem == self.exceptionContentView && constraint.secondItem == self.view)){
                    if(constraint.firstAttribute == NSLayoutAttributeTop){
                        constraint.constant = self.navBarHidden ? 0 : kNavBarDefaultHeight;
                    }
                }else if(constraint.firstItem == self.view && constraint.secondItem == self.exceptionContentView){
                    if(constraint.secondAttribute == NSLayoutAttributeTop){
                        constraint.constant = self.navBarHidden ? 0 : -kNavBarDefaultHeight;
                    }
                }
            }
        }else{
            CGFloat pointY = 0;
            if(!self.navBarHidden){
                pointY = kNavBarDefaultHeight;
            }
            CGRect frame = self.exceptionContentView.frame;
            frame.origin.y = pointY;
            frame.size.height -= pointY;
            self.exceptionContentView.frame = frame;
        }
    }
}

#pragma mark SAScreenAutoTrackerDelegate
-(NSDictionary *)getTrackProperties
{
    if (!SYStringisEmpty(self.pageName)) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:self.pageName forKey:@"$title"];
        return dic;
    }
    return nil;
}

-(NSString *)getScreenUrl
{
    return [[HCXDateManager shareDataManager]getCurrentController:NSStringFromClass(self.class)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc
{
    
}


@end
