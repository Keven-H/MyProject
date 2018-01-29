//
//  SYNavigationitemLeftView.h
//  Foodie
//
//  Created by liyunqi on 22/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYNavigationItemBtnView.h"
@interface SYNavigationitemLeftView : UIView
PROPERTY_STRONG SYNavigationItemBtnView *goBackItem;
PROPERTY_STRONG SYNavigationItemBtnView *goRootItem;
-(void)showBackBtn:(NSString *)title imageStr:(NSString *)strImage;
-(void)resetDefault;
@end
