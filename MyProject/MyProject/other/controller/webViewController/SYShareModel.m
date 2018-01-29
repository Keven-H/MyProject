//
//  SYShareModel.m
//  Foodie
//
//  Created by liyunqi on 6/1/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareModel.h"

@implementation SYShareModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _type=SYShareType_none;
    }
    return self;
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
}
-(NSString *)urlQuality
{
//    NSString *urlContent=[[SYImageManager share]urlPathByUrl:self.img size:CGSizeMake(200, 200) quality:1];
    return self.img;
}
-(void)downShareImage
{
    if (self&&!SYStringisEmpty(self.img)) {
        [[SYImageManager share]downLoadImageWithPath:[self urlQuality] progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        } autoSave:YES];
    }
}
-(UIImage *)downShareIMG
{
    UIImage *cacheImg=nil;
    if (!SYStringisEmpty(self.img)&&[[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:[self urlQuality]]]) {
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:[self urlQuality]]];
        cacheImg= [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:key];
        if (cacheImg==nil) {
            cacheImg=[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
        }
    }
//    if (cacheImg==nil) {
//        return ImageNamed(@"weChatShareIcon");
//    }
    return cacheImg;
}
-(BOOL)validate
{
    if (self.type==SYShareType_none) {
        if (!SYStringisEmpty(self.link)&&!SYStringisEmpty(self.title)) {
            return YES;
        }
    }else
    {
        if ((!SYStringisEmpty(self.img)||self.image||self.imageData)) {
            return YES;
        }
    }
    return NO;
}
@end
