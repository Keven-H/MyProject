//
//  SYShareQRCodeContentView.h
//  Foodie
//
//  Created by liyunqi on 11/7/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYShareQRCodeContentView : UIView
PROPERTY_ASSIGN float leftMargin;//15
PROPERTY_ASSIGN float topMargin;//10
-(void)resetQRStr:(NSString *)str;
@end
