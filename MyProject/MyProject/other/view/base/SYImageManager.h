//
//  SYImageManager.h
//  yun-image-demo
//
//  Created by liyunqi on 16/3/25.
//  Copyright © 2016年 liyunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SYImage.h"
#import "SYImageManager.h"
#import <SDWebImageManager.h>
//#import "SYBaseImageAsset.h"
typedef enum
{
    ImageManager_quality_set,//自传参数
    ImageManager_quality_default,//默认值
    ImageManager_quality_hight,//高
    ImageManager_quality_low,//低
    
}ImageManager_quality;
@interface SYImageManager : NSObject
+(nonnull SYImageManager *)share;

-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image;
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size;
-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image;
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size;

//quality
-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image quality:(float)quality;
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size quality:(float)quality;
-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image quality:(float)quality;
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size quality:(float)quality;


-(nonnull NSString *)urlPathByUrl:(nonnull NSString   *)image qualityType:(ImageManager_quality)quality;
-(nonnull NSString *)urlPathByUrl:(nonnull NSString *)image  size:(CGSize)size qualityType:(ImageManager_quality)quality;
-(nonnull NSString *)urlPathBySYimage:(nonnull SYImage   *)image qualityType:(ImageManager_quality)quality;
-(nonnull NSString *)urlPathBySYImage:(nonnull SYImage *)image  size:(CGSize)size qualityType:(ImageManager_quality)quality;

//down
-(void)downLoadImageWithPath:(NSString *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock autoSave:(BOOL)save;

-(void)downLoadImageAutoResetWithPath:(NSString *)url progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock autoSave:(BOOL)save;

- (CGSize) fitInSize: (CGSize)thisSize inSize: (CGSize) aSize;
-(void)clearImageMemory;

//-(ImageAssetStyle)imageSytleWith:(SYBaseImageAsset *)asset;
-(ImageAssetStyle)imageStyle:(NSString *)url;
@end
