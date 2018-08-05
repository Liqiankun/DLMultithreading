//
//  GCDCommunicationVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/5.
//  Copyright © 2018年 David. All rights reserved.
//

#import "GCDCommunicationVC.h"

@interface GCDCommunicationVC ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GCDCommunicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)download:(id)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *imageURL = [NSURL URLWithString:@"https://images.unsplash.com/photo-1494698852314-652666555934?ixlib=rb-0.3.5&s=3dd23e2727cd56c0c2f4ec8627984a41&auto=format&fit=crop&w=400&q=20"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
}


@end
