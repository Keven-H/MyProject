//
//  UIImage+SYUIImageCategory.m
//  CoustomImage
//
//  Created by YC_L on 16/4/6.
//  Copyright © 2016年 LiHF. All rights reserved.
//

#import "UIImage+SYUIImageCategory.h"
#import <ImageIO/ImageIO.h>
#import "ALAssetsLibrary+SYSavePhotoAlubm.h"
#import "PHPhotoLibrary+SYSavePhotoAlubm.h"
#import "PHAsset+Utility.h"
@import Accelerate;

@implementation UIImage (SYUIImageCategory)


+(UIImage *)ImageReduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    @autoreleasepool {
        CGFloat compression = 0.7f;
        CGFloat maxCompression = 0.1f;
        NSData *imageData = UIImageJPEGRepresentation(image, compression);
        while ([imageData length] > maxFileSize && compression > maxCompression) {
            compression -= 0.1;
            @autoreleasepool {
                imageData = UIImageJPEGRepresentation(image, compression);
            }
        }
        UIImage *compressedImage = [UIImage imageWithData:imageData];
        return compressedImage;
    }
}

+ (UIImage*)ImageCompressSourceImage:(UIImage*)sourceImage toTargetSize:(CGSize)targetSize
{
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage*)scalImageWith:(UIImage*)scalImage size:(CGFloat)size
{
    CGFloat scalHeight = scalImage.size.height;
    CGFloat scalWidth = scalImage.size.width;
    
    CGFloat wrate = size * 1.0 / scalWidth;
    CGFloat hrate = size * 1.0 / scalWidth;
    if (wrate >= 1.0 || hrate >= 1.0)
        return scalImage;
    
    CGSize scalSize = CGSizeZero;
    CGFloat scal = [UIScreen mainScreen].scale * size * 1.0;
    if (scalImage.size.width > scalImage.size.height) {
        
        scalHeight = scal * scalHeight / scalWidth;
        scalSize = CGSizeMake(scal, scalHeight);
    }
    else {
        scalWidth = scal * scalWidth / scalHeight;
        scalSize = CGSizeMake(scalWidth, scal);
    }

    UIGraphicsBeginImageContextWithOptions(scalSize, YES, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContext(
//                                scalSize); // size 为CGSize类型，即你所需要的图片尺寸
    [scalImage drawInRect:CGRectMake(0, 0, scalSize.width, scalSize.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)ImageCompressSourceImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth
{
    CGSize imageSize = sourceImage.size;
    
    CGFloat width  = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)ImageclipImageFromSourceImage:(UIImage *)sourceImge targetRect:(CGRect)targetRect
{
    
    CGImageRef imageRef    = sourceImge.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, targetRect);
    UIImage   *subImage    = [UIImage imageWithCGImage:subImageRef];
    if(subImageRef)
        CGImageRelease(subImageRef);
    return subImage;
}

+ (UIImage *)ImageBlurSourceImage:(UIImage *)sourceImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image     = [[CIImage alloc] initWithImage:sourceImage];
    CIFilter *filter   = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage     *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    if(outImage)
        CGImageRelease(outImage);
    return blurImage;
}

- (UIImage *)blurImage {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}

- (UIImage *)blurImageWithRadius:(CGFloat)radius {
    
    return [self applyBlurWithRadius:radius
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}

- (UIImage *)blurImageWithMask:(UIImage *)maskImage {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:maskImage];
}

- (UIImage *)blurImageAtFrame:(CGRect)frame {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil
                             atFrame:frame];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame
{
    UIImage *blurredFrame = \
    [[self croppedImageAtFrame:frame] applyBlurWithRadius:blurRadius
                                                tintColor:tintColor
                                    saturationDeltaFactor:saturationDeltaFactor
                                                maskImage:maskImage];
    
    return [self addImageToImage:blurredFrame atRect:frame];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    
    if (!self.CGImage) {
        
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    
    if (maskImage && !maskImage.CGImage) {
        
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect   imageRect   = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur             = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            
            if (hasBlur) {
                
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
                
            } else {
                
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        
        if (!effectImageBuffersAreSwapped) {
            
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped) {
            
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        
        CGContextSaveGState(outputContext);
        
        if (maskImage) {
            
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

- (UIImage *)addImageToImage:(UIImage *)img atRect:(CGRect)cropRect {
    
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [self drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)croppedImageAtFrame:(CGRect)frame {
    
    frame = CGRectMake(frame.origin.x * self.scale,
                       frame.origin.y * self.scale,
                       frame.size.width * self.scale,
                       frame.size.height * self.scale);
    
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef    = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage   *newImage       = [UIImage imageWithCGImage:newImageRef scale:[self scale] orientation:[self imageOrientation]];
    CGImageRelease(newImageRef);
    return newImage;
}



+(CGSize)sizeOfImageWithData:(NSData*) data
{
    CGSize imageSize = CGSizeZero;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef) data, NULL);
    if (source)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCGImageSourceShouldCache];
        NSDictionary *properties = (__bridge_transfer NSDictionary*) CGImageSourceCopyPropertiesAtIndex(source, 0, (__bridge CFDictionaryRef) options);
        if (properties)
        {
            NSNumber *width = [properties objectForKey:(NSString *)kCGImagePropertyPixelWidth];
            NSNumber *height = [properties objectForKey:(NSString *)kCGImagePropertyPixelHeight];
            if ((width != nil) && (height != nil))
                imageSize = CGSizeMake(width.floatValue, height.floatValue);
        }
        CFRelease(source);
    }
    return imageSize;
}
+ (CGSize)sizeOfAssetRepresentation:(ALAssetRepresentation*) assetRepresentation
{

    // It may be more efficient to read the [[[assetRepresentation] metadata] objectForKey:@"PixelWidth"] integerValue] and corresponding height instead.
    // Read all the bytes for the image into NSData.
    NSInteger widith=[[[assetRepresentation metadata]objectForKey:@"PixelWidth"]integerValue];
    NSInteger heigth=[[[assetRepresentation metadata]objectForKey:@"PixelHeight"]integerValue];
    return CGSizeMake(widith, heigth);
//    long long imageDataSize = [assetRepresentation size];
//    uint8_t* imageDataBytes = malloc(imageDataSize);
//    [assetRepresentation getBytes:imageDataBytes fromOffset:0 length:imageDataSize error:nil];
//    NSData *data = [NSData dataWithBytesNoCopy:imageDataBytes length:imageDataSize freeWhenDone:YES];
//    return [self sizeOfImageWithData:data];
}
+ (CGSize)sizeOfAsset:(ALAsset*) asset
{
    if (asset==nil) {
        return CGSizeZero;
    }
    return [self sizeOfAssetRepresentation:[asset defaultRepresentation]];
}

+(void)saveImageToAblm:(UIImage *)image location:(CLLocation *)location result:(void (^)(BOOL success))resultBlock
{
    if (image==nil) {
        if (resultBlock) {
             resultBlock(NO);
        }
        return;
    }
    NSString *name=@"小黄圈";
    if (usePhotoKit) {
        [PHPhotoLibrary saveImageToAlbum:image album:name result:^(BOOL success,PHAsset *asset) {
            if (location&&asset) {
                [asset updateLocation:location creationDate:[NSDate date] completionBlock:^(BOOL success) {
                    if (resultBlock) {
                        resultBlock(YES);
                    }
                }];
            }else
            {
                if (resultBlock) {
                    resultBlock(success);
                }
            }
        }];
    }else
    {
        ALAssetsLibrary *library=[[ALAssetsLibrary alloc]init];
        [library saveImgWithData:UIImageJPEGRepresentation(image, 0.95) toAlbum:name withCompletionBlock:^(NSURL *assetUrl, NSError *error) {
            if (resultBlock) {
                resultBlock(error?NO:YES);
            }
        }];
    }

}
+(void)saveImageToAblm:(UIImage *)image result:(void (^)(BOOL success))resultBlock
{
    [self saveImageToAblm:image location:nil result:resultBlock];
}

+(void)saveImageToAblm:(NSData *)imageData
{
    if (!imageData) {
        return;
    }
    [self saveImageToAblm:[UIImage imageWithData:imageData] result:nil];
}



+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue
{
    @autoreleasepool {
        UIImage *image = [self qrCodeImageWithContent:content codeImageSize:size red:red green:green blue:blue];
        //有 logo 则绘制 logo
        if (logo != nil) {
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            [logo drawInRect:logoFrame];
            UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return resultImage;
        }else{
            return image;
        }

    }

}


//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(NSInteger)blue{
    @autoreleasepool {
        UIImage *image = [self qrCodeImageWithContent:content codeImageSize:size];
        int imageWidth = image.size.width;
        int imageHeight = image.size.height;
        size_t bytesPerRow = imageWidth * 4;
        uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
        CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
        //遍历像素, 改变像素点颜色
        int pixelNum = imageWidth * imageHeight;
        uint32_t *pCurPtr = rgbImageBuf;
        for (int i = 0; i<pixelNum; i++, pCurPtr++) {
            if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
                uint8_t* ptr = (uint8_t*)pCurPtr;
                ptr[3] = red*255;
                ptr[2] = green*255;
                ptr[1] = blue*255;
            }else{
                uint8_t* ptr = (uint8_t*)pCurPtr;
                ptr[0] = 0;
            }
        }
        //取出图片
        CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
        CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                            kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                            NULL, true, kCGRenderingIntentDefault);
        CGDataProviderRelease(dataProvider);
        UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpaceRef);
        return resultImage;
    }
}

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
    @autoreleasepool {
        CIImage *image = [self qrCodeImageWithContent:content];
        CGRect integralRect = CGRectIntegral(image.extent);
        CGFloat scale = MIN(size/CGRectGetWidth(integralRect), size/CGRectGetHeight(integralRect));
        
        size_t width = CGRectGetWidth(integralRect)*scale;
        size_t height = CGRectGetHeight(integralRect)*scale;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
        CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
        CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
        
        CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
        CGContextRelease(bitmapRef);
        CGImageRelease(bitmapImage);
        return [UIImage imageWithCGImage:scaledImage];
    }

}


//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *image = qrFilter.outputImage;
    return image;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}


+(UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(UIImage*)convertViewToImage:(UIView*)v
{
    if (v==nil) {
        NSLog(@"view转图片错误 view为空");
        return nil;
    }
//    NSLog(@"view转图image  viewName:%@---size:%@", NSStringFromClass(v.class),NSStringFromCGSize(v.size));
    if (v.width<=0||v.height<=0) {
        NSLog(@"view转图片错误  view.size有小于0--viewName:%@---size:%@", NSStringFromClass(v.class),NSStringFromCGSize(v.size));
        return nil;
    }
    
    @autoreleasepool {
        v.size=CGSizeMake((int)v.width, (int)v.height);
        CGSize s = v.bounds.size;
        UIGraphicsBeginImageContextWithOptions(s,NO, [UIScreen mainScreen].scale);
        [v.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
+(UIImage *)resetImageScale:(UIImage *)image scale:(CGFloat)scale
{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image=nil;
        return imagez;
    }
}
+(UIImage *)addImageDefault:(UIImage *)image1 toImage:(UIImage *)image2
{
    return [UIImage addImageWithscale:image1 toimage:image2 scale:[UIScreen mainScreen].scale];
}
+(UIImage *)addImageWithscale:(UIImage *)image1 toimage:(UIImage *)image2 scale:(float)scale
{
    if (image2 == nil) {
        return image1;
    }
    if (image1==nil) {
        return image2;
    }
    @autoreleasepool {
        CGFloat width =MAX(image1.size.width, image2.size.width);
        CGFloat height = image1.size.height+image2.size.height;
        CGSize offScreenSize = CGSizeMake(width, height);
        
//         UIGraphicsBeginImageContext(offScreenSize);//用这个重绘图片会模糊
        UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, scale);
        
        CGRect rect1 = CGRectMake(0, 0, image1.size.width, image1.size.height);
        [image1 drawInRect:rect1];
        
        CGRect rect2 = CGRectMake(0, image1.size.height, image2.size.width, image2.size.height);
        [image2 drawInRect:rect2];
        
        UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        image1=nil;
        image2=nil;
        return imagez;

    }
}
// 合成图片
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    if (image2 == nil) {
        return image1;
    }
//    CGFloat width =MAX(image1.size.width, image2.size.width);
//    CGFloat height = image1.size.height+image2.size.height;
//    CGSize offScreenSize = CGSizeMake(width, height);
//    
//    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
//    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
//    
//    CGRect rect1 = CGRectMake(0, 0, image1.size.width, image1.size.height);
//    [image1 drawInRect:rect1];
//    
//    CGRect rect2 = CGRectMake(0, image1.size.height, image2.size.width, image2.size.height);
//    [image2 drawInRect:rect2];
//    
//    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return imagez;
    @autoreleasepool {
        CGSize size= CGSizeMake( MAX(image1.size.width, image2.size.width),(int)(image1.size.height+image2.size.height));
        UIGraphicsBeginImageContext(size);
        [image2 drawInRect:CGRectMake(0, image1.size.height, image2.size.width, image2.size.height)];
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultingImage;

    }
}

+ (UIImage *)generatePhotoThumbnail:(UIImage *)image {
    @autoreleasepool {
        // Create a thumbnail version of the image for the event object.
        CGSize size = image.size;
        CGSize croppedSize;
        CGFloat ratio = 150;
        CGFloat offsetX = 0.0;
        CGFloat offsetY = 0.0;
        
        // check the size of the image, we want to make it
        // a square with sides the size of the smallest dimension
        if (size.width > size.height) {
            offsetX = (size.height - size.width) / 2;
            croppedSize = CGSizeMake(size.height, size.height);
        } else {
            offsetY = (size.width - size.height) / 2;
            croppedSize = CGSizeMake(size.width, size.width);
        }
        
        // Crop the image before resize
        CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
        // Done cropping
        
        // Resize the image
        CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
        
        UIGraphicsBeginImageContext(rect.size);
        [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
        UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // Done Resizing
        
        return thumbnail;
    }

}
@end
