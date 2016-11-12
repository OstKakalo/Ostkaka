//
//  MLFaceView.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/11.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MLFaceView;

@protocol MLFaceViewDelegate <NSObject>

- (void)ml_faceView:(MLFaceView *)faceView withInteger:(NSInteger)number;

@end

@interface MLFaceView : UIView

@property (nonatomic, assign) CGFloat keyHeight;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<MLFaceViewDelegate>delegate;
@end
