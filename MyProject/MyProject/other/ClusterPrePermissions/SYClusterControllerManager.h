//
//  SYClusterControllerManager.h
//  Foodie
//
//  Created by liyunqi on 5/4/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYClusterControllerManager : NSObject
PROPERTY_WEAK  id <UINavigationControllerDelegate, UIImagePickerControllerDelegate> delegate;
PROPERTY_ASSIGN BOOL allowsEditing;
PROPERTY_ASSIGN UIImagePickerControllerSourceType sourceType;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;
@end
