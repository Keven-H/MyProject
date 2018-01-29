//
//  PHPhotoLibrary+SYSavePhotoAlubm.h
//  Foodie
//
//  Created by liyunqi on 7/8/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHPhotoLibrary (SYSavePhotoAlubm)
+(void)saveImageToAlbum:(UIImage *)image album:(NSString *)album  result:(void (^)(BOOL success,PHAsset *asset))resultBlock;
@end
