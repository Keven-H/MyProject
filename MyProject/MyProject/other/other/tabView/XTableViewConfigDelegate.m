//
//  ITITableViewConfigDelegate.m
//  myFrameworkDemo
//
//  Created by liyunqi on 22/09/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "XTableViewConfigDelegate.h"
@interface XTableViewConfigDelegate()
{
    
}
PROPERTY_STRONG NSMutableArray<XCellConfigModel *> *list;

@end
@implementation XTableViewConfigDelegate
-(void)config:(NSMutableArray<XCellConfigModel *>*)list tableview:(UITableView *)tableView
{
    self.list=[[NSMutableArray alloc]initWithArray:list];
    tableView.dataSource=self;
    tableView.delegate=self;
    [tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.delegate tableView:tableView numberOfRowsInSection:section];
    }
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return [self.list objectAtIndex:indexPath.row].cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    if ([[self.list objectAtIndex:indexPath.row].cellClass isSubclassOfClass:[XConfigCell class]]) {
        XConfigCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self.list objectAtIndex:indexPath.row].cellClass)];
        
        if (cell==nil) {
            cell=[[[self.list objectAtIndex:indexPath.row].cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self.list objectAtIndex:indexPath.row].cellClass)];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.configModel=[self.list objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else
    {
        XCellConfigModel *model=[self.list objectAtIndex:indexPath.row];
        if (model.target&&model.action&&[model.target respondsToSelector:model.action]) {
            [model.target performSelector:model.action];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] )
        return YES;
    
    if ([self.delegate respondsToSelector:aSelector])
        return YES;
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        if([self.delegate respondsToSelector:selector]) {
            return [(NSObject *)self.delegate methodSignatureForSelector:selector];
        }
    }
    return signature;
}
- (void)forwardInvocation:(NSInvocation*)invocation
{
    if ([self.delegate respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:_delegate];
    }
}
@end
