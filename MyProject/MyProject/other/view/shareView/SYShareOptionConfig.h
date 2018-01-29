//
//  SYShareOptionConfig.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//
#ifndef SYShareOptionConfig_h
#define SYShareOptionConfig_h


#endif
typedef enum
{
    SYShareContentType_none,//默认
    SYShareContentType_wantEat,//吃啥
    
}SYShareContentType;//分享来源--不同来源显示view不一样

typedef enum
{
    SYShareContenTtem_wechart     =   1 <<  0,//微信好友link
    SYShareContenTtem_timeLine   =   1 <<  1,//微信朋友圈link
    SYShareContenTtem_sina    =   1 <<  2,//新浪 link
    SYShareContenTtem_report =   1 <<  3,//举报
    SYShareContenTtem_dele    =1 << 4 ,//删除
    SYShareContenTtem_qrSave  =1<<5,//保存二维码
    SYShareContenTtem_wechartPhoto     =   1 <<  6,//微信好友图片
    SYShareContenTtem_timeLinePhoto   =   1 <<  7,//微信朋友圈图片
}SYShareContenTtem;

typedef  BOOL(^syshareContentBlock)(SYShareContenTtem itemType);
