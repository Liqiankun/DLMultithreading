//
//  ThreadDelayVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/7.
//  Copyright © 2018年 David. All rights reserved.
//

#import "ThreadDelayVC.h"

@interface ThreadDelayVC ()

@end

@implementation ThreadDelayVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)threadDelay:(id)sender {
    NSLog(@"Delay begin");
    [NSThread sleepForTimeInterval:2];
    NSLog(@"Delay end");
}

- (IBAction)GCSDelay:(id)sender {
    NSLog(@"Delay begin");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"currentThread - %@", [NSThread currentThread]);
    });
    NSLog(@"Delay end");
}

- (IBAction)performDelay:(id)sender {
    NSLog(@"Delay begin");
    [self performSelector:@selector(run) withObject:nil afterDelay:2];
    NSLog(@"Delay end");
}

-(void)run {
    NSLog(@"currentThread - %@", [NSThread currentThread]);
}


@end
