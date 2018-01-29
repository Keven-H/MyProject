//
//  XPort.h
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>


#ifdef NET_TEST
#if NET_TEST == 1
#define     CONFIG        1  //脚本打包测试
#elif NET_TEST == 2
#define     CONFIG        2  //脚本打包正式测试
#elif NET_TEST == 3
#define     CONFIG        3  //脚本打包仿真环境
#endif
#else
#if DEBUG
#define     CONFIG        4  //联机调试
#else
#define     CONFIG        5  //appStore
#endif
#endif

#if CONFIG == 1//自动打包--测试
#define NET_HEADER_ADRESS @"http://test-api.huichixia.com/"
#define HCXRegist  @"http://web-testfiles.tinydonuts.cn/"
#define HCXLink @"http://test-inline.huichixia.com/"
#define RongAppKey @"vnroth0kv4xqo"
#define RongAppKeFuID @"KEFU151505713423169"

#elif CONFIG == 2//自动打包--正式
#define NET_HEADER_ADRESS @"http://api.huichixia.com/"
#define HCXRegist  @"http://web-appfiles.tinydonuts.cn/"
#define HCXLink @"http://inline.huichixia.com/"
#define RongAppKey @"m7ua80gbmw5lm"
#define RongAppKeFuID @"KEFU151632856134397"

#elif CONFIG == 3//仿真
#define NET_HEADER_ADRESS @"http://fz-api.huichixia.com/"
#define HCXRegist  @"http://web-fzfiles.tinydonuts.cn/"
#define HCXLink @"http://fz-inline.huichixia.com/"
#define RongAppKey @"vnroth0kv4xqo"
#define RongAppKeFuID @"KEFU151505713423169"

#elif CONFIG == 4//连接调试

//测试
#define NET_HEADER_ADRESS @"http://test-api.huichixia.com/"
#define HCXRegist  @"http://web-testfiles.tinydonuts.cn/"
#define HCXLink @"http://test-inline.huichixia.com/"
#define RongAppKey @"vnroth0kv4xqo"
#define RongAppKeFuID @"KEFU151505713423169"

//仿真
//#define NET_HEADER_ADRESS @"http://fz-api.huichixia.com/"
//#define HCXRegist  @"http://web-fzfiles.tinydonuts.cn/"
//#define HCXLink @"http://fz-inline.huichixia.com/"
//#define RongAppKey @"vnroth0kv4xqo"
//#define RongAppKeFuID @"KEFU151505713423169"

//正式
//#define NET_HEADER_ADRESS @"http://api.huichixia.com/"
//#define HCXRegist  @"http://web-appfiles.tinydonuts.cn/"
//#define HCXLink @"http://inline.huichixia.com/"
//#define RongAppKey @"m7ua80gbmw5lm"
//#define RongAppKeFuID @"KEFU151632856134397"

#elif CONFIG == 5//appStore

#define NET_HEADER_ADRESS @"https://api.huichixia.com/"
#define HCXRegist  @"http://web-appfiles.tinydonuts.cn/"
#define HCXLink @"http://inline.huichixia.com/"
#define RongAppKey @"m7ua80gbmw5lm"
#define RongAppKeFuID @"KEFU151632856134397"
#endif

