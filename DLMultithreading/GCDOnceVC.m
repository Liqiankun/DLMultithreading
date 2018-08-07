//
//  GCDOnceVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/7.
//  Copyright © 2018年 David. All rights reserved.
//

#import "GCDOnceVC.h"

@interface GCDOnceVC ()

@end

@implementation GCDOnceVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)run:(id)sender {
    NSLog(@"begin");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once");
    });
    NSLog(@"end");
}



@end
