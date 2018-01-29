//
//  HCXShareManager.m
//  EatEquity
//
//  Created by liyunqi on 10/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXShareManager.h"
#import "SYShareActivityList.h"
#import "SYShareContentView.h"
@implementation HCXShareManager

-(void)openWeChat
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]])
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"wechat://"]];
    }
}
-(void)openSina
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]])
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sinaweibo://"]];
    }

}
-(void)shareToOtherWithShareModel:(SYShareModel *)shareModel itemType:(SYShareContenTtem)itemType
{
    if (shareModel.type==SYShareType_none) {
        if (shareModel.image||shareModel.imageData) {
            [super shareToOtherWithShareModel:shareModel itemType:itemType];
        }else if(SYStringisEmpty(shareModel.img))
        {
            shareModel.image=ImageNamed(@"weChatShareIcon");
            [super shareToOtherWithShareModel:shareModel itemType:itemType];
        }else
        {
            [[UIApplication sharedApplication].keyWindow showActivity];
            [[SYImageManager share]downLoadImageWithPath:shareModel.img progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                [[UIApplication sharedApplication].keyWindow hidenActivity];
                if (finished&&image) {
                    shareModel.image=image;
                    [super shareToOtherWithShareModel:shareModel itemType:itemType];
                }else
                {
                    shareModel.image=ImageNamed(@"weChatShareIcon");
                     [super shareToOtherWithShareModel:shareModel itemType:itemType];
                }
            } autoSave:YES];
        }
    }else
    {
        if (shareModel.image) {
             [super shareToOtherWithShareModel:shareModel itemType:itemType];
        }else if (!SYStringisEmpty(shareModel.img))
        {
            [[UIApplication sharedApplication].keyWindow showActivity];
            [[SYImageManager share]downLoadImageWithPath:shareModel.img progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                [[UIApplication sharedApplication].keyWindow hidenActivity];
                if (finished&&image) {
                    shareModel.image=image;
                    [super shareToOtherWithShareModel:shareModel itemType:itemType];
                }else
                {
                     [[UIApplication sharedApplication].keyWindow showMessage:@"图片下载失败"];
                }
            } autoSave:YES];
        }else
        {
            [[UIApplication sharedApplication].keyWindow showMessage:@"图片为空"];
        }
    }
}
-(SYShareActivityList *)createShareActivityList:(NSString *)name items:(SYShareContenTtem)item
{
    SYShareActivityList *list=[[SYShareActivityList alloc]init];
    list.title=name;
    list.contentItem=item;
    return list;
}
-(void)resetShareOption:(SYShareOption *)option
{
    [super resetShareOption:option];
}
//-(void)shareToOther:(SYShareOption *)option  shareItem:(SYShareContenTtem)itemType  block:(shareManagerBlock)doneBlock
//{
//
//    if (![self WXAppInstalled]&&(itemType==SYShareContenTtem_wechart||itemType==SYShareContenTtem_timeLine||itemType==SYShareContenTtem_wechartPhoto||itemType==SYShareContenTtem_timeLinePhoto)) {
//          [[[UIApplication sharedApplication]keyWindow ]showMessage:@"未安装微信 "];
//         doneBlock(itemType,option.contentType,NO);
//        return;
//    }
//
//
//    if (option.contentType==SYShareContentType_wantEat) {
//        if (![option.model isKindOfClass:[HCXEatModel class]]) {
//            [[[UIApplication sharedApplication]keyWindow ]showMessage:@"eat model 错误 "];
//            doneBlock(itemType,option.contentType,NO);
//            return;
//        }
//        [self shareEatToOhter:(HCXEatModel *)option.model shareItem:itemType sourceType:option.contentType block:^(SYShareContenTtem itemType, SYShareContentType sourceType, BOOL success) {
//            doneBlock(itemType,sourceType,success);
//        }];
//    }else
//    {
//        return[super shareToOther:option shareItem:itemType block:doneBlock];
//    }
//}
//+(void)shareEatWhat:(HCXEatModel *)model
//{
//    SYShareOption *option=[[SYShareOption alloc]  init];
//    option.model=model;
//
//    SYShareActivityList *activitylist=[[HCXShareManager share] createShareActivityList:@"分享操作" items:SYShareContenTtem_timeLinePhoto|SYShareContenTtem_wechartPhoto];
//    [option.activitys addObject:activitylist];
//    [SYShareContentView showShareView:option showItem:SYShareContentType_wantEat doneBlock:^BOOL(SYShareContenTtem itemType) {
//        return YES;
//    }];
//}


//-(void)shareEatToOhter:(HCXEatModel *)eatModel shareItem:(SYShareContenTtem)itemType  sourceType:(SYShareContentType)sourceType block:(shareManagerBlock)doneBlock
//{
//    [[SYImageManager share]downLoadImageWithPath:eatModel.showUrl?eatModel.showUrl:eatModel.img.url progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        if (image&&finished) {
//            SYShareModel *model=[[SYShareModel alloc]init];
//            model.title=eatModel.shareTitle;
//            model.content=eatModel.shareContent;
//            model.image=image;
////            model.link=eatModel.img.url;
//           [self shareToOtherWithShareModel:model itemType:itemType];
//            doneBlock(itemType,sourceType,YES);
//        }else
//        {
//            [[[UIApplication sharedApplication]keyWindow ]showMessage:@"没有获取到图片"];
//            doneBlock(itemType,sourceType,NO);
//        }
//    } autoSave:YES];
//}


@end
