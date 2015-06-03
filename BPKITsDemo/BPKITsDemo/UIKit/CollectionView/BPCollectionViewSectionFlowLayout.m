//
//  BPCollectionViewSectionFlowLayout.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/6/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPCollectionViewSectionFlowLayout.h"
#import "BPCollectionSectionReusableView.h"

#define kSectionDecorationKind @"SectionDecorationKind"

@implementation BPCollectionViewSectionFlowLayout{
    
    NSMutableArray *_decorateAttributes;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    _decorateAttributes = [NSMutableArray array];
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    
    //遍历section
    for (NSInteger section=0; section<numberOfSections; section++) {
     
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        //初始化一个LayoutAttributes
        UICollectionViewLayoutAttributes *decoLA = [UICollectionViewLayoutAttributes
                                                    layoutAttributesForDecorationViewOfKind:kSectionDecorationKind
                                                    withIndexPath:indexPath];
        //设定层级关系，在cell之下
        decoLA.zIndex = -1;
        //设定rect
        decoLA.frame = [self frameForDecorateViewAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        //添加到额外的attributes数组中
        [_decorateAttributes addObject:decoLA];
    }
    
    //注册DecorationView
    [self registerClass:[BPCollectionSectionReusableView class] forDecorationViewOfKind:kSectionDecorationKind];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    
    for (UICollectionViewLayoutAttributes *attr in _decorateAttributes) {
        //判断可视rect与layoutAttribute的frame的交集，如果相交，把这个layoutAttribute添加到数组中
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [attributes addObject:attr];
        }
    }
    return attributes;
}

- (CGRect)frameForDecorateViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfRows = [self.collectionView numberOfItemsInSection:indexPath.section];
    //section第一个item
    UICollectionViewLayoutAttributes *firstItemAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
    //section最后一个item
    UICollectionViewLayoutAttributes *lastItemAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:MAX(0, numberOfRows - 1) inSection:indexPath.section]];
    //section高度
    CGFloat height = CGRectGetMaxY(lastItemAttr.frame) - CGRectGetMinY(firstItemAttr.frame);
    //构造整个section的frame，不包括header、footer和sectionInset
    CGRect rect = CGRectMake(0, firstItemAttr.frame.origin.y, CGRectGetWidth(self.collectionView.frame), height);
    return rect;
}
@end
