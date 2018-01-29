//
//  SYActivityItemsView.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYActivityItemsView.h"

@implementation SYActivityItemsView
-(UIButton *)createBtnWith:(CGRect)rect tag:(NSInteger)tag image:(UIImage *)image title:(NSString *)title spacing:(float)spacing font:(UIFont *)font color:(UIColor *)color
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    btn.frame=rect;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setImagePosition:SYImagePositionTop spacing:spacing];
    [self addSubview:btn];
    return btn;
    
}
-(void)resetView:(SYShareActivityList *)items
{
    [self removeAllSubViews];
    float spacing=items.spacing;
    UIFont *font=items.font;
    CGSize size=[@"微信微博新" sizeWithTextFont:font maxWidth:1000];
    CGSize imagesize=ImageNamed(items.listItems.firstObject.imagePath).size;
    float width=MAX(imagesize.width, size.width);
    float x=items.leftRMargin;
    float y=items.topMargin;
    float viewheigth=y;
    float xoffet=x;
    float margin=(self.width-x*2-width*3)/2;
    float height=imagesize.height+spacing+size.height;
    for (int i=0; i<items.listItems.count; i++) {
        SYShareActivityItem *activity=(SYShareActivityItem *)[items.listItems objectAtIndex:i];
        CGRect rect=CGRectMake(xoffet, y, width, height);
        UIButton *btn=[self createBtnWith:rect tag:100+i image:ImageNamed(activity.imagePath)  title:activity.title spacing:spacing font:font color:items.color];
        [btn addTarget:activity action:activity.autoSel forControlEvents:UIControlEventTouchUpInside];
        xoffet=btn.width+btn.x+margin;
        if (i>0&&(i+1)%3==0) {
            y=btn.height+btn.y+items.itemVerticalMargin;
            xoffet=x;
        }
        viewheigth=btn.height+btn.y;
        self.width=MAX(self.width, xoffet+x);
    }
    self.height=viewheigth+items.bottomMargin;
}
@end
