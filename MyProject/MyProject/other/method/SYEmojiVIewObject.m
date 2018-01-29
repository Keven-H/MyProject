//
//  SYEmojiVIewObject.m
//  Foodie
//
//  Created by liyunqi on 12/12/2016.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYEmojiVIewObject.h"
#import "NSAttributedString+YYText.h"
#import "YYLabel.h"
#import "SYTextSimpleEmoticonParser.h"
@implementation SYEmojiVIewObject

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}



+(NSArray*)getDefaultImageArray
{
    
    static dispatch_once_t pred = 0;
    static NSMutableArray *faceDefaultList = nil;
    dispatch_once(&pred,
                  ^{
                      faceDefaultList = [[NSMutableArray alloc] init];
                      for (int i=0; i<16; i++) {
                          NSString *str=@"";
                          str=[NSString stringWithFormat:@"face%d",i+1];
                          [faceDefaultList addObject:[NSString stringWithFormat:@"%@.png",str]];
                      }
                      
                  });
    return faceDefaultList;
}
+(NSArray *)getDefaultNameArray
{
    static dispatch_once_t pred = 0;
    static NSMutableArray *faceDefaultNameList = nil;
    dispatch_once(&pred,
                  ^{
                      faceDefaultNameList=[[NSMutableArray alloc ]init];
                      NSString *str=@"馋,赞,喜欢,嘚瑟,哭,害羞,生气,大笑,难吃,笑哭,汗,鄙视,委屈,羡慕,吃,好饱";
                      NSArray* list = [str componentsSeparatedByString:@","];
                      for (int i=0; i<list.count; i++) {
                          [faceDefaultNameList addObject:[NSString stringWithFormat:@"[%@]",[list objectAtIndex:i]]];
                      }
                  });
    return faceDefaultNameList;
}

+ (NSArray*)getEmojiArray
{
    //0： 5.*系统以上采用的Unicode  1：4.*采用的sb Unicode （数组第二个内容可以舍弃了）
    return [NSArray arrayWithObjects:
            [NSArray arrayWithObjects:@"\U0001F603",@"\\uE057", nil],
            [NSArray arrayWithObjects:@"\U0001F60A", @"\\uE056", nil],
            [NSArray arrayWithObjects:@"\U0001F61E", @"\\uE058", nil],
            [NSArray arrayWithObjects:@"\U0001F620", @"\\uE059", nil],
            [NSArray arrayWithObjects:@"\U0001F60C", @"\\uE40A", nil],
            [NSArray arrayWithObjects:@"\U0001F61C", @"\\uE105", nil],
            [NSArray arrayWithObjects:@"\U0001F60D", @"\\uE106", nil],
            [NSArray arrayWithObjects:@"\U0001F631", @"\\uE107", nil],
            [NSArray arrayWithObjects:@"\U0001F613", @"\\uE108", nil],
            [NSArray arrayWithObjects:@"\U0001F625", @"\\uE401", nil],
            [NSArray arrayWithObjects:@"\U0001F60F", @"\\uE402", nil],
            [NSArray arrayWithObjects:@"\U0001F614", @"\\uE403", nil],
            [NSArray arrayWithObjects:@"\U0001F601", @"\\uE404", nil],
            [NSArray arrayWithObjects:@"\U0001F609", @"\\uE405", nil],
            [NSArray arrayWithObjects:@"\U0001F623", @"\\uE406", nil],
            [NSArray arrayWithObjects:@"\U0001F616", @"\\uE407", nil],
            [NSArray arrayWithObjects:@"\U0001F62A", @"\\uE408", nil],
            [NSArray arrayWithObjects:@"\U0001F61D", @"\\uE409", nil],
            [NSArray arrayWithObjects:@"\U0001F632", @"\\uE410", nil],
            [NSArray arrayWithObjects:@"\U0001F62D", @"\\uE411", nil],
            [NSArray arrayWithObjects:@"\U0001F602", @"\\uE412", nil],
            [NSArray arrayWithObjects:@"\U0001F622", @"\\uE413", nil],
            [NSArray arrayWithObjects:@"\u263A", @"\\uE414", nil],
            [NSArray arrayWithObjects:@"\U0001F604", @"\\uE415", nil],
            [NSArray arrayWithObjects:@"\U0001F621", @"\\uE416", nil],
            [NSArray arrayWithObjects:@"\U0001F61A", @"\\uE417", nil],
            [NSArray arrayWithObjects:@"\U0001F618", @"\\uE418", nil],
            [NSArray arrayWithObjects:@"\U0001F44C", @"\\uE420", nil],
            [NSArray arrayWithObjects:@"\U0001F628", @"\\uE40B", nil],
            [NSArray arrayWithObjects:@"\U0001F637", @"\\uE40C", nil],
            [NSArray arrayWithObjects:@"\U0001F633", @"\\uE40D", nil],
            [NSArray arrayWithObjects:@"\U0001F612", @"\\uE40E", nil],
            [NSArray arrayWithObjects:@"\U0001F630", @"\\uE40F", nil],
            [NSArray arrayWithObjects:@"\U0001F44F", @"\\uE41F", nil],
            [NSArray arrayWithObjects:@"\U0001F44A", @"\\uE00D", nil],
            [NSArray arrayWithObjects:@"\U0001F44D", @"\\uE00E", nil],
            [NSArray arrayWithObjects:@"\u261D", @"\\uE00F", nil],
            [NSArray arrayWithObjects:@"\U0001F434", @"\\uE01A", nil],
            [NSArray arrayWithObjects:@"\U0001F697", @"\\uE01B", nil],
            [NSArray arrayWithObjects:@"\u2708", @"\\uE01D", nil],
            [NSArray arrayWithObjects:@"\U0001F48B", @"\\uE003", nil],
            [NSArray arrayWithObjects:@"\U0001F3A4", @"\\uE03C", nil],
            [NSArray arrayWithObjects:@"\u2600", @"\\uE04A", nil],
            [NSArray arrayWithObjects:@"\u2614", @"\\uE04B", nil],
            [NSArray arrayWithObjects:@"\U0001F319", @"\\uE04C", nil],
            [NSArray arrayWithObjects:@"\U0001F4A9", @"\\uE05A", nil],
            [NSArray arrayWithObjects:@"\u270A", @"\\uE010", nil],
            [NSArray arrayWithObjects:@"\U0001F437", @"\\uE10B", nil],
            [NSArray arrayWithObjects:@"\U0001F47D", @"\\uE10C", nil],
            [NSArray arrayWithObjects:@"\u270C", @"\\uE011", nil],
            [NSArray arrayWithObjects:@"\U0001F47B", @"\\uE11B", nil],
            [NSArray arrayWithObjects:@"\U0001F480", @"\\uE11C", nil],
            [NSArray arrayWithObjects:@"\U0001F525", @"\\uE11D", nil],
            [NSArray arrayWithObjects:@"\u270B", @"\\uE012", nil],
            [NSArray arrayWithObjects:@"\U0001F004", @"\\uE12D", nil],
            [NSArray arrayWithObjects:@"\U0001F4B0", @"\\uE12F", nil],
            [NSArray arrayWithObjects:@"\U0001F489", @"\\uE13B", nil],
            [NSArray arrayWithObjects:@"\U0001F4A4", @"\\uE13C", nil],
            [NSArray arrayWithObjects:@"\u26A1", @"\\uE13D", nil],
            [NSArray arrayWithObjects:@"\U0001F460", @"\\uE13E", nil],
            [NSArray arrayWithObjects:@"\u26F3", @"\\uE014", nil],
            [NSArray arrayWithObjects:@"\U0001F4AA", @"\\uE14C", nil],
            [NSArray arrayWithObjects:@"\u26BD", @"\\uE018", nil],
            [NSArray arrayWithObjects:@"\u2660", @"\\uE20E", nil],
            [NSArray arrayWithObjects:@"\u2764", @"\\uE022", nil],
            [NSArray arrayWithObjects:@"\U0001F494", @"\\uE023", nil],
            [NSArray arrayWithObjects:@"\U0001F52F", @"\\uE23E", nil],
            [NSArray arrayWithObjects:@"\u2648", @"\\uE23F", nil],
            [NSArray arrayWithObjects:@"\u2653", @"\\uE24A", nil],
            [NSArray arrayWithObjects:@"\U0001F338", @"\\uE030", nil],
            [NSArray arrayWithObjects:@"\U0001F37B", @"\\uE30C", nil],
            [NSArray arrayWithObjects:@"\u3297", @"\\uE30D", nil],
            [NSArray arrayWithObjects:@"\U0001F6AC", @"\\uE30E", nil],
            [NSArray arrayWithObjects:@"\U0001F48A", @"\\uE30F", nil],
            [NSArray arrayWithObjects:@"\U0001F461", @"\\uE31A", nil],
            [NSArray arrayWithObjects:@"\U0001F462", @"\\uE31B", nil],
            [NSArray arrayWithObjects:@"\U0001F484", @"\\uE31C", nil],
            [NSArray arrayWithObjects:@"\U0001F485", @"\\uE31D", nil],
            [NSArray arrayWithObjects:@"\U0001F486", @"\\uE31E", nil],
            [NSArray arrayWithObjects:@"\U0001F487", @"\\uE31F", nil],
            [NSArray arrayWithObjects:@"\U0001F339", @"\\uE032", nil],
            [NSArray arrayWithObjects:@"\u2B50", @"\\uE32F", nil],
            [NSArray arrayWithObjects:@"\U0001F366", @"\\uE33A", nil],
            [NSArray arrayWithObjects:@"\U0001F35D", @"\\uE33F", nil],
            [NSArray arrayWithObjects:@"\U0001F48D", @"\\uE034", nil],
            [NSArray arrayWithObjects:@"\U0001F382", @"\\uE34B", nil],
            [NSArray arrayWithObjects:@"\U0001F371", @"\\uE34C", nil],
            [NSArray arrayWithObjects:@"\U0001F48E", @"\\uE035", nil],
            [NSArray arrayWithObjects:@"\U0001F3C0", @"\\uE42A", nil],
            [NSArray arrayWithObjects:@"\U0001F3B1", @"\\uE42C", nil],
            [NSArray arrayWithObjects:@"\U0001F3CA", @"\\uE42D", nil],
            [NSArray arrayWithObjects:@"\U0001F374", @"\\uE043", nil],
            [NSArray arrayWithObjects:@"\U0001F302", @"\\uE43C", nil],
            [NSArray arrayWithObjects:@"\U0001F492", @"\\uE43D", nil],
            [NSArray arrayWithObjects:@"\U0001F367", @"\\uE43F", nil],
            [NSArray arrayWithObjects:@"\U0001F378", @"\uE044", nil],
            [NSArray arrayWithObjects:@"\u2615", @"\\uE045", nil],
            [NSArray arrayWithObjects:@"\U0001F370", @"\\uE046", nil],
            [NSArray arrayWithObjects:@"\U0001F37A", @"\\uE047", nil],
            [NSArray arrayWithObjects:@"\u26C4", @"\\uE048", nil],
            [NSArray arrayWithObjects:@"\U0001F42F", @"\\uE050", nil],
            [NSArray arrayWithObjects:@"\U0001F43B", @"\\uE051", nil],
            [NSArray arrayWithObjects:@"\U0001F436", @"\\uE052", nil],
            [NSArray arrayWithObjects:@"\U0001F43A", @"\\uE52A", nil],
            [NSArray arrayWithObjects:@"\U0001F42E", @"\\uE52B", nil],
            [NSArray arrayWithObjects:@"\U0001F414", @"\\uE52E", nil],
            [NSArray arrayWithObjects:@"\U0001F433", @"\\uE054", nil],
            [NSArray arrayWithObjects:@"\U0001F340", @"\\uE110", nil],
            [NSArray arrayWithObjects:@"\U0001F48F", @"\\uE111", nil],
            [NSArray arrayWithObjects:@"\U0001F381", @"\\uE112", nil],
            [NSArray arrayWithObjects:@"\U0001F52B", @"\\uE113", nil],
            [NSArray arrayWithObjects:@"\U0001F354", @"\\uE120", nil],
            [NSArray arrayWithObjects:@"\U0001F40E", @"\\uE134", nil],
            [NSArray arrayWithObjects:@"\U0001F6A4", @"\\uE135", nil],
            [NSArray arrayWithObjects:@"\U0001F6B2", @"\\uE136", nil],
            [NSArray arrayWithObjects:@"\U0001F6B9", @"\\uE138", nil],
            [NSArray arrayWithObjects:@"\U0001F6BA", @"\\uE139", nil],
            [NSArray arrayWithObjects:@"\U0001F6BD", @"\\uE140", nil],
            [NSArray arrayWithObjects:@"\U0001F512", @"\\uE144", nil],
            [NSArray arrayWithObjects:@"\U0001F513", @"\\uE145", nil],
            [NSArray arrayWithObjects:@"\U0001F373", @"\\uE147", nil],
            [NSArray arrayWithObjects:@"\U0001F4D6", @"\\uE148", nil],
            [NSArray arrayWithObjects:@"\U0001F6BB", @"\\uE151", nil],
            [NSArray arrayWithObjects:@"\U0001F49F", @"\\uE204", nil],
            [NSArray arrayWithObjects:@"\U0001F51E", @"\\uE207", nil],
            [NSArray arrayWithObjects:@"\U0001F6AD", @"\\uE208", nil],
            [NSArray arrayWithObjects:@"\U0001F388", @"\\uE310", nil],
            [NSArray arrayWithObjects:@"\U0001F4A3", @"\\uE311", nil],
            [NSArray arrayWithObjects:@"\u2702", @"\\uE313", nil],
            [NSArray arrayWithObjects:@"\U0001F380", @"\\uE314", nil],
            [NSArray arrayWithObjects:@"\u3299", @"\\uE315", nil],
            [NSArray arrayWithObjects:@"\U0001F4BD", @"\\uE316", nil],
            [NSArray arrayWithObjects:@"\U0001F457", @"\\uE319", nil],
            [NSArray arrayWithObjects:@"\U0001F458", @"\\uE321", nil],
            [NSArray arrayWithObjects:@"\U0001F459", @"\\uE322", nil],
            [NSArray arrayWithObjects:@"\U0001F45C", @"\\uE323", nil],
            [NSArray arrayWithObjects:@"\U0001F3AC", @"\\uE324", nil],
            [NSArray arrayWithObjects:@"\U0001F497", @"\\uE328", nil],
            [NSArray arrayWithObjects:@"\U0001F498", @"\\uE329", nil],
            [NSArray arrayWithObjects:@"\U0001F4A8", @"\\uE330", nil],
            [NSArray arrayWithObjects:@"\U0001F4A6", @"\\uE331", nil],
            [NSArray arrayWithObjects:@"\u2B55", @"\\uE332", nil],
            [NSArray arrayWithObjects:@"\u274C", @"\\uE333", nil],
            [NSArray arrayWithObjects:@"\U0001F31F", @"\\uE335", nil],
            [NSArray arrayWithObjects:@"\u2754", @"\\uE336", nil],
            [NSArray arrayWithObjects:@"\u2755", @"\\uE337", nil],
            [NSArray arrayWithObjects:@"\U0001F375", @"\\uE338", nil],
            [NSArray arrayWithObjects:@"\U0001F35E", @"\\uE339", nil],
            [NSArray arrayWithObjects:@"\U0001F35B", @"\\uE341", nil],
            [NSArray arrayWithObjects:@"\U0001F34E", @"\\uE345", nil],
            [NSArray arrayWithObjects:@"\U0001F34A", @"\\uE346", nil],
            [NSArray arrayWithObjects:@"\U0001F353", @"\\uE347", nil],
            [NSArray arrayWithObjects:@"\U0001F349", @"\\uE348", nil],
            [NSArray arrayWithObjects:@"\U0001F345", @"\\uE349", nil],
            [NSArray arrayWithObjects:@"\U0001F44E", @"\\uE421", nil],
            [NSArray arrayWithObjects:@"\U0001F645", @"\\uE423", nil],
            [NSArray arrayWithObjects:@"\U0001F49D", @"\\uE437", nil],
            [NSArray arrayWithObjects:@"\U0001F385", @"\\uE448", nil],
            [NSArray arrayWithObjects:@"\U0001F1E8\U0001F1F3", @"\\uE513", nil],
            [NSArray arrayWithObjects:@"\U0001F473", @"\\uE517", nil],
            [NSArray arrayWithObjects:@"\U0001F475", @"\\uE519", nil],
            nil];
    
    
    return  [NSArray arrayWithObjects:
             [NSArray arrayWithObjects:@"\u2196", @"\uE237", nil],
             [NSArray arrayWithObjects:@"\u2197", @"\uE236", nil],
             [NSArray arrayWithObjects:@"\u2198", @"\uE238", nil],
             [NSArray arrayWithObjects:@"\u2199", @"\uE239", nil],
             [NSArray arrayWithObjects:@"\u23E9", @"\uE23C", nil],
             [NSArray arrayWithObjects:@"\u23EA", @"\uE23D", nil],
             [NSArray arrayWithObjects:@"\u25B6", @"\uE23A", nil],
             [NSArray arrayWithObjects:@"\u25C0", @"\uE23B", nil],
             [NSArray arrayWithObjects:@"\u2600", @"\uE04A", nil],
             [NSArray arrayWithObjects:@"\u2601", @"\uE049", nil],
             [NSArray arrayWithObjects:@"\u260E", @"\uE009", nil],
             [NSArray arrayWithObjects:@"\u2614", @"\uE04B", nil],
             [NSArray arrayWithObjects:@"\u2615", @"\uE045", nil],
             [NSArray arrayWithObjects:@"\u261D", @"\uE00F", nil],
             [NSArray arrayWithObjects:@"\u263A", @"\uE414", nil],
             [NSArray arrayWithObjects:@"\u2648", @"\uE23F", nil],
             [NSArray arrayWithObjects:@"\u2649", @"\uE240", nil],
             [NSArray arrayWithObjects:@"\u264A", @"\uE241", nil],
             [NSArray arrayWithObjects:@"\u264B", @"\uE242", nil],
             [NSArray arrayWithObjects:@"\u264C", @"\uE243", nil],
             [NSArray arrayWithObjects:@"\u264D", @"\uE244", nil],
             [NSArray arrayWithObjects:@"\u264E", @"\uE245", nil],
             [NSArray arrayWithObjects:@"\u264F", @"\uE246", nil],
             [NSArray arrayWithObjects:@"\u2650", @"\uE247", nil],
             [NSArray arrayWithObjects:@"\u2651", @"\uE248", nil],
             [NSArray arrayWithObjects:@"\u2652", @"\uE249", nil],
             [NSArray arrayWithObjects:@"\u2653", @"\uE24A", nil],
             [NSArray arrayWithObjects:@"\u2660", @"\uE20E", nil],
             [NSArray arrayWithObjects:@"\u2663", @"\uE20F", nil],
             [NSArray arrayWithObjects:@"\u2665", @"\uE20C", nil],
             [NSArray arrayWithObjects:@"\u2666", @"\uE20D", nil],
             [NSArray arrayWithObjects:@"\u2668", @"\uE123", nil],
             [NSArray arrayWithObjects:@"\u267F", @"\uE20A", nil],
             [NSArray arrayWithObjects:@"\u26A0", @"\uE252", nil],
             [NSArray arrayWithObjects:@"\u26A1", @"\uE13D", nil],
             [NSArray arrayWithObjects:@"\u26BD", @"\uE018", nil],
             [NSArray arrayWithObjects:@"\u26BE", @"\uE016", nil],
             [NSArray arrayWithObjects:@"\u26C4", @"\uE048", nil],
             [NSArray arrayWithObjects:@"\u26CE", @"\uE24B", nil],
             [NSArray arrayWithObjects:@"\u26EA", @"\uE037", nil],
             [NSArray arrayWithObjects:@"\u26F2", @"\uE121", nil],
             [NSArray arrayWithObjects:@"\u26F3", @"\uE014", nil],
             [NSArray arrayWithObjects:@"\u26F5", @"\uE01C", nil],
             [NSArray arrayWithObjects:@"\u26FA", @"\uE122", nil],
             [NSArray arrayWithObjects:@"\u26FD", @"\uE03A", nil],
             [NSArray arrayWithObjects:@"\u2702", @"\uE313", nil],
             [NSArray arrayWithObjects:@"\u2708", @"\uE01D", nil],
             [NSArray arrayWithObjects:@"\u270A", @"\uE010", nil],
             [NSArray arrayWithObjects:@"\u270B", @"\uE012", nil],
             [NSArray arrayWithObjects:@"\u270C", @"\uE011", nil],
             [NSArray arrayWithObjects:@"\u2728", @"\uE32E", nil],
             [NSArray arrayWithObjects:@"\u2733", @"\uE206", nil],
             [NSArray arrayWithObjects:@"\u2734", @"\uE205", nil],
             [NSArray arrayWithObjects:@"\u274C", @"\uE333", nil],
             [NSArray arrayWithObjects:@"\u2753", @"\uE020", nil],
             [NSArray arrayWithObjects:@"\u2754", @"\uE336", nil],
             [NSArray arrayWithObjects:@"\u2755", @"\uE337", nil],
             [NSArray arrayWithObjects:@"\u2757", @"\uE021", nil],
             [NSArray arrayWithObjects:@"\u2764", @"\uE022", nil],
             [NSArray arrayWithObjects:@"\u27A1", @"\uE234", nil],
             [NSArray arrayWithObjects:@"\u27BF", @"\uE211", nil],
             [NSArray arrayWithObjects:@"\u2B05", @"\uE235", nil],
             [NSArray arrayWithObjects:@"\u2B06", @"\uE232", nil],
             [NSArray arrayWithObjects:@"\u2B07", @"\uE233", nil],
             [NSArray arrayWithObjects:@"\u2B50", @"\uE32F", nil],
             [NSArray arrayWithObjects:@"\u2B55", @"\uE332", nil],
             [NSArray arrayWithObjects:@"\u303D", @"\uE12C", nil],
             [NSArray arrayWithObjects:@"\u3297", @"\uE30D", nil],
             [NSArray arrayWithObjects:@"\u3299", @"\uE315", nil],
             [NSArray arrayWithObjects:@"\U0001F004", @"\uE12D", nil],
             [NSArray arrayWithObjects:@"\U0001F170", @"\uE532", nil],
             [NSArray arrayWithObjects:@"\U0001F171", @"\uE533", nil],
             [NSArray arrayWithObjects:@"\U0001F17E", @"\uE535", nil],
             [NSArray arrayWithObjects:@"\U0001F17F", @"\uE14F", nil],
             [NSArray arrayWithObjects:@"\U0001F18E", @"\uE534", nil],
             [NSArray arrayWithObjects:@"\U0001F192", @"\uE214", nil],
             [NSArray arrayWithObjects:@"\U0001F194", @"\uE229", nil],
             [NSArray arrayWithObjects:@"\U0001F195", @"\uE212", nil],
             [NSArray arrayWithObjects:@"\U0001F197", @"\uE24D", nil],
             [NSArray arrayWithObjects:@"\U0001F199", @"\uE213", nil],
             [NSArray arrayWithObjects:@"\U0001F19A", @"\uE12E", nil],
             [NSArray arrayWithObjects:@"\U0001F1E8\U0001F1F3", @"\uE513", nil],
             [NSArray arrayWithObjects:@"\U0001F1E9\U0001F1EA", @"\uE50E", nil],
             [NSArray arrayWithObjects:@"\U0001F1EA\U0001F1F8", @"\uE511", nil],
             [NSArray arrayWithObjects:@"\U0001F1EB\U0001F1F7", @"\uE50D", nil],
             [NSArray arrayWithObjects:@"\U0001F1EC\U0001F1E7", @"\uE510", nil],
             [NSArray arrayWithObjects:@"\U0001F1EE\U0001F1F9", @"\uE50F", nil],
             [NSArray arrayWithObjects:@"\U0001F1EF\U0001F1F5", @"\uE50B", nil],
             [NSArray arrayWithObjects:@"\U0001F1F0\U0001F1F7", @"\uE514", nil],
             [NSArray arrayWithObjects:@"\U0001F1F7\U0001F1FA", @"\uE512", nil],
             [NSArray arrayWithObjects:@"\U0001F1FA\U0001F1F8", @"\uE50C", nil],
             [NSArray arrayWithObjects:@"\U0001F201", @"\uE203", nil],
             [NSArray arrayWithObjects:@"\U0001F202", @"\uE228", nil],
             [NSArray arrayWithObjects:@"\U0001F21A", @"\uE216", nil],
             [NSArray arrayWithObjects:@"\U0001F22F", @"\uE22C", nil],
             [NSArray arrayWithObjects:@"\U0001F233", @"\uE22B", nil],
             [NSArray arrayWithObjects:@"\U0001F235", @"\uE22A", nil],
             [NSArray arrayWithObjects:@"\U0001F236", @"\uE215", nil],
             [NSArray arrayWithObjects:@"\U0001F237", @"\uE217", nil],
             [NSArray arrayWithObjects:@"\U0001F238", @"\uE218", nil],
             [NSArray arrayWithObjects:@"\U0001F239", @"\uE227", nil],
             [NSArray arrayWithObjects:@"\U0001F23A", @"\uE22D", nil],
             [NSArray arrayWithObjects:@"\U0001F250", @"\uE226", nil],
             [NSArray arrayWithObjects:@"\U0001F300", @"\uE443", nil],
             [NSArray arrayWithObjects:@"\U0001F302", @"\uE43C", nil],
             [NSArray arrayWithObjects:@"\U0001F303", @"\uE44B", nil],
             [NSArray arrayWithObjects:@"\U0001F304", @"\uE04D", nil],
             [NSArray arrayWithObjects:@"\U0001F305", @"\uE449", nil],
             [NSArray arrayWithObjects:@"\U0001F306", @"\uE146", nil],
             [NSArray arrayWithObjects:@"\U0001F307", @"\uE44A", nil],
             [NSArray arrayWithObjects:@"\U0001F308", @"\uE44C", nil],
             [NSArray arrayWithObjects:@"\U0001F30A", @"\uE43E", nil],
             [NSArray arrayWithObjects:@"\U0001F319", @"\uE04C", nil],
             [NSArray arrayWithObjects:@"\U0001F31F", @"\uE335", nil],
             [NSArray arrayWithObjects:@"\U0001F334", @"\uE307", nil],
             [NSArray arrayWithObjects:@"\U0001F335", @"\uE308", nil],
             [NSArray arrayWithObjects:@"\U0001F337", @"\uE304", nil],
             [NSArray arrayWithObjects:@"\U0001F338", @"\uE030", nil],
             [NSArray arrayWithObjects:@"\U0001F339", @"\uE032", nil],
             [NSArray arrayWithObjects:@"\U0001F33A", @"\uE303", nil],
             [NSArray arrayWithObjects:@"\U0001F33B", @"\uE305", nil],
             [NSArray arrayWithObjects:@"\U0001F33E", @"\uE444", nil],
             [NSArray arrayWithObjects:@"\U0001F340", @"\uE110", nil],
             [NSArray arrayWithObjects:@"\U0001F341", @"\uE118", nil],
             [NSArray arrayWithObjects:@"\U0001F342", @"\uE119", nil],
             [NSArray arrayWithObjects:@"\U0001F343", @"\uE447", nil],
             [NSArray arrayWithObjects:@"\U0001F345", @"\uE349", nil],
             [NSArray arrayWithObjects:@"\U0001F346", @"\uE34A", nil],
             [NSArray arrayWithObjects:@"\U0001F349", @"\uE348", nil],
             [NSArray arrayWithObjects:@"\U0001F34A", @"\uE346", nil],
             [NSArray arrayWithObjects:@"\U0001F34E", @"\uE345", nil],
             [NSArray arrayWithObjects:@"\U0001F353", @"\uE347", nil],
             [NSArray arrayWithObjects:@"\U0001F354", @"\uE120", nil],
             [NSArray arrayWithObjects:@"\U0001F358", @"\uE33D", nil],
             [NSArray arrayWithObjects:@"\U0001F359", @"\uE342", nil],
             [NSArray arrayWithObjects:@"\U0001F35A", @"\uE33E", nil],
             [NSArray arrayWithObjects:@"\U0001F35B", @"\uE341", nil],
             [NSArray arrayWithObjects:@"\U0001F35C", @"\uE340", nil],
             [NSArray arrayWithObjects:@"\U0001F35D", @"\uE33F", nil],
             [NSArray arrayWithObjects:@"\U0001F35E", @"\uE339", nil],
             [NSArray arrayWithObjects:@"\U0001F35F", @"\uE33B", nil],
             [NSArray arrayWithObjects:@"\U0001F361", @"\uE33C", nil],
             [NSArray arrayWithObjects:@"\U0001F362", @"\uE343", nil],
             [NSArray arrayWithObjects:@"\U0001F363", @"\uE344", nil],
             [NSArray arrayWithObjects:@"\U0001F366", @"\uE33A", nil],
             [NSArray arrayWithObjects:@"\U0001F367", @"\uE43F", nil],
             [NSArray arrayWithObjects:@"\U0001F370", @"\uE046", nil],
             [NSArray arrayWithObjects:@"\U0001F371", @"\uE34C", nil],
             [NSArray arrayWithObjects:@"\U0001F372", @"\uE34D", nil],
             [NSArray arrayWithObjects:@"\U0001F373", @"\uE147", nil],
             [NSArray arrayWithObjects:@"\U0001F374", @"\uE043", nil],
             [NSArray arrayWithObjects:@"\U0001F375", @"\uE338", nil],
             [NSArray arrayWithObjects:@"\U0001F376", @"\uE30B", nil],
             [NSArray arrayWithObjects:@"\U0001F378", @"\uE044", nil],
             [NSArray arrayWithObjects:@"\U0001F37A", @"\uE047", nil],
             [NSArray arrayWithObjects:@"\U0001F37B", @"\uE30C", nil],
             [NSArray arrayWithObjects:@"\U0001F380", @"\uE314", nil],
             [NSArray arrayWithObjects:@"\U0001F381", @"\uE112", nil],
             [NSArray arrayWithObjects:@"\U0001F382", @"\uE34B", nil],
             [NSArray arrayWithObjects:@"\U0001F383", @"\uE445", nil],
             [NSArray arrayWithObjects:@"\U0001F384", @"\uE033", nil],
             [NSArray arrayWithObjects:@"\U0001F385", @"\uE448", nil],
             [NSArray arrayWithObjects:@"\U0001F386", @"\uE117", nil],
             [NSArray arrayWithObjects:@"\U0001F387", @"\uE440", nil],
             [NSArray arrayWithObjects:@"\U0001F388", @"\uE310", nil],
             [NSArray arrayWithObjects:@"\U0001F389", @"\uE312", nil],
             [NSArray arrayWithObjects:@"\U0001F38C", @"\uE143", nil],
             [NSArray arrayWithObjects:@"\U0001F38D", @"\uE436", nil],
             [NSArray arrayWithObjects:@"\U0001F38E", @"\uE438", nil],
             [NSArray arrayWithObjects:@"\U0001F38F", @"\uE43B", nil],
             [NSArray arrayWithObjects:@"\U0001F390", @"\uE442", nil],
             [NSArray arrayWithObjects:@"\U0001F391", @"\uE446", nil],
             [NSArray arrayWithObjects:@"\U0001F392", @"\uE43A", nil],
             [NSArray arrayWithObjects:@"\U0001F393", @"\uE439", nil],
             [NSArray arrayWithObjects:@"\U0001F3A1", @"\uE124", nil],
             [NSArray arrayWithObjects:@"\U0001F3A2", @"\uE433", nil],
             [NSArray arrayWithObjects:@"\U0001F3A4", @"\uE03C", nil],
             [NSArray arrayWithObjects:@"\U0001F3A5", @"\uE03D", nil],
             [NSArray arrayWithObjects:@"\U0001F3A6", @"\uE507", nil],
             [NSArray arrayWithObjects:@"\U0001F3A7", @"\uE30A", nil],
             [NSArray arrayWithObjects:@"\U0001F3A8", @"\uE502", nil],
             [NSArray arrayWithObjects:@"\U0001F3A9", @"\uE503", nil],
             [NSArray arrayWithObjects:@"\U0001F3AB", @"\uE125", nil],
             [NSArray arrayWithObjects:@"\U0001F3AC", @"\uE324", nil],
             [NSArray arrayWithObjects:@"\U0001F3AF", @"\uE130", nil],
             [NSArray arrayWithObjects:@"\U0001F3B0", @"\uE133", nil],
             [NSArray arrayWithObjects:@"\U0001F3B1", @"\uE42C", nil],
             [NSArray arrayWithObjects:@"\U0001F3B5", @"\uE03E", nil],
             [NSArray arrayWithObjects:@"\U0001F3B6", @"\uE326", nil],
             [NSArray arrayWithObjects:@"\U0001F3B7", @"\uE040", nil],
             [NSArray arrayWithObjects:@"\U0001F3B8", @"\uE041", nil],
             [NSArray arrayWithObjects:@"\U0001F3BA", @"\uE042", nil],
             [NSArray arrayWithObjects:@"\U0001F3BE", @"\uE015", nil],
             [NSArray arrayWithObjects:@"\U0001F3BF", @"\uE013", nil],
             [NSArray arrayWithObjects:@"\U0001F3C0", @"\uE42A", nil],
             [NSArray arrayWithObjects:@"\U0001F3C1", @"\uE132", nil],
             [NSArray arrayWithObjects:@"\U0001F3C3", @"\uE115", nil],
             [NSArray arrayWithObjects:@"\U0001F3C4", @"\uE017", nil],
             [NSArray arrayWithObjects:@"\U0001F3C6", @"\uE131", nil],
             [NSArray arrayWithObjects:@"\U0001F3C8", @"\uE42B", nil],
             [NSArray arrayWithObjects:@"\U0001F3CA", @"\uE42D", nil],
             [NSArray arrayWithObjects:@"\U0001F3E0", @"\uE036", nil],
             [NSArray arrayWithObjects:@"\U0001F3E2", @"\uE038", nil],
             [NSArray arrayWithObjects:@"\U0001F3E3", @"\uE153", nil],
             [NSArray arrayWithObjects:@"\U0001F3E5", @"\uE155", nil],
             [NSArray arrayWithObjects:@"\U0001F3E6", @"\uE14D", nil],
             [NSArray arrayWithObjects:@"\U0001F3E7", @"\uE154", nil],
             [NSArray arrayWithObjects:@"\U0001F3E8", @"\uE158", nil],
             [NSArray arrayWithObjects:@"\U0001F3E9", @"\uE501", nil],
             [NSArray arrayWithObjects:@"\U0001F3EA", @"\uE156", nil],
             [NSArray arrayWithObjects:@"\U0001F3EB", @"\uE157", nil],
             [NSArray arrayWithObjects:@"\U0001F3EC", @"\uE504", nil],
             [NSArray arrayWithObjects:@"\U0001F3ED", @"\uE508", nil],
             [NSArray arrayWithObjects:@"\U0001F3EF", @"\uE505", nil],
             [NSArray arrayWithObjects:@"\U0001F3F0", @"\uE506", nil],
             [NSArray arrayWithObjects:@"\U0001F40D", @"\uE52D", nil],
             [NSArray arrayWithObjects:@"\U0001F40E", @"\uE134", nil],
             [NSArray arrayWithObjects:@"\U0001F411", @"\uE529", nil],
             [NSArray arrayWithObjects:@"\U0001F412", @"\uE528", nil],
             [NSArray arrayWithObjects:@"\U0001F414", @"\uE52E", nil],
             [NSArray arrayWithObjects:@"\U0001F417", @"\uE52F", nil],
             [NSArray arrayWithObjects:@"\U0001F418", @"\uE526", nil],
             [NSArray arrayWithObjects:@"\U0001F419", @"\uE10A", nil],
             [NSArray arrayWithObjects:@"\U0001F41A", @"\uE441", nil],
             [NSArray arrayWithObjects:@"\U0001F41B", @"\uE525", nil],
             [NSArray arrayWithObjects:@"\U0001F41F", @"\uE019", nil],
             [NSArray arrayWithObjects:@"\U0001F420", @"\uE522", nil],
             [NSArray arrayWithObjects:@"\U0001F424", @"\uE523", nil],
             [NSArray arrayWithObjects:@"\U0001F426", @"\uE521", nil],
             [NSArray arrayWithObjects:@"\U0001F427", @"\uE055", nil],
             [NSArray arrayWithObjects:@"\U0001F428", @"\uE527", nil],
             [NSArray arrayWithObjects:@"\U0001F42B", @"\uE530", nil],
             [NSArray arrayWithObjects:@"\U0001F42C", @"\uE520", nil],
             [NSArray arrayWithObjects:@"\U0001F42D", @"\uE053", nil],
             [NSArray arrayWithObjects:@"\U0001F42E", @"\uE52B", nil],
             [NSArray arrayWithObjects:@"\U0001F42F", @"\uE050", nil],
             [NSArray arrayWithObjects:@"\U0001F430", @"\uE52C", nil],
             [NSArray arrayWithObjects:@"\U0001F431", @"\uE04F", nil],
             [NSArray arrayWithObjects:@"\U0001F433", @"\uE054", nil],
             [NSArray arrayWithObjects:@"\U0001F434", @"\uE01A", nil],
             [NSArray arrayWithObjects:@"\U0001F435", @"\uE109", nil],
             [NSArray arrayWithObjects:@"\U0001F436", @"\uE052", nil],
             [NSArray arrayWithObjects:@"\U0001F437", @"\uE10B", nil],
             [NSArray arrayWithObjects:@"\U0001F438", @"\uE531", nil],
             [NSArray arrayWithObjects:@"\U0001F439", @"\uE524", nil],
             [NSArray arrayWithObjects:@"\U0001F43A", @"\uE52A", nil],
             [NSArray arrayWithObjects:@"\U0001F43B", @"\uE051", nil],
             [NSArray arrayWithObjects:@"\U0001F440", @"\uE419", nil],
             [NSArray arrayWithObjects:@"\U0001F442", @"\uE41B", nil],
             [NSArray arrayWithObjects:@"\U0001F443", @"\uE41A", nil],
             [NSArray arrayWithObjects:@"\U0001F444", @"\uE41C", nil],
             [NSArray arrayWithObjects:@"\U0001F446", @"\uE22E", nil],
             [NSArray arrayWithObjects:@"\U0001F447", @"\uE22F", nil],
             [NSArray arrayWithObjects:@"\U0001F448", @"\uE230", nil],
             [NSArray arrayWithObjects:@"\U0001F449", @"\uE231", nil],
             [NSArray arrayWithObjects:@"\U0001F44A", @"\uE00D", nil],
             [NSArray arrayWithObjects:@"\U0001F44B", @"\uE41E", nil],
             [NSArray arrayWithObjects:@"\U0001F44C", @"\uE420", nil],
             [NSArray arrayWithObjects:@"\U0001F44D", @"\uE00E", nil],
             [NSArray arrayWithObjects:@"\U0001F44E", @"\uE421", nil],
             [NSArray arrayWithObjects:@"\U0001F44F", @"\uE41F", nil],
             [NSArray arrayWithObjects:@"\U0001F450", @"\uE422", nil],
             [NSArray arrayWithObjects:@"\U0001F451", @"\uE10E", nil],
             [NSArray arrayWithObjects:@"\U0001F452", @"\uE318", nil],
             [NSArray arrayWithObjects:@"\U0001F454", @"\uE302", nil],
             [NSArray arrayWithObjects:@"\U0001F455", @"\uE006", nil],
             [NSArray arrayWithObjects:@"\U0001F457", @"\uE319", nil],
             [NSArray arrayWithObjects:@"\U0001F458", @"\uE321", nil],
             [NSArray arrayWithObjects:@"\U0001F459", @"\uE322", nil],
             [NSArray arrayWithObjects:@"\U0001F45C", @"\uE323", nil],
             [NSArray arrayWithObjects:@"\U0001F45F", @"\uE007", nil],
             [NSArray arrayWithObjects:@"\U0001F460", @"\uE13E", nil],
             [NSArray arrayWithObjects:@"\U0001F461", @"\uE31A", nil],
             [NSArray arrayWithObjects:@"\U0001F462", @"\uE31B", nil],
             [NSArray arrayWithObjects:@"\U0001F463", @"\uE536", nil],
             [NSArray arrayWithObjects:@"\U0001F466", @"\uE001", nil],
             [NSArray arrayWithObjects:@"\U0001F467", @"\uE002", nil],
             [NSArray arrayWithObjects:@"\U0001F468", @"\uE004", nil],
             [NSArray arrayWithObjects:@"\U0001F469", @"\uE005", nil],
             [NSArray arrayWithObjects:@"\U0001F46B", @"\uE428", nil],
             [NSArray arrayWithObjects:@"\U0001F46E", @"\uE152", nil],
             [NSArray arrayWithObjects:@"\U0001F46F", @"\uE429", nil],
             [NSArray arrayWithObjects:@"\U0001F471", @"\uE515", nil],
             [NSArray arrayWithObjects:@"\U0001F472", @"\uE516", nil],
             [NSArray arrayWithObjects:@"\U0001F473", @"\uE517", nil],
             [NSArray arrayWithObjects:@"\U0001F474", @"\uE518", nil],
             [NSArray arrayWithObjects:@"\U0001F475", @"\uE519", nil],
             [NSArray arrayWithObjects:@"\U0001F476", @"\uE51A", nil],
             [NSArray arrayWithObjects:@"\U0001F477", @"\uE51B", nil],
             [NSArray arrayWithObjects:@"\U0001F478", @"\uE51C", nil],
             [NSArray arrayWithObjects:@"\U0001F47B", @"\uE11B", nil],
             [NSArray arrayWithObjects:@"\U0001F47C", @"\uE04E", nil],
             [NSArray arrayWithObjects:@"\U0001F47D", @"\uE10C", nil],
             [NSArray arrayWithObjects:@"\U0001F47E", @"\uE12B", nil],
             [NSArray arrayWithObjects:@"\U0001F47F", @"\uE11A", nil],
             [NSArray arrayWithObjects:@"\U0001F480", @"\uE11C", nil],
             [NSArray arrayWithObjects:@"\U0001F481", @"\uE253", nil],
             [NSArray arrayWithObjects:@"\U0001F482", @"\uE51E", nil],
             [NSArray arrayWithObjects:@"\U0001F483", @"\uE51F", nil],
             [NSArray arrayWithObjects:@"\U0001F484", @"\uE31C", nil],
             [NSArray arrayWithObjects:@"\U0001F485", @"\uE31D", nil],
             [NSArray arrayWithObjects:@"\U0001F486", @"\uE31E", nil],
             [NSArray arrayWithObjects:@"\U0001F487", @"\uE31F", nil],
             [NSArray arrayWithObjects:@"\U0001F488", @"\uE320", nil],
             [NSArray arrayWithObjects:@"\U0001F489", @"\uE13B", nil],
             [NSArray arrayWithObjects:@"\U0001F48A", @"\uE30F", nil],
             [NSArray arrayWithObjects:@"\U0001F48B", @"\uE003", nil],
             [NSArray arrayWithObjects:@"\U0001F48D", @"\uE034", nil],
             [NSArray arrayWithObjects:@"\U0001F48E", @"\uE035", nil],
             [NSArray arrayWithObjects:@"\U0001F48F", @"\uE111", nil],
             [NSArray arrayWithObjects:@"\U0001F490", @"\uE306", nil],
             [NSArray arrayWithObjects:@"\U0001F491", @"\uE425", nil],
             [NSArray arrayWithObjects:@"\U0001F492", @"\uE43D", nil],
             [NSArray arrayWithObjects:@"\U0001F493", @"\uE327", nil],
             [NSArray arrayWithObjects:@"\U0001F494", @"\uE023", nil],
             [NSArray arrayWithObjects:@"\U0001F497", @"\uE328", nil],
             [NSArray arrayWithObjects:@"\U0001F498", @"\uE329", nil],
             [NSArray arrayWithObjects:@"\U0001F499", @"\uE32A", nil],
             [NSArray arrayWithObjects:@"\U0001F49A", @"\uE32B", nil],
             [NSArray arrayWithObjects:@"\U0001F49B", @"\uE32C", nil],
             [NSArray arrayWithObjects:@"\U0001F49C", @"\uE32D", nil],
             [NSArray arrayWithObjects:@"\U0001F49D", @"\uE437", nil],
             [NSArray arrayWithObjects:@"\U0001F49F", @"\uE204", nil],
             [NSArray arrayWithObjects:@"\U0001F4A1", @"\uE10F", nil],
             [NSArray arrayWithObjects:@"\U0001F4A2", @"\uE334", nil],
             [NSArray arrayWithObjects:@"\U0001F4A3", @"\uE311", nil],
             [NSArray arrayWithObjects:@"\U0001F4A4", @"\uE13C", nil],
             [NSArray arrayWithObjects:@"\U0001F4A6", @"\uE331", nil],
             [NSArray arrayWithObjects:@"\U0001F4A8", @"\uE330", nil],
             [NSArray arrayWithObjects:@"\U0001F4A9", @"\uE05A", nil],
             [NSArray arrayWithObjects:@"\U0001F4AA", @"\uE14C", nil],
             [NSArray arrayWithObjects:@"\U0001F4B0", @"\uE12F", nil],
             [NSArray arrayWithObjects:@"\U0001F4B1", @"\uE149", nil],
             [NSArray arrayWithObjects:@"\U0001F4B9", @"\uE14A", nil],
             [NSArray arrayWithObjects:@"\U0001F4BA", @"\uE11F", nil],
             [NSArray arrayWithObjects:@"\U0001F4BB", @"\uE00C", nil],
             [NSArray arrayWithObjects:@"\U0001F4BC", @"\uE11E", nil],
             [NSArray arrayWithObjects:@"\U0001F4BD", @"\uE316", nil],
             [NSArray arrayWithObjects:@"\U0001F4BF", @"\uE126", nil],
             [NSArray arrayWithObjects:@"\U0001F4C0", @"\uE127", nil],
             [NSArray arrayWithObjects:@"\U0001F4D6", @"\uE148", nil],
             [NSArray arrayWithObjects:@"\U0001F4DD", @"\uE301", nil],
             [NSArray arrayWithObjects:@"\U0001F4E0", @"\uE00B", nil],
             [NSArray arrayWithObjects:@"\U0001F4E1", @"\uE14B", nil],
             [NSArray arrayWithObjects:@"\U0001F4E2", @"\uE142", nil],
             [NSArray arrayWithObjects:@"\U0001F4E3", @"\uE317", nil],
             [NSArray arrayWithObjects:@"\U0001F4E9", @"\uE103", nil],
             [NSArray arrayWithObjects:@"\U0001F4EB", @"\uE101", nil],
             [NSArray arrayWithObjects:@"\U0001F4EE", @"\uE102", nil],
             [NSArray arrayWithObjects:@"\U0001F4F1", @"\uE00A", nil],
             [NSArray arrayWithObjects:@"\U0001F4F2", @"\uE104", nil],
             [NSArray arrayWithObjects:@"\U0001F4F3", @"\uE250", nil],
             [NSArray arrayWithObjects:@"\U0001F4F4", @"\uE251", nil],
             [NSArray arrayWithObjects:@"\U0001F4F6", @"\uE20B", nil],
             [NSArray arrayWithObjects:@"\U0001F4F7", @"\uE008", nil],
             [NSArray arrayWithObjects:@"\U0001F4FA", @"\uE12A", nil],
             [NSArray arrayWithObjects:@"\U0001F4FB", @"\uE128", nil],
             [NSArray arrayWithObjects:@"\U0001F4FC", @"\uE129", nil],
             [NSArray arrayWithObjects:@"\U0001F50A", @"\uE141", nil],
             [NSArray arrayWithObjects:@"\U0001F50D", @"\uE114", nil],
             [NSArray arrayWithObjects:@"\U0001F511", @"\uE03F", nil],
             [NSArray arrayWithObjects:@"\U0001F512", @"\uE144", nil],
             [NSArray arrayWithObjects:@"\U0001F513", @"\uE145", nil],
             [NSArray arrayWithObjects:@"\U0001F514", @"\uE325", nil],
             [NSArray arrayWithObjects:@"\U0001F51D", @"\uE24C", nil],
             [NSArray arrayWithObjects:@"\U0001F51E", @"\uE207", nil],
             [NSArray arrayWithObjects:@"\U0001F525", @"\uE11D", nil],
             [NSArray arrayWithObjects:@"\U0001F528", @"\uE116", nil],
             [NSArray arrayWithObjects:@"\U0001F52B", @"\uE113", nil],
             [NSArray arrayWithObjects:@"\U0001F52F", @"\uE23E", nil],
             [NSArray arrayWithObjects:@"\U0001F530", @"\uE209", nil],
             [NSArray arrayWithObjects:@"\U0001F531", @"\uE031", nil],
             [NSArray arrayWithObjects:@"\U0001F532", @"\uE21A", nil],
             [NSArray arrayWithObjects:@"\U0001F533", @"\uE21B", nil],
             [NSArray arrayWithObjects:@"\U0001F534", @"\uE219", nil],
             [NSArray arrayWithObjects:@"\U0001F550", @"\uE024", nil],
             [NSArray arrayWithObjects:@"\U0001F551", @"\uE025", nil],
             [NSArray arrayWithObjects:@"\U0001F552", @"\uE026", nil],
             [NSArray arrayWithObjects:@"\U0001F553", @"\uE027", nil],
             [NSArray arrayWithObjects:@"\U0001F554", @"\uE028", nil],
             [NSArray arrayWithObjects:@"\U0001F555", @"\uE029", nil],
             [NSArray arrayWithObjects:@"\U0001F556", @"\uE02A", nil],
             [NSArray arrayWithObjects:@"\U0001F557", @"\uE02B", nil],
             [NSArray arrayWithObjects:@"\U0001F558", @"\uE02C", nil],
             [NSArray arrayWithObjects:@"\U0001F559", @"\uE02D", nil],
             [NSArray arrayWithObjects:@"\U0001F55A", @"\uE02E", nil],
             [NSArray arrayWithObjects:@"\U0001F55B", @"\uE02F", nil],
             [NSArray arrayWithObjects:@"\U0001F5FB", @"\uE03B", nil],
             [NSArray arrayWithObjects:@"\U0001F5FC", @"\uE509", nil],
             [NSArray arrayWithObjects:@"\U0001F5FD", @"\uE51D", nil],
             [NSArray arrayWithObjects:@"\U0001F601", @"\uE404", nil],
             [NSArray arrayWithObjects:@"\U0001F602", @"\uE412", nil],
             [NSArray arrayWithObjects:@"\U0001F603", @"\uE057", nil],
             [NSArray arrayWithObjects:@"\U0001F604", @"\uE415", nil],
             [NSArray arrayWithObjects:@"\U0001F609", @"\uE405", nil],
             [NSArray arrayWithObjects:@"\U0001F60A", @"\uE056", nil],
             [NSArray arrayWithObjects:@"\U0001F60C", @"\uE40A", nil],
             [NSArray arrayWithObjects:@"\U0001F60D", @"\uE106", nil],
             [NSArray arrayWithObjects:@"\U0001F60F", @"\uE402", nil],
             [NSArray arrayWithObjects:@"\U0001F612", @"\uE40E", nil],
             [NSArray arrayWithObjects:@"\U0001F613", @"\uE108", nil],
             [NSArray arrayWithObjects:@"\U0001F614", @"\uE403", nil],
             [NSArray arrayWithObjects:@"\U0001F616", @"\uE407", nil],
             [NSArray arrayWithObjects:@"\U0001F618", @"\uE418", nil],
             [NSArray arrayWithObjects:@"\U0001F61A", @"\uE417", nil],
             [NSArray arrayWithObjects:@"\U0001F61C", @"\uE105", nil],
             [NSArray arrayWithObjects:@"\U0001F61D", @"\uE409", nil],
             [NSArray arrayWithObjects:@"\U0001F61E", @"\uE058", nil],
             [NSArray arrayWithObjects:@"\U0001F620", @"\uE059", nil],
             [NSArray arrayWithObjects:@"\U0001F621", @"\uE416", nil],
             [NSArray arrayWithObjects:@"\U0001F622", @"\uE413", nil],
             [NSArray arrayWithObjects:@"\U0001F623", @"\uE406", nil],
             [NSArray arrayWithObjects:@"\U0001F625", @"\uE401", nil],
             [NSArray arrayWithObjects:@"\U0001F628", @"\uE40B", nil],
             [NSArray arrayWithObjects:@"\U0001F62A", @"\uE408", nil],
             [NSArray arrayWithObjects:@"\U0001F62D", @"\uE411", nil],
             [NSArray arrayWithObjects:@"\U0001F630", @"\uE40F", nil],
             [NSArray arrayWithObjects:@"\U0001F631", @"\uE107", nil],
             [NSArray arrayWithObjects:@"\U0001F632", @"\uE410", nil],
             [NSArray arrayWithObjects:@"\U0001F633", @"\uE40D", nil],
             [NSArray arrayWithObjects:@"\U0001F637", @"\uE40C", nil],
             [NSArray arrayWithObjects:@"\U0001F645", @"\uE423", nil],
             [NSArray arrayWithObjects:@"\U0001F646", @"\uE424", nil],
             [NSArray arrayWithObjects:@"\U0001F647", @"\uE426", nil],
             [NSArray arrayWithObjects:@"\U0001F64C", @"\uE427", nil],
             [NSArray arrayWithObjects:@"\U0001F64F", @"\uE41D", nil],
             [NSArray arrayWithObjects:@"\U0001F680", @"\uE10D", nil],
             [NSArray arrayWithObjects:@"\U0001F683", @"\uE01E", nil],
             [NSArray arrayWithObjects:@"\U0001F684", @"\uE435", nil],
             [NSArray arrayWithObjects:@"\U0001F685", @"\uE01F", nil],
             [NSArray arrayWithObjects:@"\U0001F687", @"\uE434", nil],
             [NSArray arrayWithObjects:@"\U0001F689", @"\uE039", nil],
             [NSArray arrayWithObjects:@"\U0001F68C", @"\uE159", nil],
             [NSArray arrayWithObjects:@"\U0001F68F", @"\uE150", nil],
             [NSArray arrayWithObjects:@"\U0001F691", @"\uE431", nil],
             [NSArray arrayWithObjects:@"\U0001F692", @"\uE430", nil],
             [NSArray arrayWithObjects:@"\U0001F693", @"\uE432", nil],
             [NSArray arrayWithObjects:@"\U0001F695", @"\uE15A", nil],
             [NSArray arrayWithObjects:@"\U0001F697", @"\uE01B", nil],
             [NSArray arrayWithObjects:@"\U0001F699", @"\uE42E", nil],
             [NSArray arrayWithObjects:@"\U0001F69A", @"\uE42F", nil],
             [NSArray arrayWithObjects:@"\U0001F6A2", @"\uE202", nil],
             [NSArray arrayWithObjects:@"\U0001F6A4", @"\uE135", nil],
             [NSArray arrayWithObjects:@"\U0001F6A5", @"\uE14E", nil],
             [NSArray arrayWithObjects:@"\U0001F6A7", @"\uE137", nil],
             [NSArray arrayWithObjects:@"\U0001F6AC", @"\uE30E", nil],
             [NSArray arrayWithObjects:@"\U0001F6AD", @"\uE208", nil],
             [NSArray arrayWithObjects:@"\U0001F6B2", @"\uE136", nil],
             [NSArray arrayWithObjects:@"\U0001F6B6", @"\uE201", nil],
             [NSArray arrayWithObjects:@"\U0001F6B9", @"\uE138", nil],
             [NSArray arrayWithObjects:@"\U0001F6BA", @"\uE139", nil],
             [NSArray arrayWithObjects:@"\U0001F6BB", @"\uE151", nil],
             [NSArray arrayWithObjects:@"\U0001F6BC", @"\uE13A", nil],
             [NSArray arrayWithObjects:@"\U0001F6BD", @"\uE140", nil],
             [NSArray arrayWithObjects:@"\U0001F6BE", @"\uE309", nil],
             [NSArray arrayWithObjects:@"\U0001F6C0", @"\uE13F", nil],
             nil];
    
}

+(NSArray *)matchesInString:(NSString *)reges string:(NSString *)content
{
    NSRegularExpression *exp_emoji =
    [[NSRegularExpression alloc] initWithPattern:reges
                                         options:NSRegularExpressionCaseInsensitive| NSRegularExpressionDotMatchesLineSeparators
                                           error:nil];
    return  [exp_emoji matchesInString:content
                               options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                 range:NSMakeRange(0, [content length])];
    
}
+(NSDictionary *)faceDic
{
    return [NSDictionary dictionaryWithObjects:[self getDefaultImageArray] forKeys:[self getDefaultNameArray]];
}
+(NSDictionary *)faceParser
{
    static dispatch_once_t onceToken;
    static NSMutableDictionary *mapper=nil;
    dispatch_once(&onceToken, ^{
        mapper=[NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *str in [self faceDic]) {
            NSString *img=[[self faceDic]objectForKey:str];
            mapper[str] = ImageNamed(img);
        }
    });
    return mapper;
}

+(NSMutableAttributedString *)matchesInUrlLink:(NSMutableAttributedString *)content
{
//    NSArray *https = [self matchesInString:kRegexURLlink string:content.string];
    return content;
}
+(NSMutableAttributedString *)matchesInNumber:(NSMutableAttributedString *)content
{
//    NSArray *number = [self matchesInString:kRegexPhonenum string:content.string ];
    return content;
}

+(NSMutableAttributedString *)attingWithStr:(NSString *)content font:(UIFont *)font codeType:(SYAttStringCode)codeString
{
//    NSArray *emojis = [self matchesInString:kRegexEmoji string:content ];
    
    NSMutableAttributedString *newStr = [content attributedStringFromStingWithFont:font];
    [newStr faceAttringResetEmoji];
    
    if (codeString&SYAttString_line) {
        [self matchesInUrlLink:newStr];
    }
    if (codeString&SYAttString_number) {
        [self matchesInNumber:newStr];
    }
    return newStr;
}
+(YYTextSimpleEmoticonParser *)textParse
{
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = [self faceParser];
    return parser;
}
+(SYTextSimpleEmoticonParser *)syTextParse
{
    SYTextSimpleEmoticonParser *parse=[SYTextSimpleEmoticonParser new];
    parse.emoticonMapper=[self  faceParser];
    return parse;
}

+(BOOL)deleKeyChars:(id)textView
{
    if (!textView) {
        return YES;
    }
    if ([textView conformsToProtocol:@protocol(UITextInput)] && [textView respondsToSelector:@selector(setInputView:)]) {
        UIResponder<UITextInput> *textInput=(UIResponder<UITextInput> *)textView;
        if (!textInput.selectedTextRange.empty) {
            return YES;
        }
        NSString *text = [textInput textInRange:[textInput textRangeFromPosition:textInput.beginningOfDocument toPosition:textInput.selectedTextRange.start]];
        if ([self matchesInString:kRegexEmoji string:text ].count) {
            for (NSString *emoji in [SYEmojiVIewObject getDefaultNameArray]) {
                if ([text hasSuffix:emoji]) {
                    __block NSUInteger composedCharacterLength = 0;
                    [emoji enumerateSubstringsInRange:NSMakeRange(0, emoji.length)
                                              options:NSStringEnumerationByComposedCharacterSequences
                                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                                               composedCharacterLength++;
                                           }];
                    UITextRange *rangeToDelete = [textInput textRangeFromPosition:[textInput positionFromPosition:textInput.selectedTextRange.start offset:-composedCharacterLength] toPosition:textInput.selectedTextRange.start];
                    if (rangeToDelete) {
                        [textInput replaceRange:rangeToDelete withText:@""];
                        return NO;
                        
                    }
                    return YES;
                    
                }
            }
        }
    }
    return YES;
}

@end
