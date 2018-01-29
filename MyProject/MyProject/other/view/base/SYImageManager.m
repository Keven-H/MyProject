//
//  SYImageManager.m
//  yun-image-demo
//
//  Created by liyunqi on 16/3/25.
//  Copyright © 2016年 liyunqi. All rights reserved.
//

#import "SYImageManager.h"
#import "SYOSSManager.h"
#define SYImageManager_quality 0.85
#define SYImageManager_quality_low 0.3
@interface SYImageManager()
{
    NSMutableDictionary *optionDic;
}
@end
@implementation SYImageManager
+(id)share
{
    static dispatch_once_t onceToken;
    static SYImageManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[SYImageManager alloc]init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        optionDic=[[NSMutableDictionary alloc]init];
    }
    return self;
}
-(NSString *)urlPathWithSYimage:(SYImage *)image
{
    if (!SYStringisEmpty(image.url)) {
        return image.url;
    }
    return image.thumbUrl;
}
-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image
{
    return [self urlPathByUrl:image qualityType:ImageManager_quality_default];
}
-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image;
{
    return [self urlPathBySYImage:image size:CGSizeMake(image.width, image.height) qualityType:ImageManager_quality_default];
}
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size
{
    return [self urlPathBySYImage:image size:size qualityType:ImageManager_quality_default];
}

-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size
{
    return [self urlPathByUrl:image size:size qualityType:ImageManager_quality_default];
}

-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image quality:(float)quality
{
    return [self urlPathByUrl:image size:CGSizeZero quality:quality qualityType:ImageManager_quality_set];
}
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size quality:(float)quality
{
    return  [self urlPathByUrl:image size:size quality:quality qualityType:ImageManager_quality_set];
}

-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image quality:(float)quality
{
    return [self urlPathByUrl:[self urlPathWithSYimage:image] size:CGSizeMake(image.width, image.height) quality:quality qualityType:ImageManager_quality_set];
}
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size quality:(float)quality
{
     return [self urlPathByUrl:[self urlPathWithSYimage:image] size:size quality:quality qualityType:ImageManager_quality_set];
}
-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image qualityType:(ImageManager_quality)quality
{
    return [self urlPathByUrl:image size:CGSizeZero quality:SYImageManager_quality qualityType:quality];
}
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size qualityType:(ImageManager_quality)quality
{
    return [self urlPathByUrl:image size:size quality:SYImageManager_quality qualityType:quality];
}
//
-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image qualityType:(ImageManager_quality)quality
{
    return [self urlPathByUrl:[self urlPathWithSYimage:image] size:CGSizeMake(image.width, image.height) quality:SYImageManager_quality qualityType:quality];
}
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size qualityType:(ImageManager_quality)quality
{
    return [self urlPathByUrl:[self urlPathWithSYimage:image] size:size quality:SYImageManager_quality qualityType:quality];
}
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size quality:(float)quality qualityType:(ImageManager_quality)qualityType
{
    if (qualityType==ImageManager_quality_set) {
        return [self imageUrl:image size:size quality:quality];
    }
    if (qualityType==ImageManager_quality_default) {
        return [self imageUrl:image size:size quality:SYImageManager_quality];
    }
    if (qualityType==ImageManager_quality_hight) {
        return [self imageUrl:image size:size quality:1];
    }
    if (qualityType==ImageManager_quality_low) {
        return [self imageUrl:image size:size quality:SYImageManager_quality_low];
    }
    return image;
}
-(BOOL)isThisOss:(NSString *)urlPath
{
//    return NO;

    return [[SYOSSManager share]haveThisUrl:urlPath];
}
- (CGSize) fitInSize: (CGSize)thisSize inSize: (CGSize) aSize
{
    CGFloat scale;
    CGSize newsize = thisSize;
    if ((newsize.height&&newsize.height<=aSize.height)||(newsize.width&&newsize.width<=aSize.width)) {
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
        return newsize;
    }else
    {
        return   [[SYImageManager share]fitSize:thisSize inSize:aSize];
    }
}
- (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize
{
    CGFloat scale;
    CGSize newsize = thisSize;
    
    if (newsize.height && (newsize.height > aSize.height))
    {
        scale = aSize.height / newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }else if (newsize.width && (newsize.width >= aSize.width))
    {
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    if (newsize.width>aSize.width||newsize.height>aSize.height) {
        return [self fitSize:newsize inSize:aSize];
    }
    return newsize;
}
-(ImageAssetStyle)imageStyle:(NSString *)url
{
    if ([[url lowercaseString] hasSuffix:@".gif"]) {
        return ImageAsset_gif;
    }
    return ImageAsset_jpg;
}
//-(ImageAssetStyle)imageSytleWith:(SYBaseImageAsset *)asset
//{
//    if (asset.type!=ImageAsset_none) {
//        return asset.type;
//    }
//    if ([asset.originalImage imageUrlExist]) {
//        return [self imageStyle:asset.originalImage.image.url];
//    }
//    return ImageAsset_none;
//}
-(NSString *)imageUrl:(NSString *)image size:(CGSize)size quality:(float)quality
{
    if (SYStringisEmpty(image)) {
        return @"";
    }
    if ([image rangeOfString:@" "].length>0) {
        image=[image stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([image rangeOfString:@"x-oss-process="].length) {
        return image;
    }

    if (![self isThisOss:image]) {
        return image;
    }
    //http://smallyellowotest.tinydonuts.cn/5135408f78410e2976795a25abe06f11.gif?x-oss-process=image/resize,w_100/format,gif
//    return image;
    ////http://image-demo.oss-cn-hangzhou.aliyuncs.com/example.jpg?x-oss-process=image/resize,w_100,h_100/quality,Q_80/auto-orient,0
    if ([self imageStyle:image]==ImageAsset_jpg||[self imageStyle:image]==ImageAsset_none) {
        if (size.height<=0||size.width<=0) {
//            return [NSString stringWithFormat:@"%@%@%dQ_2o",image,@"@",(int)(quality*100)];
            return image;
        }
        if (size.height>4096||size.width>4096) {
            size=[self fitSize:size inSize:CGSizeMake(4096, 4096)];
        }
        NSString *plac=@"?";
        if ([image isContain:@"?"]) {
            plac=@"&";
        }
        return [NSString stringWithFormat:@"%@%@x-oss-process=image/resize,w_%@,h_%@/quality,Q_%@/auto-orient,0",image,plac,NSStringFromInt((int)size.width),NSStringFromInt((int)size.height),NSStringFromInt((int)(quality*100))];


//        return [NSString stringWithFormat:@"%@%@%dw_%dh_%dQ_2o",image,@"@",(int)size.width,(int)size.height,(int)(quality*100)];
    }else
    {
        if (size.height<=0||size.width<=0) {
            return image;
        }
        if (size.height>4096||size.width>4096) {
            size=[self fitSize:size inSize:CGSizeMake(4096, 4096)];
        }
        
        NSString *plac=@"?";
        if ([image isContain:@"?"]) {
            plac=@"&";
        }
        return [NSString stringWithFormat:@"%@%@x-oss-process=image/resize,w_%d,h_%d/format,gif",image,plac,(int)size.width,(int)size.height];
    }
}


//down
-(void)downLoadImageWithPath:(NSString *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock autoSave:(BOOL)save
{
    NSURL *urlP=[NSURL URLWithString:url];
//    NSLog(@"cccddd%@",url);
    if ([[SDWebImageManager sharedManager] cachedImageExistsForURL:urlP]) {
        UIImage *image=nil;
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:urlP];
        image= [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:key];
        if (image==nil) {
            image=[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];

        }
        completedBlock(image,nil,nil,YES);
        return;
    }
    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:urlP options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if(progressBlock)
            progressBlock(receivedSize,expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (save&&finished&&image) {
            [[SDWebImageManager sharedManager].imageCache storeImageDataToDisk:data forKey:urlP.absoluteString];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completedBlock(image,data,error,finished);
        }) ;
        
    }];
//    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:url] options:save?SDWebImageDownloaderUseNSURLCache:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        progressBlock(receivedSize,expectedSize);
//    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        completedBlock(image,data,error,finished);
//    }];
}
-(void)downLoadImageAutoResetWithPath:(NSString *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock autoSave:(BOOL)save
{
    NSURL *urlP=[NSURL URLWithString:url];
    [self cancelUrl:url];
    //    NSLog(@"cccddd%@",url);
    if ([[SDWebImageManager sharedManager] cachedImageExistsForURL:urlP]) {
        UIImage *image=nil;
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:urlP];
        image= [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:key];
        if (image==nil) {
            image=[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
            
        }
        completedBlock(image,nil,nil,YES);
        return;
    }
   id <SDWebImageOperation> operation= [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:urlP options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if(progressBlock)
            progressBlock(receivedSize,expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (save&&finished&&image) {
            [[SDWebImageManager sharedManager]saveImageToCache:image forURL:urlP];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completedBlock(image,data,error,finished);
            [self cancelUrl:url];
        }) ;
        
    }];
    [self addOperation:operation url:url];
}
-(void)cancelUrl:(NSString *)url
{
    if (SYStringisEmpty(url)&&[optionDic objectForKey:url]) {
        return;
    }
    id <SDWebImageOperation> operation=[optionDic objectForKey:url];
    if ([operation conformsToProtocol:@protocol(SDWebImageOperation)]) {
        [operation cancel];
    }
    [optionDic removeObjectForKey:url];
}
-(void)addOperation:(id <SDWebImageOperation>)operation url:(NSString *)url
{
    if (SYStringisEmpty(url)&&operation) {
        return;
    }
    [optionDic setObject:operation forKey:url];
}
-(void)clearImageMemory
{
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
