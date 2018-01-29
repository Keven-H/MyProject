//
//  TestNotNetView.m
//  XTestApp
//
//  Created by 兰彪 on 2017/3/16.
//  Copyright © 2017年 lanbiao. All rights reserved.
//

#import "TestNotNetView.h"

@interface TestNotNetView()
@property (strong, nonatomic) IBOutlet UILabel *noNetLabel;
@property (strong, nonatomic) IBOutlet UILabel *retryLabel;
@end

@implementation TestNotNetView

+ (instancetype) createTestNotNetView
{
    TestNotNetView *testErrorView = [[[NSBundle mainBundle] loadNibNamed:@"TestNotNetView" owner:self options:nil] objectAtIndex:0];
    return testErrorView;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.noNetLabel.font = UIFontWithSize(15);
    self.noNetLabel.textColor = FNColor(136, 136, 136);
    self.retryLabel.font = UIFontWithSize(15);
    self.retryLabel.textColor = FNColor(136, 136, 136);
}

- (IBAction) retryRequestClick:(id) sender
{
    [self retryControl];
}

@end
