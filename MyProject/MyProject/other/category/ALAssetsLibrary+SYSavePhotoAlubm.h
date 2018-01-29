//
//  ALAssetsLibrary+SYSavePhotoAlubm.h
//  Foodie
//
//  Created by liyunqi on 7/8/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
typedef void(^SaveImgCompletion)(NSError *error);
typedef void(^DiySaveImgCompletion)(NSURL *assetUrl, NSError *error);

@interface ALAssetsLibrary (SYSavePhotoAlubm)
- (void)saveImg:(UIImage *)image toAlbum:(NSString *)albumName withCompletionBlock:(DiySaveImgCompletion)completionBlock;
- (void)saveImgWithData:(NSData *)imageData toAlbum:(NSString *)albumName withCompletionBlock:(DiySaveImgCompletion)completionBlock;
- (void)addAssetURL:(NSURL *)assetURL toAlbum:(NSString *)albumName withCompletionBlock:(SaveImgCompletion)completionBlock;

@end
