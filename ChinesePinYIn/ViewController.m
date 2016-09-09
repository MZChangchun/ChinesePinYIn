//
//  ViewController.m
//  ChinesePinYIn
//
//  Created by Mr.Yang on 16/9/9.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "ViewController.h"
#import "MZPinYIn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = @[@{@"name":@"包李进",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"王大锤",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"王焦龙",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"附相遇",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"啊b",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"啊",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"王松",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"怂恿脸",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"使用",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"张永辉",@"dasdasd":@"hdkjhaskj"},
                        @{@"name":@"天天动听",@"dasdasd":@"hdkjhaskj"}];
    
    NSArray * arrayResult = [MZPinYIn chinesePinYinGroupUp:array];
    NSLog(@"%@",arrayResult);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
