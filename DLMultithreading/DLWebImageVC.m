//
//  DLWebImageVC.m
//  DLMultithreading
//
//  Created by David on 2018/8/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import "DLWebImageVC.h"
#import "DLApp.h"
#import "DLOperation.h"

#define CACHE_IMAGE_PATH(imageName) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent: [imageName lastPathComponent]]

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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DLApp *appModel = _dataArray[indexPath.row];
    cell.textLabel.text = appModel.name;
    cell.detailTextLabel.text = appModel.download;
    
    UIImage *currentImage  = _imageDic[appModel.icon];
    if (currentImage) {
        cell.imageView.image = currentImage;
    } else {
        NSData *cacheImageData = [NSData dataWithContentsOfFile:CACHE_IMAGE_PATH(appModel.icon)];
        if (cacheImageData) {
            UIImage *cacheImage = [UIImage imageWithData:cacheImageData];
            cell.imageView.image = cacheImage;
            _imageDic[appModel.icon] = cacheImage;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"placeholder"];
            
            NSOperationQueue *currentOperation = _operationDic[appModel.icon];
            if (!currentOperation) {
                __weak typeof(self) weakSelf = self;
                DLOperation *operation = [[DLOperation alloc] initWithIconURL:appModel.icon indexPath:indexPath andCompletion:^(UIImage *image, NSIndexPath *indexPath) {
                    if (image) {
                        weakSelf.imageDic[appModel.icon] = image;
                        [UIImagePNGRepresentation(image) writeToFile:CACHE_IMAGE_PATH(appModel.icon) atomically:YES];
                    }
                    [weakSelf.operationDic removeObjectForKey:appModel.icon];
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
                _operationDic[appModel.icon] = operation;
                [_queue addOperation:operation];
            }
        }
    }
    
    return cell;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [_queue cancelAllOperations];
    [_operationDic removeAllObjects];
    [_imageDic removeAllObjects];
}

-(void)dealloc {
    NSLog(@"dealloc");
}

@end
