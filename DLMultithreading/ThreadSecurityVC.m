//
//  ThreadSecurityVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "ThreadSecurityVC.h"

@interface ThreadSecurityVC () {
    NSThread *_threadOne;
    NSThread *_threadTwo;
    NSThread *_threadThree;
    NSUInteger _leftTicket;
    NSLock *_lock;
}

@end

@implementation ThreadSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    _threadOne.name = @"windowOne";
    
    _threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    _threadTwo.name = @"windowTwo";
    
    _threadThree = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
    _threadThree.name = @"windowThree";
    
    _leftTicket = 30;
    _lock = [[NSLock alloc] init];
}

-(void)sale {
    while (1) {
        NSUInteger count  = _leftTicket;
        if (count > 0) {
            [NSThread sleepForTimeInterval:0.05];
            _leftTicket = count - 1;
            NSLog(@"%@ sale one ticket, %lu left", [NSThread currentThread].name, (unsigned long)_leftTicket);
        } else {
            [NSThread exit];
            return;
        }
        
//        @synchronized(self) {
//            NSUInteger count  = _leftTicket;
//            if (count > 0) {
//                [NSThread sleepForTimeInterval:0.05];
//                _leftTicket = count - 1;
//                NSLog(@"%@ sale one ticket, %ld left", [NSThread currentThread].name, _leftTicket);
//            } else {
//                [NSThread exit];
//                return;
//            }
//        }

        
//        [_lock lock];
//        NSUInteger count  = _leftTicket;
//        if (count > 0) {
//            [NSThread sleepForTimeInterval:0.05];
//            _leftTicket = count - 1;
//            NSLog(@"%@ sale one ticket, %ld left", [NSThread currentThread].name, _leftTicket);
//        } else {
//            [NSThread exit];
//            return;
//        }
//        [_lock unlock];
    }
}

- (IBAction)saleTicket:(id)sender {
    [_threadOne start];
    [_threadTwo start];
    [_threadThree start];
}

@end
