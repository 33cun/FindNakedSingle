//
//  XXBlock.m
//  Demo_Sudoku_OC
//
//  Created by 肖鑫 on 2020/3/7.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXBlock.h"
#import "XXLattice.h"

@interface XXBlock ()

@property (nonatomic, strong) NSMutableArray<XXLattice *> *lattice;

@end


@implementation XXBlock


#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _lattice = [NSMutableArray arrayWithCapacity:kLatticeCount];
        
        self.borderWidth = 1.f;
        
        [self initLayer];
    }
    
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    [self setupLayer];
}


#pragma mark - Layer
- (void)initLayer {
    for (int i = 0; i < kLatticeCount; ++i) {
        XXLattice *lattice = [[XXLattice alloc] init];
        lattice.index = i;
        
        [self.lattice addObject:lattice];
        [self addSublayer:lattice];
    }
}

- (void)setupLayer {
    CGFloat width = self.frame.size.width / 3;
    CGFloat height = self.frame.size.height / 3;
    
    for (int i = 0; i < self.lattice.count; ++i) {
        NSInteger r = ceil(i / 3);
        NSInteger c = i % 3;
        
        XXLattice *lattice = self.lattice[i];
        lattice.frame = CGRectMake(r * width, c * height, width, height);
    }
}


#pragma mark - Data
- (void)setupData {
    
}

- (void)loadData:(NSArray *)data {
    for (int i = 0; i < data.count; ++i) {
        if (self.lattice.count < data.count) @throw [NSException exceptionWithName:@"Lattice Array Exception" reason:@"crush's reason" userInfo:nil];
        
        NSUInteger value = [data[i] unsignedIntValue];
        
        XXLattice *lattice = self.lattice[i];
        lattice.initial = value;
        
        lattice.value = value;
    }
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate


#pragma mark - Setter


#pragma mark - Getter

@end
