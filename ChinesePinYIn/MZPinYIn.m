//
//  MZPinYIn.m
//  ChinesePinYIn
//
//  Created by Mr.Yang on 16/9/9.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "MZPinYIn.h"

@implementation MZPinYIn
/**
 *  汉字转化为拼音分组并排序
 *
 *  @param array 需要转化的数组 ，数组中的元素需要是字典，其中汉字名的key是@"name"
 *
 *  @return <#return value description#>
 */
+ (NSArray *)chinesePinYinGroupUp:(NSArray *)array {
    
    //1.转化为拼音并分组
    NSMutableArray * pinyinArray = [NSMutableArray arrayWithCapacity:0];//拼音数组
    NSString * obj_name = @"";//名字
    NSString * initialChar = @"";//所在分组拼音（大写）
    NSString * initials = @"";//每个字的首字母（小写）
    NSString * pinyin = @"";//拼音（小写）
    NSString * temp = @"";
    
    for (int i = 0; i < array.count; i ++) {
        
        obj_name = array[i][@"name"];//名字
        initialChar = @"";//所在分组拼音（大写）
        initials = @"";//每个字的首字母（小写）
        pinyin = @"";//拼音（小写）
        temp = @"";
        
        for (int j = 0; j < obj_name.length; j ++) {
            
            NSMutableString *tempChar = [[obj_name substringWithRange:NSMakeRange(j, 1)] mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)tempChar, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)tempChar, NULL, kCFStringTransformStripCombiningMarks, NO);
            NSString * onepinyin = [tempChar uppercaseString] ;//字拼音
            NSString * Firstpinyin = [[onepinyin substringWithRange:NSMakeRange(0, 1)] uppercaseString];//首拼音大写
            if (0 == j) {
                initialChar = [Firstpinyin copy];
            }
            temp = [initials copy];
            initials = [temp stringByAppendingString:[Firstpinyin lowercaseString]];//追加每个字的首字母（小写）
            
            temp = [pinyin copy];
            pinyin = [[temp stringByAppendingString:onepinyin] lowercaseString];
            //追加拼音（小写）
        }
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
        [dic setValue:obj_name forKey:@"obj_name"];
        [dic setValue:initials forKey:@"initials"];
        [dic setValue:pinyin forKey:@"pinyin"];
        [dic setValue:obj_name forKey:@"short_name"];
        [dic setValue:initialChar forKey:@"initialChar"];
        
        if (0 == i) {
            MyJSON * jsona = [[MyJSON alloc] init];
            jsona.initial = initialChar;
            [jsona.array addObject:dic];
            [pinyinArray addObject:jsona];
        } else {
            for (int k = 0; k < pinyinArray.count; k ++) {
                MyJSON * jsonb = (MyJSON *)pinyinArray[k];
                if ([initialChar isEqualToString:jsonb.initial]) {
                    [jsonb.array addObject:dic];
                    break;
                } else  if (![initialChar isEqualToString:jsonb.initial] && k == pinyinArray.count - 1) {
                    MyJSON * jsona = [[MyJSON alloc] init];
                    jsona.initial = initialChar;
                    [jsona.array addObject:dic];
                    [pinyinArray addObject:jsona];
                    break;//防止改变后又执行一次
                }
            }
        }
    }
    
    NSLog(@"%@", pinyinArray);
    //2.组排序
    NSArray * pintempArray = [pinyinArray copy];
    NSArray * resultGroup = [pintempArray sortedArrayUsingFunction:sortByGroup context:nil];
    
    //3.组内排序
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:0];
    for (MyJSON * json in resultGroup) {
        NSArray * jsonarraytemp = [json.array copy];
        NSArray * tempResultArray = [jsonarraytemp sortedArrayUsingFunction:sortByOne context:nil];
        MyJSON * tempJson = [[MyJSON alloc] init];
        tempJson.initial = json.initial;
        tempJson.array = [tempResultArray copy];
        [result addObject:tempJson];
    }
    return [result copy];
}
//组排序
NSInteger sortByGroup(id obj1, id obj2, void *context){
    MyJSON * json1 = (MyJSON *)obj1;
    MyJSON * json2 = (MyJSON *)obj2;
    return [json1.initial localizedCompare:json2.initial];
}
//组内排序
NSInteger sortByOne(id obj1, id obj2, void *context){
    NSDictionary * pinyin1 = (NSDictionary *)obj1;
    NSDictionary * pinyin2 = (NSDictionary *)obj2;
    return [pinyin1[@"pinyin"] localizedCompare:pinyin2[@"pinyin"]];
}

@end





@implementation MyJSON
-(NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}
@end
