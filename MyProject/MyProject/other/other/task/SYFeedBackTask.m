//
//  SYFeedBackTask.m
//  EatEquity
//
//  Created by liyunqi on 08/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "SYFeedBackTask.h"

@implementation SYFeedBackTask
-(NSMutableDictionary *)parDic
{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    DICT_PUT(dic, @"command", @"user/suggestion");
    NSMutableArray *list=[NSMutableArray new];
    for (SYBaseImageAsset *asset in self.getFeedBackModel.allImageContent) {
        if (!SYStringisEmpty(asset.originalImage.image.url)) {
            [list addObject:asset.originalImage.image.url];
        }
    }
    NSMutableDictionary *par=[NSMutableDictionary dictionaryWithCapacity:0];
    DICT_PUT(par, @"imgs", list);
    DICT_PUT(par, @"content", self.getFeedBackModel.feedBackContent);
    DICT_PUT(dic, @"key", [par modelToJSONString]);
    
    return dic;
}
@end
