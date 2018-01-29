//
//  XSubService.h
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface XSubService : XData
+(instancetype)share;

-(void) pushResponse:(NSDictionary *)dic className:(Class) className controller:(UIViewController *)controller responseblock:(SYResponseBlock) responseblock;

-(void) pushResponse:(NSDictionary *)dic className:(Class) className responseblock:(SYResponseBlock) responseblock;


@end
