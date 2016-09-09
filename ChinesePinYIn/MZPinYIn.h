//
//  MZPinYIn.h
//  ChinesePinYIn
//
//  Created by Mr.Yang on 16/9/9.
//  Copyright © 2016年 MZ. All rights reserved.
//
/**
 *  排序算法 可以将自汉字数组转换成拼音并排序分组
 *
 */
#import <Foundation/Foundation.h>

@interface MZPinYIn : NSObject
+ (NSArray *)chinesePinYinGroupUp:(NSArray *)array;
@end



@interface MyJSON : NSObject

@property (nonatomic, copy)NSString * initial;
@property (nonatomic, strong)NSMutableArray * array;



@end
