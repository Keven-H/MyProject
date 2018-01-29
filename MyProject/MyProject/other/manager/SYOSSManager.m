//
//  SYOSSManager.m
//  Foodie
//
//  Created by liyunqi on 16/3/29.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYOSSManager.h"


NSString * const AccessKey = @"lIbEPG3B1z6XPy61";
NSString * const SecretKey = @"OcgO34eFyTOB5rfK0CySjqldRIDg0s";
NSString * const endPoint = @"http://oss-cn-beijing.aliyuncs.com";

#if CONFIG == 5//正式
NSString * const bucketName=@"hcx";
NSString * const header_original=@"http://hcx.oss-cn-beijing.aliyuncs.com";
NSString * const header_image=@"http://pic.huichixia.com";

#else
NSString * const bucketName=@"hcx-test";
NSString * const header_original=@"http://hcx-test.oss-cn-beijing.aliyuncs.com";
NSString * const header_image=@"http://pictest.huichixia.com";

#endif

#define SYOSSManager_header_images [[NSArray alloc]initWithObjects:@"http://pic.huichixia.com",@"http://pic.huichixia.com",@"http://hcxpic.tinydonuts.cn",@"http://hcxpictest.tinydonuts.cn",@"http://smallyellow.tinydonuts.cn",@"http://smallyellowotest.tinydonuts.cn", nil]

@interface SYOSSManager()
{

}
PROPERTY_STRONG_READONLY OSSClient * client;
@end

@implementation SYOSSManager
+(SYOSSManager *)share
{
    static dispatch_once_t onceToken;
    static SYOSSManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[SYOSSManager alloc] init];
    });
    return manager;
}
-(BOOL)haveThisUrl:(NSString *)url
{
    if (SYStringisEmpty(url)) {
        return NO;
    }
    for (NSString *path  in SYOSSManager_header_images) {
        if ([url rangeOfString:path].length!=0 ) {
            return YES;
        }
    }
    if (!SYStringisEmpty(self.ossModel.headerImage)&&[url rangeOfString:self.ossModel.headerImage].length!=0 ) {
        return YES;
    }
    return NO;
}
-(id)init
{
    self=[super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
-(void)initDefault
{
    [self initLocationOSS];
    [self loadServerData];
}

-(NSString*)releaseStr
{
    //    return NSStringFromInt(CONFIG);
    return nil;
}

-(void)loadServerData
{
    //    [[SYSubService share]loadOssSettings:[self releaseStr] responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
    //        NSDictionary *oss=[responseDic objectForKey:@"oss"];
    //        if (oss&&[oss isKindOfClass:[NSDictionary class]]&&oss.allKeys) {
    //            SYOSSModel *model=[[SYOSSModel alloc]init];
    //            model.accessKey=[oss objectForKey:@"accessKeyId"];
    //            model.secretKey=[oss objectForKey:@"accessKeySecret"];
    //            model.endPoint=[oss objectForKey:@"endPoint"];
    //            model.bucketName=[oss objectForKey:@"bucketName"];
    //            model.headerOriginal=[oss objectForKey:@"headerOriginal"];
    //            model.headerImage=[oss objectForKey:@"headerImage"];
    //            if ([self canUsed:model]) {
    //                [self saveOSSModel:model];
    //            }
    //        }
    //    }];
}


-(void)initLocationOSS
{
    SYOSSModel *oldModel=[self oldOSSModel];
    if ([self canUsed:oldModel]) {
        _ossModel=oldModel;
    }else
    {
        [self addDefaultValue];
    }

    [self saveOSSModel:_ossModel];
    OSSPlainTextAKSKPairCredentialProvider* credentia = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:_ossModel.accessKey
                                                                                                                         secretKey:_ossModel.secretKey];

    [self initClient:credentia];
}
-(void)initClient:(id<OSSCredentialProvider>)credential
{
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    _client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
}


-(void)addDefaultValue
{
    SYOSSModel *model=[[SYOSSModel alloc]init];
    model.accessKey=AccessKey;
    model.secretKey=SecretKey;
    model.endPoint=endPoint;
    model.bucketName=bucketName;
    model.headerOriginal=header_original;
    model.headerImage=header_image;
    _ossModel=model;
}
-(BOOL)canUsed:(SYOSSModel *)model
{
    if (!SYStringisEmpty(model.accessKey)&&!SYStringisEmpty(model.secretKey)&&!SYStringisEmpty(model.endPoint)&&!SYStringisEmpty(model.bucketName)&&!SYStringisEmpty(model.headerOriginal)&&!SYStringisEmpty(model.headerImage)) {
        return YES;
    }
    return NO;
}
-(SYOSSModel *)oldOSSModel
{
    return (SYOSSModel *)[[HCXDateManager shareDataManager ] getModel:[SYOSSModel class]];
}
-(BOOL)saveOSSModel:(SYOSSModel *)model
{
    [[HCXDateManager shareDataManager]saveModel:model];
    return YES;
}


- (OSSPutObjectRequest *) asyncUploadObjectToAliYunOSSWithObjectKey:(NSString *) objectKey
                                                     uploadFilePath:(NSData *) fileData
                                                        contentType:(NSString *) contentType
                                                         contentMD5:(NSString *) contentMD5
                                                      responseblock:(void(^)(SYResponse *response,NSString *originalImageUrl,NSString *objectKey)) responseblock
{
    NSString *path=[NSString stringWithFormat:@"app/%@",objectKey];
    SYOSSModel *ossModel = _ossModel;
    OSSPutObjectRequest *putRequest = [[OSSPutObjectRequest alloc] init];
    putRequest.bucketName = ossModel.bucketName;
    putRequest.objectKey = path;
    putRequest.uploadingData = fileData;
    putRequest.contentType = contentType;
    putRequest.contentMd5 = contentMD5;
    OSSTask *putTask = [[self client] putObject:putRequest];
    [putTask continueWithBlock:^id(OSSTask *task) {
        SYResponse *response = nil;
        NSString *originalImageUrl = nil;
        if(!task.error){
            response = [SYResponse success];
            originalImageUrl = [NSString stringWithFormat:@"%@/%@",ossModel.headerImage,path];
        }
        else{
            response = [SYResponse otherGeneralFail];
        }
        if(responseblock)
            responseblock(response,originalImageUrl,objectKey);
        return nil;
    }];
    return putRequest;
}

@end

