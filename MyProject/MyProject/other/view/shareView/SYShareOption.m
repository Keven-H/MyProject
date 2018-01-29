//
//  SYShareOption.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareOption.h"
#import "SYShareItemsView.h"
@implementation SYShareOption
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showClose=YES;
        self.activitys=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)optionClickItem:(SYShareActivityItem *)activityItem
{
    [self.view clickItem:activityItem.itemType];
}
@end
