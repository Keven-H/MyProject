//
//  SYResolveResponse.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYJSONAdapter.h"
#import "SYResolveResponse.h"
#import <XAbstractionLibrary/XAbstractionLibrary.h>

@implementation SYResolveResponse

+ (SYResponse *) resolveWithClass:(Class)Class
                      responseObj:(id)responseObj
                            error:(NSError *)error
{
    SYResponse *response = nil;
    
    if(error)
    {
        response = [[SYResponse alloc] init];
        [response responseWithError:error];
    }
    else
    {
        if(Class)
        {
            if(![Class isSubclassOfClass:[XModel class]])
                response = [SYResponse unSupportParse];
            else if([responseObj isKindOfClass:[NSDictionary class]])
                response = [SYJSONAdapter modelOfClass:Class fromJSONDictionary:responseObj error:nil];
            else
                response = [SYResponse otherGeneralFail];
        }
    }
    
    return response;
}
@end
