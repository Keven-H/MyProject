//
//  SYBaseYYtextView.m
//  Foodie
//
//  Created by liyunqi on 17/01/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYBaseYYtextView.h"

@implementation SYBaseYYtextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setFrame:(CGRect)frame
{
    if (frame.size.width<=0||frame.size.height<=0) {
        [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, 1, 1)];
    }else
    {
        [super setFrame:frame];
    }
}
@end
