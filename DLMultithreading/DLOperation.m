//
//  DLOperation.m
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
 
#import "DLOperation.h"

@interface DLOperation()

@property(nonatomic, copy) NSString *iconURL;
@property(nonatomic, copy)Completion completion;
@property(nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation DLOperation

-(instancetype)initWithIconURL:(NSString *)iconURL indexPath:(NSIndexPath *)indexPath andCompletion:(Completion)completion {
    if (self = [super init]) {
        _iconURL = [iconURL copy];
        _indexPath = indexPath;
        _completion = completion;
    }
    return self;
}

-(void)main {
    @autoreleasepool{
        if (!self.isCancelled) {
            NSURL *imageURL = [NSURL URLWithString:_iconURL];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:imageData];
            
            __weak typeof(self) weakSelf = self;
            if (!self.isCancelled) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (weakSelf.completion) {
                        weakSelf.completion(image, weakSelf.indexPath);
                    }
                }];
            }
        }
    }
}

@end
