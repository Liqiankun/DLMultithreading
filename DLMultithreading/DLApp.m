//
//  DLApp.m
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import "DLApp.h"

@implementation DLApp

+(instancetype)appWithDic:(NSDictionary *)dic {
    DLApp *app = [[self alloc] init];
    [app setValuesForKeysWithDictionary:dic];
    return app;
}

+(NSArray<DLApp *> *)prepareAppModels {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        [modelArray addObject:[DLApp appWithDic:dic]];
    }
    return modelArray;
}

@end
