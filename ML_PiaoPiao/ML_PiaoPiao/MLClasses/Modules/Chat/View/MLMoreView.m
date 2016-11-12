//
//  MLMoreView.m
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/9/28.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import "MLMoreView.h"

@interface MLMoreView ()

@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLabel;

@end

@implementation MLMoreView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.photoLabel ml_setLabelDayAndNight];
    [self.phoneLabel ml_setLabelDayAndNight];
    [self.videoLabel ml_setLabelDayAndNight];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = MYXIB;
        
    
    }
    return self;
}
- (IBAction)photo:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ml_moreView:moreButtonStyle:)]) {
        [self.delegate ml_moreView:self moreButtonStyle:0];
    }
    
}

- (IBAction)phone:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ml_moreView:moreButtonStyle:)]) {
        [self.delegate ml_moreView:self moreButtonStyle:1];
    }
    
}

- (IBAction)video:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ml_moreView:moreButtonStyle:)]) {
        [self.delegate ml_moreView:self moreButtonStyle:2];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
