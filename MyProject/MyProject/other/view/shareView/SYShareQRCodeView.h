//
//  SYShareQRCodeView.h
//  Foodie
//
//  Created by liyunqi on 11/3/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYShareQRCodeView : UIView
PROPERTY_ASSIGN float leftMargin;
-(void)resetWithStr:(NSString *)qrstr avatar:(NSString *)avatar;
@end
