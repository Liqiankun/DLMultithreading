//
//  GCDSyncVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "GCDSyncVC.h"

@interface GCDSyncVC ()

@end

@implementation GCDSyncVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createThread:(id)sender {
    [self syncSerialQueue];
}

/**
 Sync Global Queue
 */
-(void)syncGlobalQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image one", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image two", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image three", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image four", [NSThread currentThread]);
    });
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
}

/**
 Sync Serial Queue
 */
-(void)syncSerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("dl_thread", NULL);
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image one", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image two", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image three", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"currentThread - %@, download image four", [NSThread currentThread]);
    });
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
}

@end
