//
//  SYImageView.h
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SYImageManager.h"
typedef enum
{
    SYImageViewPlaceImage_default,
    SYImageViewPlaceImage_waiting,
    PROPERTY_STRONG
    //
    //....
    
}SYImageViewPlaceImage;
@interface SYImageObjView : UIView
@property(nonatomic,strong,nonnull) UIImageView  *imageView;
@property(nonatomic,assign)SYImageViewPlaceImage placeType;
@property(nonatomic,strong,nullable)  UIImage *image;
PROPERTY_ASSIGN ImageAssetStyle assetType;
-(nullable UIImage *)placeImage;

- (void)addTarget:(nullable id)target action:(nullable SEL)action;

- (void)setImageWithPath:(nullable NSString *)urlPath;
- (void)setImageWithPath:(nullable NSString *)urlPath placeholderImage:(nullable UIImage *)placeholder;


- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDWebImageCompletionBlock)completedBlock;

//sd_image
- (void)sd_setImageWithURL:(nullable NSURL *)url ;
- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder ;
- (void)sd_setImageWithURL:(nullable NSURL *)url completed:(nullable SDWebImageCompletionBlock)completedBlock ;



-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size;
-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDWebImageCompletionBlock)completedBlock;

-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size placeholderImage:(nullable UIImage *)placeholder quality:(float)quality completed:(nullable SDWebImageCompletionBlock)completedBlock;


@end
