//
//  SYOSSManager.h
//  Foodie
//
//  Created by liyunqi on 16/3/29.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYOSSModel.h"
@interface SYOSSManager : NSObject

PROPERTY_STRONG_READONLY SYOSSModel *ossModel;
+(SYOSSManager *)share;

-(BOOL)haveThisUrl:(NSString *)url;
//
//
//- (OSSPutObjectRequest *) asyncUploadObjectToAliYunOSSWithObjectKey:(NSString *) objectKey
//                                                     uploadFilePath:(NSData *) fileData
//                                                        contentType:(NSString *) contentType
//                                                         contentMD5:(NSString *) contentMD5
//                                                      responseblock:(void(^)(SYResponse *response,NSString *originalImageUrl,NSString *objectKey)) responseblock;

@end
