//
//  MLFaceView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/11.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLFaceView.h"
#import "MLFaceCollectionViewCell.h"
@interface  MLFaceView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>


@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation MLFaceView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageArray = [NSMutableArray array];
        for (int i = 0; i <= 58; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"love_emoji_%d@2x", i]];
            [self.imageArray addObject:image];
        }
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(32, 32);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        UINib *nib = [UINib nibWithNibName:@"MLFaceCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"FaceCollectionViewCell"];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;

}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLFaceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FaceCollectionViewCell" forIndexPath:indexPath];
    cell.faceImage.image = _imageArray[indexPath.item];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(ml_faceView:withInteger:)]) {
        [self.delegate ml_faceView:self withInteger:indexPath.item];
    }

}

@end
