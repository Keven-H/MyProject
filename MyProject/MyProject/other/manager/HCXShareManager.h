//
//  HCXShareManager.h
//  EatEquity
//
//  Created by liyunqi on 10/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
//#import "HCXEatModel.h"

@interface HCXShareManager : XShareManager
//+(void)shareEatWhat:(HCXEatModel *)model;

-(SYShareActivityList *)createShareActivityList:(NSString *)name items:(SYShareContenTtem)item;

-(void)openWeChat;
-(void)openSina;
@end
