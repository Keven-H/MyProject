//
//  XShareManager.h
//  EatEquity
//
//  Created by liyunqi on 10/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import "SYShareOption.h"
typedef  void(^shareManagerBlock)(SYShareContenTtem itemType,SYShareContentType sourceType ,BOOL success);
@interface XShareManager : XData

+(instancetype)share;
-(BOOL)WXAppInstalled;
//重组分享数据
-(void)resetShareOption:(SYShareOption *)option;
-(void)shareToOther:(SYShareOption *)option  shareItem:(SYShareContenTtem)itemType  block:(shareManagerBlock)doneBlock;

//发起分享
-(void)shareToOtherWithShareModel:(SYShareModel *)shareModel itemType:(SYShareContenTtem)itemType;

@end
