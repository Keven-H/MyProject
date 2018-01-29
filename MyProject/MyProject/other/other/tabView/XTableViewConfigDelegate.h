//
//  ITITableViewConfigDelegate.h
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XCellConfigModel.h"
@interface XTableViewConfigDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
PROPERTY_WEAK id delegate;;
-(void)config:(NSMutableArray<XCellConfigModel *>*)list tableview:(UITableView *)tableView;
@end
