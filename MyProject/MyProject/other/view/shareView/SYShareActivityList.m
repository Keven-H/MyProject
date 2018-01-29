//
//  SYShareActivityList.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareActivityList.h"

@implementation SYShareActivityList
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemVerticalMargin=26;
        self.listItems=[[NSMutableArray alloc]init];
        self.leftRMargin=0;
        self.topMargin=33;
        self.bottomMargin=30;
        self.spacing=10;
        self.font=UIFontWithSize(12);
        self.color=FNColor(85, 85, 85);
    }
    return self;
}
@end
