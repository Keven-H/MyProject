//
//  SYShareItemsView.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYShareOption.h"
@protocol SYShareItemsViewDelegate<NSObject>
@optional
-(void)SYShareItemsViewDelegateClickClose;
@end
@interface SYShareItemsView : UIView
PROPERTY_WEAK id<SYShareItemsViewDelegate>delegate;
PROPERTY_STRONG SYShareOption *option;
-(void)clickItem:(SYShareContenTtem)contentItem;
-(void)reset;
@end
