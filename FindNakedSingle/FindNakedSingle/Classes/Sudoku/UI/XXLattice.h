//
//  XXLattice.h
//  Demo_Sudoku_OC
//
//  Created by 肖鑫 on 2020/3/7.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXLattice : CALayer

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, assign) NSUInteger value;

@property (nonatomic, assign, getter=isInitial) BOOL initial;

/// borderWidth default .25f
@property (nonatomic, assign) CGFloat borderW;

@end

NS_ASSUME_NONNULL_END
