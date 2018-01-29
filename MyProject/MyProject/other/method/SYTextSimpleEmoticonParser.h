//
//  SYTextSimpleEmoticonParser.h
//  Foodie
//
//  Created by liyunqi on 19/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYTextParser.h"
@interface SYTextSimpleEmoticonParser : NSObject<SYTextParser>
@property (copy) NSDictionary *emoticonMapper;
@end
