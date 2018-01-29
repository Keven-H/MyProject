//
//  SYShareActivityItem.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareActivityItem.h"

@implementation SYShareActivityItem
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(id)initWithTitle:(NSString *)title imagePath:(NSString *)imagePath action:(id)action sel:(SEL)sel itemType:(SYShareContenTtem )item;
{
    if (self=[super init]) {
        _autoSel=@selector(onClick);
        _title=title;
        _imagePath=imagePath;
        _action=action;
        _sel=sel;
        _itemType=item;
    }
    return self;
}
-(void)onClick
{
    if (self.action&&[self.action respondsToSelector:self.sel]) {
        [self.action performSelector:self.sel withObject:self afterDelay:0];
    }
}
@end
