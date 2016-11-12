//
//  NSObject+MLClear.h
//  ML_PiaoPiao
//
//  Created by 胡梦龙 on 16/10/10.
//  Copyright © 2016年 胡梦龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MLClear)




// 获取缓存
+ (void)getFileCacheSizeWithPath:(NSString *)path completion:(void(^)(NSInteger total))completion;

// 清除缓存
+ (void)removeCacheWithCompletion:(void (^)())completion;

// 缓存路径
+ (NSString *)cachePath;
@end
