//
//  XXLattice.m
//  Demo_Sudoku_OC
//
//  Created by 肖鑫 on 2020/3/7.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXLattice.h"

@interface XXLattice ()

@property (nonatomic, strong) CATextLayer *label;

@end

@implementation XXLattice

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.borderWidth = .25f;
        
        [self initLayer];
    }
    
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    self.label.frame = self.bounds;
}


#pragma mark - Layer
- (void)initLayer {
    [self addSublayer:self.label];
}


#pragma mark - Data
- (void)setupData {
    
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate


#pragma mark - Setter
- (void)setValue:(NSUInteger)value {
    _value = value;
    
    if (self.isInitial) {
        self.label.string = [NSString stringWithFormat:@"%lu", (unsigned long)value];
    } else {
        if (0 == value) return;
        
        self.label.foregroundColor = [UIColor redColor].CGColor;
    }
}

- (void)setBorderW:(CGFloat)borderW {
    _borderW = borderW;
    
    self.borderWidth = borderW;
}


#pragma mark - Getter
- (CATextLayer *)label {
    if (!_label) {
        _label = [[CATextLayer alloc] init];
        _label.fontSize = 34.f; //  -.-
        _label.foregroundColor = [UIColor blackColor].CGColor;
        _label.alignmentMode = kCAAlignmentCenter;
        _label.contentsScale = [UIScreen mainScreen].scale;
    }
    
    return _label;
}


@end
