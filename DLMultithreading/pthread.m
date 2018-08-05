//
//  pthread.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "pthread.h"
#import <pthread.h>
@interface pthread ()

@end

@implementation pthread

void *run (void *data) {
    for (int i = 0; i < 10000; i++) {
        NSLog(@"currentThread - %@ i - %d", [NSThread currentThread], i);
    }
    return NULL;
}

- (IBAction)createThread:(id)sender {
    NSLog(@"currentThread - %@", [NSThread currentThread]);
    pthread_t thisRestrict;
    pthread_create(&thisRestrict, NULL, run, NULL);
}

@end
