//
//  SYBaseTextView.m
//  Foodie
//
//  Created by liyunqi on 14/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYBaseTextView.h"

@implementation SYBaseTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)deleteBackward
{
    if ([SYEmojiVIewObject deleKeyChars:self]) {
        [super deleteBackward];
    }
}
@end
