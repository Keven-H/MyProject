//
//  UIView+SYCreateViews.m
//  Foodie
//
//  Created by liyunqi on 16/3/14.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "UIView+SYCreateViews.h"

@implementation UIView (SYCreateViews)
+(nonnull UILabel *)SYCreateDefalutLabelFont:(nullable UIFont *)font textColor:( nullable UIColor*)color textAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=textAlignment;
    label.textColor=color;
    label.font=font;
    return label;
}
+(nonnull UIButton *)SYCreateDefaultBtnTarget:(nullable id)target  action:( SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(nonnull UIView *)SYCreateDefaultView:(CGRect )rect
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    view.frame=rect;
    return view;
}
+(nullable UIView *)SYUIViewFromXibName:(nonnull NSString *)xibName
{
    NSArray *xibs = [[NSBundle mainBundle]loadNibNamed:xibName owner:nil options:nil];
    if (xibs.count) {
        return [xibs objectAtIndex:0];
    }
    return nil;
}

+(nonnull UITableView *)SYCreateDefalultTableView:(nullable id)delegate
{
    UITableView* tableView=[[UITableView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.scrollsToTop=NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor=[UIColor clearColor];
    return tableView;
}
+(nonnull UITableViewCell *)SYCreateDefalultCellView:(nonnull UITableView *)tableview identifier:(nonnull NSString *)identifier cellClass:(nullable Class)cellclass
{
    UITableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        if (cellclass&&[cellclass isSubclassOfClass:[UITableViewCell class]]) {
             cell=[[cellclass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    return cell;
}

+(nonnull UIImageView *)SYCreateDefalultImageView
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.backgroundColor=[UIColor clearColor];
    return imageView;
}
+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImage:(nullable UIImage *)image
{
    UIImageView *imageView=[self SYCreateDefalultImageView];
    imageView.image=image;
    return imageView;
}
+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImageStr:(nullable NSString *)imagestr
{
    UIImageView *imageView=[self SYCreateDefalultImageView];
    imageView.image=[UIImage imageNamed:imagestr];;
    return imageView;
}
+(nonnull UIImageView *)SYCreateDefalultImageViewWitiImageUrl:(nullable NSString *)imageUrl
{
    UIImageView *imageView=[self SYCreateDefalultImageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return imageView;
}


+(nonnull UICollectionView *)SYCreateCollectionView:(nullable id)delegate layout:(nonnull UICollectionViewFlowLayout *)layout cellclass:( nonnull Class)cellClassName
{
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
     [collectionView setBackgroundColor:[UIColor clearColor]];
    collectionView.scrollsToTop = NO;
    collectionView.dataSource = delegate;
    collectionView.delegate = delegate;
    [collectionView registerClass:[cellClassName class] forCellWithReuseIdentifier:NSStringFromClass(cellClassName)];
    return collectionView;
}

-(void)addSuViewWithDescendant:(UIView *)view
{
    if (![view isDescendantOfView:self]) {
        [self addSubview:view];
    }
}
@end
