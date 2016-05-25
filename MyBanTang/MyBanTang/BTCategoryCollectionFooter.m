//
//  BTCategoryCollectionFooter.m
//  MyBanTang
//
//  Created by zhangjing on 16/5/20.
//  Copyright © 2016年 ZhangJing. All rights reserved.
//

#import "BTCategoryCollectionFooter.h"
#import "UIView+frameAdjust.h"

@interface BTCategoryCollectionFooter () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *categoryCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *categoryLayout;


@end

@implementation BTCategoryCollectionFooter

- (void)awakeFromNib {
  [self.categoryCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _categoryLayout = [[UICollectionViewFlowLayout alloc] init];
    _categoryLayout.itemSize = CGSizeMake(self.width / 2, (self.height - 44 )/ 3);
    _categoryLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _categoryLayout.minimumInteritemSpacing = 4;
    _categoryLayout.minimumLineSpacing = 4;
//    _categoryLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 12);
    
    
    _categoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:_categoryLayout];
    _categoryCollectionView.backgroundColor = [UIColor whiteColor];
    _categoryCollectionView.dataSource = self;
    _categoryCollectionView.delegate = self;
    _categoryCollectionView.pagingEnabled = YES;
    [_categoryCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
  }
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self addSubview:self.categoryCollectionView];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return section == 0 ? 6 : 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
  cell.backgroundColor = [UIColor yellowColor];
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"indexPath: %ld", (long)indexPath.item);
}

@end
