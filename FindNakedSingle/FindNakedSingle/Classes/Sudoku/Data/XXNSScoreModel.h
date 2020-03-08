//
//  XXNSScoreModel.h
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXNSScoreModel : NSObject

/// 正确数量
@property (nonatomic, assign) NSUInteger correct;

/// 错误数量
@property (nonatomic, assign) NSUInteger error;

/// 总次数
@property (nonatomic, assign) NSUInteger totalTimes;

/// 正确率
@property (nonatomic, assign) CGFloat correctRate;

/// 平均耗时 总耗时/总次数
@property (nonatomic, assign) CGFloat average;



- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
