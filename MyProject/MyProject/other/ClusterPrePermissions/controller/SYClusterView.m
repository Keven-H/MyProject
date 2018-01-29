//
//  SYClusterView.m
//  Foodie
//
//  Created by liyunqi on 5/4/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYClusterView.h"
@interface SYClusterView()
{
    
}
@end
@implementation SYClusterView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageView=[[UIImageView alloc]init];
        _imageView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame=self.bounds;
}
@end
