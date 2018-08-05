//
//  NSThreadVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSThreadVC.h"

@interface NSThreadVC ()

@end

@implementation NSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)run{
    for (int i = 0; i < 10000; i++) {
        NSLog(@"currentThread - %@ i - %d, isMainThread - %d", [NSThread currentThread], i, [NSThread isMainThread]);
    }
}

- (IBAction)createThreadOne:(id)sender {
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
     NSLog(@"currentThread - %@ isMainThread - %d", [NSThread currentThread], [thread isMainThread]);
    [thread start];
}


- (IBAction)createThreadTwo:(id)sender {
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    NSLog(@"currentThread - %@", [NSThread currentThread]);
}

- (IBAction)createThreadThree:(id)sender {
    NSLog(@"isMainThread - %d", [NSThread isMainThread]);
    [self performSelectorInBackground:@selector(run) withObject:nil];
}



@end
