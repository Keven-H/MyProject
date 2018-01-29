//
//  SYImageView.m
//  Foodie
//
//  Created by liyunqi on 16/3/21.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYImageObjView.h"
@interface SYImageObjView()
PROPERTY_STRONG UITapGestureRecognizer *tap;

PROPERTY_STRONG UILabel *labelGif;
@end
@implementation SYImageObjView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews
{
    self.placeType=SYImageViewPlaceImage_waiting;
    _imageView=[[UIImageView alloc]init];
    self.assetType=ImageAsset_jpg;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    self.backgroundColor=[UIColor clearColor];
    [self addSubview:_imageView];
    
    
    _labelGif=[UIView SYCreateDefalutLabelFont:UIFontWithSize(10) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter] ;
    _labelGif.text=@"Gif";
    [self.imageView addSubview:_labelGif];
    _labelGif.frame=CGRectMake(0, 0, 22, 12);
    _labelGif.backgroundColor=XColorAlpa(0, 0, 0, 0.85);
    self.labelGif.hidden=YES;
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (![self existingObserverObject:self property:@keypath(self.imageView.image)]) {
        FNWeak(self, weakSelf);
        [self observeProperty:@keypath(self.imageView.image) withBlock:^(id self, id oldValue, id newValue) {
            weakSelf.labelGif.hidden=!(weakSelf.assetType==ImageAsset_gif&&!weakSelf.imageView.image.images.count);
            [self resetContentModel];
        }];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame=CGRectMake(0, 0, self.width, self.height);
    self.labelGif.frame=CGRectMake(self.width-self.labelGif.width, 0, self.labelGif.width, self.labelGif.height);
    [self resetContentModel];
}
-(BOOL)canShowImgDetail
{
    if (self.imageView.image&&[self.imageView.image isEqual:[self placeImage]]) {
        return NO;
    }
    if (self.assetType==ImageAsset_none||self.assetType==ImageAsset_jpg||self.assetType==ImageAsset_gif) {
        return YES;
    }
    return NO;
}
-(void)resetContentModel
{
    if (![self canShowImgDetail]) {
        self.imageView.backgroundColor=[UIColor hexStringToColor:@"EDEDED"];
        if (self.imageView.image.size.width<self.imageView.width&&self.imageView.image.size.height<self.imageView.height) {
            self.imageView.contentMode=UIViewContentModeCenter;
        }else
        {
            self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        }
    }else
    {
        self.imageView.backgroundColor=[UIColor clearColor];
        self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    }

}
- (void)addTarget:(id)target action:(SEL)action
{
    if (!self.tap) {
        self.userInteractionEnabled = YES;
        self.tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:self.tap];
    }
    [self.tap addTarget:target action:action];
}
-(void)setImage:(UIImage *)image
{
    self.imageView.image=image;
}
-(void)setContentMode:(UIViewContentMode)contentMode
{
    self.imageView.contentMode=contentMode;
    [super setContentMode:contentMode];
}
-(UIImage *)image
{
    return self.imageView.image;
}
-(UIImage *)placeImage
{
    if (self.placeType==SYImageViewPlaceImage_default) {
        return nil;
    }
    if (self.placeType==SYImageViewPlaceImage_waiting) {
        return ImageNamed(@"defaultImg");
    }
    return nil;
}



- (void)sd_setImageWithURL:(NSURL *)url {
    self.assetType=ImageAsset_jpg;
    [self sd_setImageWithURL:url placeholderImage:[self placeImage] completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
//    [self.imageView sd_setImageWithURL:url placeholderImage:placeholder?placeholder:[self placeImage] options:0 progress:nil completed:nil];
    self.assetType=ImageAsset_jpg;
    [self sd_setImageWithURL:url placeholderImage:placeholder?placeholder:[self placeImage] completed:nil];
}


- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    self.assetType=ImageAsset_jpg;
    [self sd_setImageWithURL:url placeholderImage:[self placeImage]   completed:completedBlock];
}


- (void)setImageWithPath:(NSString *)urlPath
{
    self.assetType=ImageAsset_jpg;
    [self setImageWithPath:urlPath placeholderImage:[self placeImage]];
}
- (void)setImageWithPath:(NSString *)urlPath placeholderImage:(UIImage *)placeholder
{
    self.assetType=ImageAsset_jpg;
    [self sd_setImageWithURL:[NSURL URLWithString:urlPath] placeholderImage:placeholder];
}


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock {
//    FNWeak(self,weakSelf);
    self.labelGif.hidden=YES;
//    if (![self canShowImgDetail]) {
//        self.imageView.backgroundColor=[UIColor hexStringToColor:@"EDEDED"];
//        self.image=ImageNamed(@"synew_video");
//    }else
//    {
        [self.imageView sd_setImageWithURL:url placeholderImage:placeholder?placeholder:[self placeImage] options:0 progress:nil completed:completedBlock];
//    }
//     [self resetContentModel];
}




//syimage

-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size
{
    [self setImageWithSYImage:image size:size placeholderImage:[self placeImage] completed:nil];
}
-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDWebImageCompletionBlock)completedBlock
{
    [self setImageWithSYImage:image size:size placeholderImage:placeholder quality:0.85 completed:completedBlock];
}
-(void)setImageWithSYImage:(nullable SYImage *)image  size:(CGSize)size placeholderImage:(nullable UIImage *)placeholder quality:(float)quality completed:(nullable SDWebImageCompletionBlock)completedBlock
{
    self.assetType=image.type;
//    self.assetType=ImageAsset_video;
    NSString *urlpath=[[SYImageManager share]urlPathBySYImage:image size:size quality:quality];
    [self sd_setImageWithURL:[NSURL URLWithString:urlpath] placeholderImage:placeholder?placeholder:[self placeImage] completed:completedBlock];
}

-(void)dealloc
{
//    [self removeAllObservations];
}

@end
