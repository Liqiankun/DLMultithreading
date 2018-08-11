//
//  DLWebImageVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import "DLWebImageVC.h"
#import "DLApp.h"
@interface DLWebImageVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray<DLApp *> *dataArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,strong) NSMutableDictionary *operationDic;
@property(nonatomic,strong) NSMutableDictionary *imageDic;
@end

@implementation DLWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] initWithArray:[DLApp prepareAppModels]];
    _queue = [[NSOperationQueue alloc] init];
    _operationDic = [[NSMutableDictionary alloc] init];
    _imageDic = [[NSMutableDictionary alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    DLApp *appModel = _dataArray[indexPath.row];
    cell.textLabel.text = appModel.name;
    cell.detailTextLabel.text = appModel.download;
    
    UIImage *currentImage  = _imageDic[appModel.icon];
    if (currentImage) {
        cell.imageView.image = currentImage;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"placeholder"];
        
        NSOperationQueue *currentOperation = _operationDic[appModel.icon];
        if (!currentOperation) {
            __block NSMutableDictionary *imageDic = _imageDic;
            __block NSMutableDictionary *operationDic = _operationDic;
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                NSURL *imageURL = [NSURL URLWithString:appModel.icon];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                UIImage *image = [UIImage imageWithData:imageData];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (image) {
                        imageDic[appModel.icon] = image;
                    }
                    [operationDic removeObjectForKey:appModel.icon];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
            _operationDic[appModel.icon] = operation;
            [_queue addOperation:operation];
        }
    }
    
    return cell;
}

@end
