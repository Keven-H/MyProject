//
//  HCXThirdLibraryManager.h
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface HCXThirdLibraryManager : XData
+(HCXThirdLibraryManager *)share;
-(void)appStartWithOptions:(NSDictionary*)launchOptions;
-(void)login;
-(void)loginOut;
- (void)registerDeviceToken:(NSData *)deviceToken;
@end
