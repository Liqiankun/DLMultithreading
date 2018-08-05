//
//  GCDAsyncVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "GCDAsyncVC.h"

@interface GCDAsyncVC ()

@end

@implementation GCDAsyncVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createThread:(id)sender {
    [self asyncGlobalQueue];
}

/**
 Async Global Queue
 */
-(void)asyncGlobalQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image one", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image two", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image three", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image four", [NSThread currentThread]);
    });
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
}

/**
 Async Serial Queue
 */
-(void)asyncSerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("dl_thread", NULL);
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image one", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image two", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image three", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image four", [NSThread currentThread]);
    });
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
}


/**
 Async Main Queue
 */
-(void)asyncMainQueue {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image one", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image two", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image three", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"currentThread - %@, download image four", [NSThread currentThread]);
    });
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
}



@end
