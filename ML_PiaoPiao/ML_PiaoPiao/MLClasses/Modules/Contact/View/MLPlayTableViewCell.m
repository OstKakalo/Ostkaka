//
//  MLPlayTableViewCell.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/9.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLPlayTableViewCell.h"

@interface MLPlayTableViewCell ()



@end

@implementation MLPlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.backView ml_setFrontViewDayAndNight];
    [self.title ml_setLabelDayAndNight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
