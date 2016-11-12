//
//  MLPlayHeaderView.m
//  
//
//  Created by 胡梦龙 on 16/10/9.
//
//

#import "MLPlayHeaderView.h"
#import "MLInfo.h"
#import "MLPlayHeaderViewCollectionViewCell.h"

static NSString *const collectionCell = @"collectionCell";

@interface  MLPlayHeaderView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MLPlayHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
        
        UINib *nib = [UINib nibWithNibName:@"MLPlayHeaderViewCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:collectionCell];
        
        
        
        
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _infos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLPlayHeaderViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    MLInfo *info = _infos[indexPath.row];
    cell.smallName.text = info.name;
    cell.title.text = info.title;
    [cell.backImage sd_setImageWithURL:[MLSeparateImageURL ml_URLWithFailueString:info.pic]];
    
    
    return cell;

}


- (void)setInfos:(NSArray *)infos {
    _infos = infos;
    [_collectionView reloadData];
}

@end
