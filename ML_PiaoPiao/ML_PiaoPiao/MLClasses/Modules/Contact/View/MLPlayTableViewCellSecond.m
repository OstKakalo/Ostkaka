//
//  MLPlayTableViewCellSecond.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/9.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLPlayTableViewCellSecond.h"

@implementation MLPlayTableViewCellSecond

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.title ml_setLabelDayAndNight];
    [self.backView ml_setFrontViewDayAndNight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
