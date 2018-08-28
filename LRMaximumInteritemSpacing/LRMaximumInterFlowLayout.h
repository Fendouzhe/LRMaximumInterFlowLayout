//
//  LRMaximumInterFlowLayout.h
//  LRMaximumInteritemSpacing
//
//  Created by leilurong on 2018/8/28.
//  Copyright © 2018年 leilurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRMaximumInterFlowLayout;

@protocol LRMaximumInterFlowLayoutDelegate <NSObject>


- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

- (CGSize)lr_collectionView:(UICollectionView *)collectionView layout:(LRMaximumInterFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

@end

@interface LRMaximumInterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak)id<LRMaximumInterFlowLayoutDelegate> delegate;

@property (nonatomic, assign)CGFloat maximumInterSpacing;

@end
