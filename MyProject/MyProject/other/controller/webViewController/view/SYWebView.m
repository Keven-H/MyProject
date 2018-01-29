//
//  SYWebView.m
//  Foodie
//
//  Created by liyunqi on 19/05/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SYClientInfo.h"
@interface SYWebView()
PROPERTY_STRONG JSContext *jscontext;
PROPERTY_STRONG NSString *urlStr;
@end
@implementation SYWebView

-(void)didFinishLoad
{
    _jscontext=[self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
     self.jscontext[@"hcxclient"] = self.viewManager;
    
    [self.jscontext evaluateScript:@"function ocClickRbtn (){try{window.client.clickRbtn(); return 1;} catch(e){return 0;} }"];
    [self.jscontext evaluateScript:@"function ocBack (){try{window.client.back(); return 1;} catch(e){return 0;} }"];

    [self performSelector:@selector(upShareContentImg) withObject:nil afterDelay:1];
}
-(void)upShareContentImg
{
    SYShareModel *model=[self shareModel];
    [model downShareImage];
}
-(NSMutableDictionary *)dicwithurl:(NSString *)content
{
    NSArray *list=[content componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    for (NSString *value in list) {
        NSArray *vas=[value componentsSeparatedByString:@"="];
        if (vas.count==2&&!SYStringisEmpty([vas objectAtIndex:0])&&!SYStringisEmpty([vas objectAtIndex:1])) {
            [dic setObject:[vas objectAtIndex:1] forKey:[vas objectAtIndex:0]];
        }
    }
    return dic;
}
-(NSString *)url:(NSString *)urlString
{
    _urlStr=urlString;
    NSMutableDictionary *DefaultParam=[NSMutableDictionary dictionaryWithDictionary:[[SYHttpRequestManager shareHttpRequestManager]addDefaultParam:[NSMutableDictionary new]]];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    DICT_PUT(dic, @"version", [DefaultParam objectForKey:@"version"]);
    DICT_PUT(dic, @"account", [DefaultParam objectForKey:@"account"]);
    DICT_PUT(dic, @"token", [DefaultParam objectForKey:@"token"]);
    
    NSString *url=[NSString stringWithFormat:@"%@",urlString];
    if ([urlString rangeOfString:@"?"].length&&url.length>([urlString rangeOfString:@"?"].length+1)) {
        url=[url substringWithRange:NSMakeRange(0, [url rangeOfString:@"?"].location)];
        NSDictionary *urlQuery=[self dicwithurl:[urlString substringFromIndex:[urlString rangeOfString:@"?"].location+1]];
        if (urlQuery.allKeys.count) {
            [dic addEntriesFromDictionary:urlQuery];
        }
    }
    url=[NSString stringWithFormat:@"%@?",url];
    NSArray *keys=[dic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys) {
        if ([url hasSuffix:@"&"]||[url hasSuffix:@"?"]) {
            url=[url stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]]];
        }else
        {
            url=[url stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,[dic objectForKey:key]]];
        }
    }
    NSLog(@"加载url========%@",url);
    return [url stringByReplacingOccurrencesOfString:@" " withString:@""];

}
-(BOOL)evaluateScript:(NSString *)scrip
{
    if (SYStringisEmpty(scrip)) {
        return NO;
    }
    JSValue *function = [self.jscontext objectForKeyedSubscript:scrip];
    if (function&&!function.isUndefined) {
         [function callWithArguments:nil];
        return YES;
    }
    return NO;
}
-(BOOL)webViewClickBack
{
    JSValue *function=[[self.jscontext objectForKeyedSubscript:@"ocBack"]callWithArguments:nil];
    if (function&&!function.isUndefined) {
        if (function.toInt32==1) {
            return YES;
        }
        return NO;
    }
    return NO;
}
-(BOOL)webViewClickRbtn
{
    JSValue *function=[[self.jscontext objectForKeyedSubscript:@"ocClickRbtn"]callWithArguments:nil];
    if (function&&!function.isUndefined) {
        if (function.toInt32==1) {
            return YES;
        }
        return NO;
    }
    return NO;
}

-(void)loadUrl:(NSString *)url
{
    NSURL* urlContent = [NSURL URLWithString:[self url:url ]];
    NSMutableURLRequest* requeseUrl = [NSMutableURLRequest requestWithURL:urlContent];
    [self loadRequest:requeseUrl];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(SYShareModel *)shareModel
{
    JSValue *shareData = _jscontext[@"shareContent"];
    JSValue *shareDic = [shareData callWithArguments:nil];
    NSString *str=[shareDic toString];
    NSDictionary *dic =[str parseValue];
    if ([dic isKindOfClass:[NSDictionary class]]&&dic.allKeys.count) {
        SYShareModel *model=[SYJSONAdapter modelOfClass:[SYShareModel class] fromJSONDictionary:dic error:nil];
        if (model) {
            if (SYStringisEmpty(model.link)) {
                model.link=self.urlStr;
            }
            return    model;
        }
    }
    return nil;
}
@end
