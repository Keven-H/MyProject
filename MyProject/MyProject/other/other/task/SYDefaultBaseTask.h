//
//  SYDefaultBaseTask.h
//  Foodie
//
//  Created by liyunqi on 07/12/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@class SYResponse;
@class SYFeedBackModel;
typedef void(^completeBlock)(SYResponse *response, id responseDic);
@interface SYDefaultBaseTask : XLongHttpRequestTask

/**
 *  快速创建问题反馈任务接口
 */
+ (instancetype) createFeedBackTask:(completeBlock) completeBlock modelClass:(Class)modelcalss;

/**
 *  有图片上传完成
 */
-(void) uploadAssetComplete;

/**
 *  有图片上传失败
 */
- (void) uploadAssetFail;

/**
 *  提交问题反馈接口
 */
- (SYFeedBackModel *) getFeedBackModel;


/**
 需要提交的dic

 */
-(NSMutableDictionary *)parDic;


@end
