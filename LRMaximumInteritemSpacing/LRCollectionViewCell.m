//
//  LRCollectionViewCell.m
//  LRMaximumInteritemSpacing
//
//  Created by leilurong on 2018/8/28.
//  Copyright © 2018年 leilurong. All rights reserved.
//

#import "LRCollectionViewCell.h"

@interface LRCollectionViewCell()

@property (nonatomic, strong)UILabel *label;

@end

@implementation LRCollectionViewCell

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor cyanColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.label.text = content;
}

@end
