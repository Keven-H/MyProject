//
//  SYBaseModel.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  小黄圈基础对象
 */
@interface SYBaseModel : XModel

/**
 *  用于区分对象唯一性
 */
@property (nonatomic,strong) NSString *ID;

/**
 *  验证对象ID是否存在
 *
 *  @return YES 存在 NO 不存在
 */
- (BOOL) validateID;

@end
