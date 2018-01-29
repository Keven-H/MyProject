//
//  HCXLoginManager.h
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface HCXLoginManager : XData
+ (instancetype) shareLoginManager;
+(void)showMainController;
+(void)loginOut;
@end
