//
//  LRMaximumInterFlowLayout.m
//  LRMaximumInteritemSpacing
//
//  Created by leilurong on 2018/8/28.
//  Copyright © 2018年 leilurong. All rights reserved.
//

#import "LRMaximumInterFlowLayout.h"

@interface LRMaximumInterFlowLayout()

@property (nonatomic, assign)CGFloat currentY;

@property (nonatomic, strong)NSMutableDictionary *cellAttributes;

@property (nonatomic, strong)NSMutableDictionary *headAttributes;

@property (nonatomic, strong)NSMutableDictionary *footerAttributes;

@end;

@implementation LRMaximumInterFlowLayout

- (NSMutableDictionary *)cellAttributes{
    if (!_cellAttributes) {
        _cellAttributes = [NSMutableDictionary dictionary];
    }
    return _cellAttributes;
}
- (NSMutableDictionary *)headAttributes{
    if (!_headAttributes) {
        _headAttributes = [NSMutableDictionary dictionary];
    }
    return _headAttributes;
}
- (NSMutableDictionary *)footerAttributes{
    if (!_footerAttributes) {
        _footerAttributes = [NSMutableDictionary dictionary];
    }
    return _footerAttributes;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    [self.cellAttributes removeAllObjects];
    [self.headAttributes removeAllObjects];
    [self.footerAttributes removeAllObjects];
    self.currentY = 0;
    
    NSInteger sectionNum = self.collectionView.numberOfSections;
    for (NSInteger section = 0; section < sectionNum; section++) {
        
        // 1 计算每个headerView布局对象
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        UICollectionViewLayoutAttributes *headAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        CGSize headSize = CGSizeZero;
        if (self.delegate && [self.delegate respondsToSelector:@selector(lr_collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headSize = [self.delegate lr_collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
        }
        //NSLog(@"headSize = %@",NSStringFromCGSize(headSize));
        headAttribute.frame = CGRectMake(0, self.currentY, headSize.width, headSize.height);
        self.headAttributes[indexPath] = headAttribute;
        //self.currentY = CGRectGetMaxY(headAttribute.frame)+self.sectionInset.top;//或者
        self.currentY += headSize.height + self.sectionInset.top;
        
        // 2 计算每个cell布局对象
        NSUInteger rowNum = [self.collectionView numberOfItemsInSection:section];
        CGFloat currentX = self.sectionInset.left;
        for (NSUInteger row = 0; row<rowNum; row++) {
            
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UICollectionViewLayoutAttributes *cellAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
            CGSize cellSize = [self.delegate lr_collectionView:self.collectionView layout:self sizeForItemAtIndexPath:cellIndexPath];
            
            if (currentX + cellSize.width + self.sectionInset.right > self.collectionView.frame.size.width) {
                currentX = self.sectionInset.left;
                self.currentY += cellSize.height + self.minimumLineSpacing;
            }
            cellAttribute.frame = CGRectMake(currentX, self.currentY, cellSize.width, cellSize.height);
            self.cellAttributes[cellIndexPath] = cellAttribute;
            currentX = currentX + cellSize.width + self.maximumInterSpacing;
            
            if (row == rowNum-1) {//最后一行
                self.currentY += cellSize.height + self.sectionInset.bottom;
            }
            //NSLog(@"self.currentY = %lf",self.currentY);
        }
        
        // 3 计算每个footerView布局对象
        UICollectionViewLayoutAttributes *footerAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
        CGSize footerSize = CGSizeZero;
        if (self.delegate && [self.delegate respondsToSelector:@selector(lr_collectionView:layout:referenceSizeForFooterInSection:)]) {
            footerSize = [self.delegate lr_collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
        }
        //NSLog(@"footerSize = %@",NSStringFromCGSize(footerSize));
        footerAttribute.frame = CGRectMake(0, self.currentY, footerSize.width, footerSize.height);
        self.footerAttributes[indexPath] = footerAttribute;
        self.currentY += footerSize.height;
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [NSMutableArray array];

    [self.cellAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *key, UICollectionViewLayoutAttributes *obj, BOOL * _Nonnull stop) {
        if (CGRectContainsRect(rect, obj.frame)) {
            [attributes addObject:obj];
        }
    }];
    
    [self.headAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *key, UICollectionViewLayoutAttributes *obj, BOOL * _Nonnull stop) {
        if (CGRectContainsRect(rect, obj.frame)) {
            [attributes addObject:obj];
        }
    }];
    [self.footerAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *key, UICollectionViewLayoutAttributes *obj, BOOL * _Nonnull stop) {
        if (CGRectContainsRect(rect, obj.frame)) {
            [attributes addObject:obj];
        }
    }];
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellAttributes[indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return self.headAttributes[indexPath];
    }else{
        return self.footerAttributes[indexPath];
    }
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.currentY);
}

@end
