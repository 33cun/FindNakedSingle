//
//  XXSudokuService.h
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XXNSScoreModel;

@interface XXSudokuService : NSObject

/// 根据模型拼接成绩
+ (NSString *)getScoreWithScore:(XXNSScoreModel *)score;

/// 获取盘面类型 & 初盘
/**
 * 应该返回三个东西
 * 1. style     Enum        - grid style
 * 2. initial   NSArray     - @[(1, 9)] 随机数
 * 3. puzzle    NSUInteger  - (1, 9)的一个随机数 用来当问题
 * 4. answer    NSUInteger  - initial[puzzle]
 *
 * 正确答案 = initial[puzzle]
 * initial[puzzle] = 0
 * 带修改
 */
+ (NSDictionary *)getGrid;

/// 获取初盘
+ (NSArray *)getSudokuInitialGrid;

@end

NS_ASSUME_NONNULL_END
