//
//  InvocationCommunicationVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/9.
//  Copyright © 2018年 David. All rights reserved.
//

#import "InvocationCommunicationVC.h"

@interface InvocationCommunicationVC ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation InvocationCommunicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)download:(id)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSURL *imageURL = [NSURL URLWithString:@"https://images.unsplash.com/photo-1494698852314-652666555934?ixlib=rb-0.3.5&s=3dd23e2727cd56c0c2f4ec8627984a41&auto=format&fit=crop&w=800&q=40"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = [UIImage imageWithData:imageData]  ;
        }];
    }];
}


@end
