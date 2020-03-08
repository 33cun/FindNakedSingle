//
//  XXBlock.h
//  Demo_Sudoku_OC
//
//  Created by 肖鑫 on 2020/3/7.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXBlock : CALayer

@property (nonatomic, assign) NSUInteger index;

- (void)loadData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
