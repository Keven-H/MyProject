//
//  UIView+SYCreateViews.h
//  Foodie
//
//  Created by liyunqi on 16/3/14.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYCreateViews)
+(nonnull UILabel *)SYCreateDefalutLabelFont:(nullable UIFont *)font textColor:( nullable UIColor*)color textAlignment:(NSTextAlignment)textAlignment;

+(nonnull UIButton *)SYCreateDefaultBtnTarget:(nullable id)target  action:( nullable SEL)action;

+(nonnull UIView *)SYCreateDefaultView:(CGRect )rect;
+(nullable UIView *)SYUIViewFromXibName:(nonnull NSString *)xibName;

+(nonnull UITableView *)SYCreateDefalultTableView:(nullable id)delegate;
+(nonnull UITableViewCell *)SYCreateDefalultCellView:(nonnull UITableView *)tableview identifier:(nonnull NSString *)identifier cellClass:(nullable Class)cellclass;

+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImage:(nullable UIImage *)image;
+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImageStr:(nullable NSString *)imagestr;
+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImageUrl:(nullable NSString *)imageUrl;

+(nonnull UICollectionView *)SYCreateCollectionView:(nullable id)delegate layout:(nonnull UICollectionViewFlowLayout *)layout cellclass:( nonnull Class)cellClassName;


-(void)addSuViewWithDescendant:(UIView *)view;
@end
