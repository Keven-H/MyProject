//
//  GlobalMacros.h
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#ifndef GlobalMacros_h
#define GlobalMacros_h

#import "DeviceMacros.h"

/**
 *  日志打印
 */
#define LOG(format, ...) NSLog((@"LOG INFO(f:%s l:%d)" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#ifdef DEBUG
#define XLOG(format, ...) LOG(format, ##__VA_ARGS__)
#else
#define XLOG(format, ...)
#endif

/**
 *  向字典中添加一对key-value
 */
#define DICT_PUT(dict, key, obj) {if(obj)dict[key] = obj;}while(0)

/**
 *  颜色相关
 */
#define RGB_COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGB_COLORA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#endif /* GlobalMacros_h */
