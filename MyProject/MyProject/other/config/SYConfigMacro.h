//
//  SYConfigMacro.h
//  myFrameworkDemo
//
//  Created by liyunqi on 28/03/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#ifndef SYConfigMacro_h
#define SYConfigMacro_h


#define UIFontWithSize(fontsize) [UIFont fontWithName:@"LaoSangamMN" size:fontsize]
#define UIFontWithBoldSize(size) [UIFont boldSystemFontOfSize:(size)]

//property
#define	PROPERTY_ASSIGN @property (nonatomic, assign)
#define	PROPERTY_ASSIGN_READONLY @property (nonatomic, assign, readonly)
#define	PROPERTY_COPY @property (nonatomic, copy)

#ifndef PROPERTY_STRONG
#if __has_feature(objc_arc)
#define PROPERTY_STRONG @property(strong, nonatomic)
#else
#define PROPERTY_STRONG @property(retain, nonatomic)
#endif
#endif

#ifndef PROPERTY_STRONG_READONLY
#if __has_feature(objc_arc)
#define PROPERTY_STRONG_READONLY @property(strong, nonatomic, readonly)
#else
#define PROPERTY_STRONG_READONLY @property(retain, nonatomic, readonly)
#endif
#endif

#ifndef PROPERTY_WEAK
#if __has_feature(objc_arc_weak)
#define PROPERTY_WEAK @property(weak, nonatomic)
#elif __has_feature(objc_arc)
#define PROPERTY_WEAK @property(unsafe_unretained, nonatomic)
#else
#define PROPERTY_WEAK @property(assign, nonatomic)
#endif
#endif

#ifndef PROPERTY_WEAK_READONLY
#if __has_feature(objc_arc_weak)
#define PROPERTY_WEAK_READONLY @property(weak, nonatomic, readonly)
#elif __has_feature(objc_arc)
#define PROPERTY_WEAK_READONLY @property(unsafe_unretained, nonatomic, readonly)
#else
#define PROPERTY_WEAK_READONLY @property(assign, nonatomic, readonly)
#endif
#endif

#define FNWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define SINGLE_LINE_HEIGHT           0.5f

#define StringNullConvert(str) (SYStringisEmpty(str) ? @"" : str)
#define NSStringFromInt(i) [NSString stringWithFormat:@"%zi", i]
#define NSStringFromObject(obj) [NSString stringWithFormat:@"%@", obj]
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

#define RandomColor XMGColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:255/255.0]
#define FNColorAlpa(r,g,b,A) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:A]
#define FNColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:255/255.0]
#define DICT_PUT(dict, key, obj) {if(obj)dict[key] = obj;}

#define     IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)


#define K_RATE_X(kFloat)   ((kFloat)*(SCREEN_WIDTH/375.0f))//
//#define K_RATE_F(kFloat)   ((kFloat) * ((DEVICE_IS_IPAD ? 1 : 1)))//2.1
#endif /* SYConfigMacro_h */
