//
//  SKSocialSecurityView.m
//  SKIncomeTaxCalculator
//
//  Created by Tim (Xinyin) Liu on 2018/12/26.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKSocialSecurityView.h"
#import "Masonry.h"
#import "SKSocialsecurityCell.h"

#define itemWtdth  ([UIScreen mainScreen].bounds.size.width-20)/5.0
static CGFloat itemHeight = 40.0;
@interface SKSocialSecurityView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@end
@implementation SKSocialSecurityView
- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
//        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)commonInit {
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.scrollEnabled = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[SKSocialSecurityCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@(7 * itemHeight));
        make.bottom.equalTo(self).offset(-8);
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 | indexPath.section == 6)  {
        if (indexPath.row > 0) {
            return CGSizeMake(itemWtdth*2, itemHeight);
        }
    }
    return CGSizeMake(itemWtdth, itemHeight);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    } else if (section == 6) {
        return 3;
    }
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SKSocialSecurityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.infoStr = @"养老";
    if (indexPath.row>0) {
//        cell.textColor = [UIColor redColor];
    }
    return cell;
}

@end
