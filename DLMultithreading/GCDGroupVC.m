//
//  GCDGroupVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/7.
//  Copyright © 2018年 David. All rights reserved.
//

#import "GCDGroupVC.h"

@interface GCDGroupVC ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GCDGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)download:(id)sender {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    __block UIImage *image = nil;
    dispatch_group_async(group, globalQueue, ^{
        NSURL *imageURL = [NSURL URLWithString:@"https://images.unsplash.com/photo-1494698852314-652666555934?ixlib=rb-0.3.5&s=3dd23e2727cd56c0c2f4ec8627984a41&auto=format&fit=crop&w=800&q=40"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        image  = [UIImage imageWithData:imageData];
    });
    
    __block UIImage *image1 = nil;
    dispatch_group_async(group, globalQueue, ^{
        NSURL *imageURL1 = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Logo_of_Unsplash.svg/2000px-Logo_of_Unsplash.svg.png"];
        NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
        image1 = [UIImage imageWithData:imageData1];
    });
    
    dispatch_group_notify(group, globalQueue, ^{
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width * 0.06, image1.size.height * 0.06)];
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = fullImage;
        });
    });
}


@end
