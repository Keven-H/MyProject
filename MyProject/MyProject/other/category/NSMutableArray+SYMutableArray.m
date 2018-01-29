//
//  NSMutableArray+SYMutableArray.m
//  Foodie
//
//  Created by liyunqi on 09/01/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "NSMutableArray+SYMutableArray.h"

@implementation NSMutableArray (SYMutableArray)
-(NSArray*)randomArr
{
    NSArray* arr  = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    return arr;
}
@end
