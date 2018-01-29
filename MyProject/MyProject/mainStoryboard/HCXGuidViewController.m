//
//  HCXGuidViewController.m
//  EatEquity
//
//  Created by liyunqi on 09/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXGuidViewController.h"
//#import "HCXLoginViewController.h"
@interface HCXGuidViewController ()<MSFlowScrollViewDataSource,MSFlowScrollViewDelegate>
PROPERTY_STRONG MSFlowScrollView *pageFlow;
PROPERTY_STRONG NSMutableArray *listImg;
PROPERTY_STRONG TAPageControl *pageControl;

PROPERTY_STRONG UIButton  *btnRes;
PROPERTY_STRONG UIButton  *btn;

PROPERTY_STRONG UIActivityIndicatorView *actionView;
@end

@implementation HCXGuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageName=@"启动页";
    self.navBarHidden=YES;
    self.listImg=[NSMutableArray new];
    for (int i=1; i<=8; i++) {
        [self.listImg addObject:NSStringFromInt(i)];
    }
    
    self.pageFlow=[[MSFlowScrollView alloc]initWithFrame:self.view.bounds];
    self.pageFlow.contentSize=self.view.bounds.size;
    self.pageFlow.delegate=self;
    self.pageFlow.dataSource=self;
    self.pageFlow.autoAnimation=NO;
    self.pageFlow.cycleEnabled=NO;
    [self.view addSubview:self.pageFlow];
    
    
    
     self.btnRes=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRes setImage:ImageNamed(@"hc_wel_add") forState:UIControlStateNormal];
    [self.btnRes addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[HCXRouterManager shareManager]openUrl:@"web/registe"];
    }];
    self.btnRes.size=self.btnRes.currentImage.size;
    self.btnRes.y=self.view.height-self.btnRes.height-20;
    self.btnRes.x=IS_IPHONE_5_OR_LESS?15:30;
    [self.view addSubview:self.btnRes];

    
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:ImageNamed(@"hc_wel_login") forState:UIControlStateNormal];
    [self.btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[HCXRouterManager shareManager]openUrl:@"login"];
    }];
    self.btn.size=self.btnRes.currentImage.size;
    self.btn.y=self.btnRes.y;
    self.btn.x=self.view.width-self.btnRes.x-self.btn.width;
    [self.view addSubview:self.btn];
    

    self.pageControl=[[TAPageControl alloc]init];
    self.pageControl.numberOfPages=self.listImg.count;
    self.pageControl.dotImage=ImageNamed(@"hc_wel_no");
    self.pageControl.currentDotImage=ImageNamed(@"hc_wel_se");
    self.pageControl.dotSize=self.pageControl.dotImage.size;
    self.pageControl.spacingBetweenDots=4;
    self.pageControl.shouldResizeFromCenter=NO;
    [self.view addSubview:self.pageControl];
    

 self.pageControl.size=CGSizeMake((self.listImg.count-1)*self.pageControl.spacingBetweenDots+self.listImg.count*self.pageControl.dotImage.size.width, self.pageControl.dotImage.size.height);
    self.pageControl.y=self.btn.y-30-self.pageControl.height;
    self.pageControl.x=self.view.width-self.pageControl.width-self.btnRes.x;
    [self.view addSubview:self.pageControl];
    
    [self.pageControl sizeToFit];
    
    self.actionView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.actionView stopAnimating];
    [self.view addSubview:self.actionView];
    
    self.actionView.center=CGPointMake(self.view.width/2, self.view.height/2);
    
    
    self.btn.hidden=YES;
    self.btnRes.hidden=YES;
    if (![HCXDateManager appRegisterSwitch]) {
        self.btn.hidden=NO;
        self.btnRes.hidden=NO;
    }else
    {
        FNWeak(self, weakSelf);
        [self.actionView startAnimating];
        [[HCXSubService share]loadAppRegisterSwitchClassName:[SYResponse class]  responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
            [weakSelf.actionView stopAnimating];
            if (response.isSuccess&&[responseDic objectForKey:@"data"]) {
                NSNumber *value=[responseDic objectForKey:@"data"];
//                value=[NSNumber numberWithBool:NO];
                if (value.boolValue) {
                    NSLog(@"可以可以可以");
                    [HCXDateManager appRegisterSwitch:YES];
                    weakSelf.btn.hidden=NO;
                    weakSelf.btnRes.hidden=NO;
                   
                }else
                {
                    NSLog(@"失败失败");
                    weakSelf.btn.hidden=NO;
                    [weakSelf.btn setImage:ImageNamed(@"hui") forState:UIControlStateNormal];
                    weakSelf.btn.size=weakSelf.btn.currentImage.size;
                    weakSelf.btn.centerX=self.view.width/2;
                    
                }
            }else
            {
                weakSelf.btn.hidden=NO;
                 [weakSelf.btn setImage:ImageNamed(@"hui") forState:UIControlStateNormal];
                 weakSelf.btn.size=weakSelf.btn.currentImage.size;
                weakSelf.btn.centerX=self.view.width/2;
            }
        }];

    }
}

-(UIView*)viewForYRADScrollView:(MSFlowScrollView*)adScrollView atPage:(NSInteger)pageIndex
{
    SYImageObjView *view=[adScrollView dequeueReusableView];
    if (!view) {
        view=[[SYImageObjView alloc]init];
    }
    view.frame=self.view.bounds;
    view.image=ImageNamed([self.listImg objectAtIndex:pageIndex]);
    return view;
}
-(NSUInteger)numberOfViewsForYRADScrollView:(MSFlowScrollView*)adScrollView
{
    return self.listImg.count;
}
-(void)adScrollView:(MSFlowScrollView*)adScrollView didScrollToPage:(NSInteger)pageIndex
{
    self.pageControl.currentPage=pageIndex;
}
@end
