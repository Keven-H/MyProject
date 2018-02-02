//
//  ViewController.m
//  MyProject
//
//  Created by Admin on 2018/1/2.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInitView];
}
- (void) createInitView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 100,100, 100)];

    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
