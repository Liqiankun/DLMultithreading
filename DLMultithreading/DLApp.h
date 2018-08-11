//
//  DLApp.h
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLApp : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *download;

+(instancetype)appWithDic:(NSDictionary *)dic;

+(NSArray<DLApp *> *)prepareAppModels;

@end
