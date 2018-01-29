//
//  PHPhotoLibrary+SYSavePhotoAlubm.m
//  Foodie
//
//  Created by liyunqi on 7/8/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "PHPhotoLibrary+SYSavePhotoAlubm.h"
#import "PHAsset+Utility.h"
@implementation PHPhotoLibrary (SYSavePhotoAlubm)

+(void)saveImageToAlbum:(UIImage *)image album:(NSString *)album result:(void (^)(BOOL success,PHAsset *asset))resultBlock
{
    
    __block NSString *assetLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *changeRequest=[PHAssetChangeRequest creationRequestForAssetFromImage:image];
        assetLocalIdentifier=changeRequest.placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success==NO) {
            //save error
            if (resultBlock) {
                resultBlock(NO,nil);
            }
            return ;
        }
        [self moveAssetToAlubm:assetLocalIdentifier album:album result:resultBlock];
    }];
    
}
+(void)moveAssetToAlubm:(NSString *)assetLocalIdentifier album:(NSString *)album  result:(void (^)(BOOL success,PHAsset *asset))resultBlock
{
    PHAssetCollection* createdAssetCollection=[self createdAssetCollectionWitbAlbum:album];
    if (createdAssetCollection==nil||assetLocalIdentifier==nil) {
        if (resultBlock) {
            resultBlock(NO,nil);
        }
        return;
    }
    __block PHAsset* asset;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        asset=[PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
        PHAssetCollectionChangeRequest *request=[PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
        [request addAssets:@[asset]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success==YES) {
            //保存成功
        }else{
            //保存失败
        }
        if (resultBlock) {
            resultBlock(success,asset);
        }
    }];

}
+(PHAssetCollection* )createdAssetCollectionWitbAlbum:(NSString *)album{
    PHFetchResult* assetCollections=[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection* assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:album]) {
            return assetCollection;
        }
    }
    NSError* error=nil;
    __block NSString* assetCollectionLocalIndentifier=nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetCollectionLocalIndentifier=[PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIndentifier] options:nil].lastObject;
}
@end
