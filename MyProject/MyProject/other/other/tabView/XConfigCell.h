//
//  SYITIConfigCell.h
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "SYBaseTableViewCell.h"
#import "XCellConfigModel.h"
@interface XConfigCell : SYBaseTableViewCell
PROPERTY_STRONG UILabel *leftName;
PROPERTY_STRONG UIImageView *leftImageView;
PROPERTY_STRONG UILabel *rigthName;
PROPERTY_STRONG UIImageView *rigthImageView;


PROPERTY_STRONG XCellConfigModel *configModel;
@end
