//
//  SYBaseNavAlphaController.m
//  Foodie
//
//  Created by liyunqi on 20/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYBaseNavAlphaController.h"
#import "JDFPeekabooCoordinator.h"
@interface SYBaseNavAlphaController ()<UITableViewDelegate,UITableViewDataSource>
PROPERTY_STRONG JDFPeekabooCoordinator*coordinator;
@end

@implementation SYBaseNavAlphaController

- (void)viewDidLoad {
    [super viewDidLoad];
    _autoNavScroll=NO;
    [self initBaseNavAlpha];
    [self initBaseTableView];
    self.navAlphaView.scrollView=self.tableView;
}
-(JDFPeekabooCoordinator *)coordinator
{
    if (!_coordinator) {
        _coordinator=[[ JDFPeekabooCoordinator alloc]init];
        _coordinator.topViewMinimisedHeight=0;
        _coordinator.delegateController = self;
        _coordinator.scrollView=self.tableView;
        _coordinator.topView=self.navAlphaView;
    }
    return _coordinator;
}
-(void)setAutoNavScroll:(BOOL)autoNavScroll
{
    _autoNavScroll=autoNavScroll;
    if (autoNavScroll) {
        [self.coordinator enable];
    }else
    {
        [self.coordinator disable];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navAlphaView];
    self.navBarHidden=YES;
}
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.navAlphaView.titleLabel.text=title;
}
-(void)initBaseNavAlpha
{
    _navAlphaView = [[MSNavigationAlphaView alloc] init];
    self.navAlphaView.frame = CGRectMake(0, 0,self.view.width, kNavBarDefaultHeight);
    [self.view addSubview:self.navAlphaView];
    [self.view bringSubviewToFront:self.navAlphaView];
    [self.navAlphaView initTitleLabel];
    
    UIImage *nImage = ImageNamed(@"backArrowRichTextDetail_whiteNew");
    UIImage *hImage = ImageNamed(@"backArrowRichTextDetail_blackNew");
    MSNavigationButton *btn =[MSNavigationButton buttonWithSize:CGSizeMake(22, 22) preImage:nImage backImage:hImage target:self sel:@selector(BaseControllerClickNavLeftButton:)];
    btn.enlargeEdge = UIEdgeInsetsMake(10, 10, 10, 0);;
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.navAlphaView.leftItem = btn;
    
    nImage = ImageNamed(@"sy_goRoot_u");
    hImage = ImageNamed(@"sy_goRoot_h");
    MSNavigationButton *btnO =[MSNavigationButton buttonWithSize:CGSizeMake(22, 22) preImage:nImage backImage:hImage target:self sel:@selector(baseGotoRootController)];
    btnO.enlargeEdge = UIEdgeInsetsMake(10, 0, 10, 10);;
    btnO.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.navAlphaView.leftOtheritem=btnO;
    
    self.navAlphaView.contentAlpha=0;
}
- (void)initBaseTableView{
    
    _tableView = [[SYBaseTableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.contentInset=UIEdgeInsetsZero;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor: [UIColor clearColor]];
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
