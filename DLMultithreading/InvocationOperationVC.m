//
//  InvocationOperationVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/9.
//  Copyright © 2018年 David. All rights reserved.
//

#import "InvocationOperationVC.h"

@interface InvocationOperationVC ()

@end

@implementation InvocationOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)start:(id)sender {
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:self];
//    [operation start];
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self download];
    }];
    
//    [blockOperation addExecutionBlock:^{
//        [self download];
//    }];
//
//    [blockOperation addExecutionBlock:^{
//        [self download];
//    }];
    
    [blockOperation start];
}


- (IBAction)add:(id)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
//    queue.maxConcurrentOperationCount = 2;
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:self];
    [queue addOperation:operation];
    
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        [self download];
//    }];
//    [queue addOperation:blockOperation];
    
//    [queue addOperationWithBlock:^{
//        [self download];
//    }];
    
}

-(void)download {
    NSLog(@"currentThread - %@", [NSThread currentThread]);
}

@end
