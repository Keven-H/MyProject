//
//  XShareManager.m
//  EatEquity
//
//  Created by liyunqi on 10/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "XShareManager.h"
#import "SYShareActivityList.h"
#import "HCXShareManager.h"
@implementation XShareManager
+(instancetype)share
{
    static dispatch_once_t onceToken;
    static XShareManager *shareManager=nil;
    dispatch_once(&onceToken, ^{
        shareManager=[[self alloc]init];
    });
    return shareManager;
}

//是否安装微信
-(BOOL)WXAppInstalled
{
    BOOL hasWX=NO;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        hasWX=YES;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]])
    {
        hasWX=YES;
    }
    return hasWX;
}

-(NSMutableArray<SYShareActivityItem *> *)addShareActivityItemWithType:(SYShareContenTtem)type sourceType:(SYShareContentType)sourceType
{
    NSMutableArray *list=[[NSMutableArray alloc]init];
    if (type&SYShareContenTtem_wechart||type&SYShareContenTtem_wechartPhoto) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"微信好友" imagePath:@"sy_share_friend" action:nil sel:nil itemType:type&SYShareContenTtem_wechart?SYShareContenTtem_wechart:SYShareContenTtem_wechartPhoto];
        [list addObject:item];
    }
    if (type&SYShareContenTtem_timeLine||type&SYShareContenTtem_timeLinePhoto) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"朋友圈" imagePath:@"sy_share_tline" action:nil sel:nil itemType:type&SYShareContenTtem_timeLine?SYShareContenTtem_timeLine:SYShareContenTtem_timeLinePhoto];
        [list addObject:item];

    }
    if (type&SYShareContenTtem_sina) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"新浪微博" imagePath:@"sy_share_sina" action:nil sel:nil itemType:SYShareContenTtem_sina];
        [list addObject:item];
    }
    
    if (type&SYShareContenTtem_report) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"举报" imagePath:@"sy_share_report" action:nil sel:nil itemType:SYShareContenTtem_report];
        [list addObject:item];
    }
    if (type&SYShareContenTtem_dele) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"删除" imagePath:@"sy_share_del" action:nil sel:nil itemType:SYShareContenTtem_dele];
        [list addObject:item];
    }
    
    if (type&SYShareContenTtem_qrSave) {
        SYShareActivityItem *item=[[SYShareActivityItem alloc]initWithTitle:@"保存到相册" imagePath:@"sy_share_save" action:nil sel:nil itemType:SYShareContenTtem_qrSave];
        [list addObject:item];
    }
    
    return list;
}
//添加分享itemModel
-(void)addShareActivityItems:(NSMutableArray<SYShareActivityList *>*)activitys sourceType:(SYShareContentType)sourceType
{
    if (!activitys.count) {
        return;
    }
    for (SYShareActivityList *list in activitys) {
        [list.listItems removeAllObjects];
        [list.listItems addObjectsFromArray:[self addShareActivityItemWithType:list.contentItem sourceType:sourceType]];
    }
}
//添加分享item按钮事件
-(void)addShareSel:(SYShareOption *)option action:(id)action sel:(SEL)sel
{
    if (!option.activitys.count) {
        return;
    }
    for (SYShareActivityList *list in option.activitys) {
        for (SYShareActivityItem *item in list.listItems) {
            item.action=action;
            item.sel=sel;
        }
    }
}
//重组分享frame
-(void)addShareFrame:(SYShareOption *)option
{
    if (!option.activitys.count) {
        return;
    }
    UIImage *image=ImageNamed(option.activitys.firstObject.listItems.firstObject.imagePath);
    
    for (SYShareActivityList *list in option.activitys) {
        float xoffet=10;
        NSString *str=@"微信微博新";
        CGSize size=[str sizeWithTextFont:option.activitys.firstObject.font maxWidth:1000];
        float width=MAX(size.width, image.size.width);
        float margin=(SCREEN_WIDTH-width*3)/6;
        list.leftRMargin=margin+xoffet;
    }
    
}

//重组分享数据
-(void)resetShareOption:(SYShareOption *)option
{
    [self addShareActivityItems:option.activitys sourceType:option.contentType];
    [self addShareSel:option action:option sel:@selector(optionClickItem:)];
    [self addShareFrame:option];
}

//根据shareModel分享到其他平台
-(void)shareToOtherWithShareModel:(SYShareModel *)shareModel itemType:(SYShareContenTtem)itemType
{
    
    XData *shareReq=nil;
    @autoreleasepool {
        if (itemType==SYShareContenTtem_sina) {
            shareReq = [XWeiBoImageReq createWeiBoImageReqWithImageData:shareModel.imageData?shareModel.imageData: UIImagePNGRepresentation(shareModel.image) messageContent:shareModel.title];
        }else if(itemType==SYShareContenTtem_wechart||itemType==SYShareContenTtem_timeLine)
        {
            shareReq = [XWeChatLinkReq createLinkReq:shareModel.link tagName:@"" title:shareModel.title description:shareModel.content thumbImageData:shareModel.imageData?shareModel.imageData:UIImageJPEGRepresentation([UIImage compressImage:shareModel.image toMaxFileSize:31*1024], 0.75)  scene:(itemType==SYShareContenTtem_wechart?XWeChatSceneSession:XWeChatSceneTimeLine)];
        }else if (itemType==SYShareContenTtem_wechartPhoto||itemType==SYShareContenTtem_timeLinePhoto)
        {
            NSData *date= shareModel.imageThumbnailData?shareModel.imageThumbnailData:UIImageJPEGRepresentation( [UIImage compressImage:[UIImage generatePhotoThumbnail:shareModel.image] toMaxFileSize:31*1024],0.75);
            
            shareReq=[XWeChatImageReq createWeChatImageData:shareModel.imageData?shareModel.imageData:UIImagePNGRepresentation(shareModel.image)  thumbImageData:date scene:itemType==SYShareContenTtem_wechartPhoto?XWeChatSceneSession:XWeChatSceneTimeLine];
        }
        shareModel.image=nil;
        shareModel.imageThumbnailData=nil;
        shareModel.imageData=nil;
    }
    if (shareReq) {
        XShareDataSource *shareDataSource = (XShareDataSource *)[XShareDataSource createShareData:shareReq callBlock:^(XData *result) {
            NSString *msg=nil;
            BOOL success=YES;
            if ([result isKindOfClass:[XWeiBoResult class]]) {
                msg=((XWeiBoResult *)result).errorInfo;
                if (((XWeiBoResult *)result).resultCode!=XWeiBoResultCodeUserCancel&&((XWeiBoResult *)result).resultCode!=XWeiBoResultCodeSuccess) {
                    success=NO;
                }
            }
            if ([result isKindOfClass:[XWeChatResult class]]) {
                msg=((XWeChatResult *)result).errorInfo;
                if (((XWeChatResult *)result).resultCode!=XWeChatResultCodeSuccess&&((XWeChatResult *)result).resultCode!=XWeChatResultCodeUserCancel) {
                    success=NO;
                }
            }
            if (!success&&msg.length) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication].keyWindow showMessage:msg];
                }) ;
            }
        }];
        [[XResultManager shareResultManager] addTask:shareDataSource];
    }
}
//点击分享view上面的item时做的自动分享
-(void)shareToOther:(SYShareOption *)option  shareItem:(SYShareContenTtem)itemType  block:(shareManagerBlock)doneBlock
{
    [[UIApplication sharedApplication ].keyWindow showMessage:@"操作失败"];
    doneBlock(itemType,option.contentType,NO);
}
@end
