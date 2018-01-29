//
//  SYBaseTableViewCell.h
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBaseTableViewCell : UITableViewCell
PROPERTY_STRONG UIImageView *lineImage;
PROPERTY_STRONG UIImageView *baseMarkView;
-(UITableView *)tableView;
- (UIViewController*)viewController;
+(CGFloat)getCellHeight:(id)model;
@end
