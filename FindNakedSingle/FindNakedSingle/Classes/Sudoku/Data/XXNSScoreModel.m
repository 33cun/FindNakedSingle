//
//  XXNSScoreModel.m
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXNSScoreModel.h"

@implementation XXNSScoreModel

- (instancetype)init {
    return [self initWithDict:@{
        @"correct" : @0,
        @"error" : @0,
        @"totalTimes" : @0,
        @"correctRate" : @0,
        @"average" : @0,
    }];
}


- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.correct = [dict[@"correct"] unsignedIntValue];
        self.error = [dict[@"error"] unsignedIntValue];
        self.totalTimes = [dict[@"totalTimes"] unsignedIntValue];
        self.correctRate = [dict[@"correctRate"] floatValue];
        self.average = [dict[@"average"] floatValue];
    }
    
    return self;
}


@end
