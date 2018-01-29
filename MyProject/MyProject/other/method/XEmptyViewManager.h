//
//  XEmptyViewManager.h
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface XEmptyViewManager : XData

+(instancetype)share;


-(void)postRequestWithRequestParams:(NSDictionary *) postParams controller:(UIViewController *)controller className:(Class) className responseblock:(SYResponseBlock) responseblock;

-(void)resultRequest:(UIViewController *)controller response:(SYResponse *) response;
@end
