//
//  XXSudokuService.m
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXSudokuService.h"

#import "XXNSScoreModel.h"


@implementation XXSudokuService

/// 根据模型拼接成绩
+ (NSString *)getScoreWithScore:(XXNSScoreModel *)score {
    NSString *scoreString = [NSString stringWithFormat:@"正确 - %lu  错误 - %lu  总数 - %lu  正确率 - %.0f%%  平均 - %.3f",
                             score.correct,
                             score.error,
                             score.totalTimes,
                             score.correctRate * 100,
                             score.average];
    
    return scoreString;
}

/// 获取盘面类型 & 初盘
+ (NSDictionary *)getGrid {
    NSUInteger puzzle = (int)(arc4random() % kLatticeCount);
    NSMutableArray *initial = [self getSudokuInitialGrid].mutableCopy;
    NSUInteger answer = [initial[puzzle] unsignedIntValue];
    initial[puzzle] = @0;
    
    return @{
        KEY_GRIDSTYLE   :   @((int)(arc4random() % 3)),
        KEY_INITIAL     :   initial,
        KEY_ANSWER      :   @(answer),
    };
}


/// 获取初盘
+ (NSArray *)getSudokuInitialGrid {
    //  随机数从这里边产生
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
    
    //  随机数产生结果
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:kLatticeCount];
    
    for (int i = 0; i < kLatticeCount; ++i) {
        int t = arc4random() % values.count;
        result[i] = values[t];
        values[t] = [values lastObject]; // 为更好的乱序，故交换下位置
        [values removeLastObject];
    }
    
    return result;
}


/// 计算成绩
+ (void)calculatingResult:(XXNSScoreModel *)score andIsRight:(BOOL)isRight {
    if (isRight) {
        score.correctRate = (CGFloat)++score.correct / (CGFloat)++score.totalTimes;
    } else {
        ++score.error;
        score.correctRate = (CGFloat)score.correct / (CGFloat)++score.totalTimes;
    }
    
    //  计算平均耗时
    
}


@end
