//
//  SYImage.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYImage.h"

@implementation SYImage

#pragma mark NSCoping
- (instancetype) copyWithZone:(NSZone *)zone
{
    SYImage *image = [super copyWithZone:zone];
    image.ID = [self.ID copy];
    image.width = self.width;
    image.height = self.height;
    image.url = [self.url copy];
    image.thumbUrl = [self.thumbUrl copy];
    image.image = [self.image copy];
    return image;
}
-(void)setImage:(UIImage *)image
{
    _image=image;
    
}
- (BOOL) isEmptyUrl
{
    return self.url.length <= 0 && self.thumbUrl.length <= 0 ? YES : NO;
}

- (BOOL) isNetUrl{
    if ([self.url hasPrefix:@"http"] || [self.thumbUrl hasPrefix:@"http"]) {
        return YES;
    }
    return NO;
}

#pragma mark NSCoding
- (instancetype) initWithCoder:(NSCoder *)coder
{
    if(self = [super initWithCoder:coder])
    {
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
}

@end
