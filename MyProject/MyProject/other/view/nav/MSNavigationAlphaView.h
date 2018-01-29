//
//  MSNavigationAlphaView.h
//  meishi
//
//  Created by Mac on 7/10/15.
//  Copyright (c) 2015 Kangbo. All rights reserved.
//

typedef NS_ENUM(NSInteger, FNNavigationAlphaViewSourceType) { //显示view的来源
    FNNavigationAlphaViewSourceTypeBuinessDetail        = 1,  //商户详情
    FNNavigationAlphaViewSourceTypeRichTextFoodDetail   = 2,  //动态详情
    FNNavigationAlphaViewSourceTypeOther                = 3
};

#import <UIKit/UIKit.h>
#import "MSNavigationButton.h"

@interface MSNavigationAlphaView : UIView

PROPERTY_STRONG UILabel* titleLabel;

PROPERTY_STRONG UIControl *leftItem;
PROPERTY_STRONG UIControl *leftOtheritem;
PROPERTY_STRONG UIControl *rightItem;
PROPERTY_STRONG UIControl *bottomItem;

PROPERTY_STRONG UIView *titleView;

@property (nonatomic, assign) FNNavigationAlphaViewSourceType sourceAlphaViewType;
PROPERTY_ASSIGN CGFloat contentAlpha;
PROPERTY_STRONG UIColor *contentBackGroundColor;

PROPERTY_ASSIGN BOOL barCanAlpha;//yes

//
PROPERTY_STRONG UIScrollView *scrollView;
PROPERTY_ASSIGN float scrollHeigth;//100

-(void)initTitleLabel;
- (void)updateNavigationView:(MSNavigationAlphaView *)view ScrollView:(UIScrollView *)scrollView alphaOffset:(CGFloat)offset;
-(void)upDataViewShow;
-(void)unAuto;
@end
