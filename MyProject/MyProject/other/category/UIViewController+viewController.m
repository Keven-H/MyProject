//
//  UIViewController+viewController.m
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "UIViewController+viewController.h"

@implementation UIViewController (viewController)
-(UITableView *)x_tableView
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            return (UITableView *)view;
        }
    }
    return nil;
}
@end
