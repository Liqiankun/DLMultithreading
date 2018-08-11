//
//  DLOperation.h
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^Completion)(UIImage *image, NSIndexPath *indexPath);

@interface DLOperation : NSOperation

-(instancetype)initWithIconURL:(NSString *)iconURL indexPath:(NSIndexPath *)indexPath andCompletion:(Completion)completion;

@end
