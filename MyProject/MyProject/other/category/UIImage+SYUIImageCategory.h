//
//  UIImage+SYUIImageCategory.h
//  CoustomImage
//
//  Created by YC_L on 16/4/6.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYUIImageCategory)
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
/**
 *  压缩图片质量
 *
 */
+ (UIImage *)ImageReduceImage:(UIImage *)image percent:(float)percent;
/**
 *  压缩到固定大小
 *
 */
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
/**
 *  压缩图片尺寸
 *
 */
+ (UIImage*)ImageCompressSourceImage:(UIImage*)sourceImage toTargetSize:(CGSize)targetSize;

/**
 *  根据目标宽度压缩图片
 *
 */
+ (UIImage *)ImageCompressSourceImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

/**
 *  从指定区域抠图
 *
 */
+ (UIImage *)ImageclipImageFromSourceImage:(UIImage *)sourceImge targetRect:(CGRect)targetRect;

#pragma mark - Blur Image 使用CoreImage模糊图片
/**
 *  模糊图片
 *
 */
+ (UIImage *)ImageBlurSourceImage:(UIImage *)sourceImage;

#pragma mark - Blur Image 使用了 Accelerate 框架的内容来模糊图片 比CoreImage效果美观一些

- (UIImage *)blurImage;
/**
 *  模糊图片
 *
 */
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;

/**
 *  模糊图片
 *
 *  @param radius 模糊程度 数值越大 模糊程度越大
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blurImageWithRadius:(CGFloat)radius;

/**
 *  局部模糊
 *
 *  @param frame 模糊的区域
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blurImageAtFrame:(CGRect)frame;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;


+ (UIImage*)scalImageWith:(UIImage*)scalImage size:(CGFloat)size;

+ (CGSize)sizeOfAsset:(ALAsset*) asset;

+(void)saveImageToAblm:(NSData *)imageData;
+(void)saveImageToAblm:(UIImage *)image result:(void (^)(BOOL success))resultBlock;
+(void)saveImageToAblm:(UIImage *)image location:(CLLocation *)location result:(void (^)(BOOL success))resultBlock;

+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue;

+(UIImage *)getImageFromView:(UIView *)view;
+(UIImage*)convertViewToImage:(UIView*)v;
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image;
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
+(UIImage *)addImageWithscale:(UIImage *)image1 toimage:(UIImage *)image2 scale:(float)scale;
+(UIImage *)addImageDefault:(UIImage *)image1 toImage:(UIImage *)image2;

+(UIImage *)resetImageScale:(UIImage *)image scale:(CGFloat)scale;
@end
