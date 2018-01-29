//
//  SYShareContentView.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYBaseShowMsgView.h"
#import "SYShareOption.h"
@interface SYShareContentView : SYBaseShowMsgView
+(SYShareContentView *)showShareView:(SYShareOption *)option showItem:(SYShareContentType)showType doneBlock:(syshareContentBlock)clickBlock;
@end
