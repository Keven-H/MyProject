//
//  SYTextParser.h
//  Foodie
//
//  Created by liyunqi on 19/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SYTextParser <NSObject>
@required
- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)selectedRange;
@end
@interface SYTextParser : NSObject
@end
