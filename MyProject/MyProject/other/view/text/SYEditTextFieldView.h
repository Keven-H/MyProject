//
//  SYEditTextFieldView.h
//  Foodie
//
//  Created by liyunqi on 01/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^SYEditFieldChange)(NSString *str ,NSInteger status);
@interface SYEditTextFieldView : SYBaseTextField
PROPERTY_ASSIGN NSInteger maxNum;//default 0
PROPERTY_STRONG UIColor *placeColor;
PROPERTY_ASSIGN BOOL usedChineseChar;//no是否使用中文字符限制
PROPERTY_WEAK UIImage *clearImage;
-(void)setChangeBlock:(SYEditFieldChange)changeBlock;
@end
