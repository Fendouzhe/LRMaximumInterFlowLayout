//
//  ViewController.m
//  LRMaximumInteritemSpacing
//
//  Created by leilurong on 2018/8/28.
//  Copyright © 2018年 leilurong. All rights reserved.
//

#import "ViewController.h"
#import "LRCollectionViewCell.h"
#import "LRMaximumInterFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LRMaximumInterFlowLayoutDelegate>

@property (nonatomic, strong)NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"标签标签"
                      ,@"标签标签标签"
                      ,@"标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签标签标签标签标签标签签标签标签"
                      ,@"标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签"
                      ,@"标签标签标签标签标签标签标签标签标签标"
                      ,@"标签标签标签标签标签标签标签标"];
    
    LRMaximumInterFlowLayout *flowLayout = [[LRMaximumInterFlowLayout alloc] init];
    flowLayout.delegate = self;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    flowLayout.maximumInterSpacing = 12;
    flowLayout.minimumLineSpacing = 8;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[LRCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LRCollectionViewCell class])];
    [self.view addSubview:collectionView];
}

#pragma mark --  UICollectionViewDelegate,UICollectionViewDataSource --

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LRCollectionViewCell class]) forIndexPath:indexPath];
    cell.content = self.titleArr[indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark --  UICollectionViewDelegate,UICollectionViewDataSource --

- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [self.titleArr[indexPath.row] boundingRectWithSize:CGSizeMake(collectionView.bounds.size.width-collectionViewLayout.sectionInset.left-collectionViewLayout.sectionInset.right, 28) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return CGSizeMake(size.width+10, 28);
}

//- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(collectionView.bounds.size.width, 48);//CGSizeZero;
//}
//
//- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeZero;
//}


@end
