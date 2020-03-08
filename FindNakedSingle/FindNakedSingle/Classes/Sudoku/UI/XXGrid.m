//
//  XXGrid.m
//  Demo_Sudoku_OC
//
//  Created by 肖鑫 on 2020/3/7.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kBlockW    (self.frame.size.width / 3)
#define kBlockH    (self.frame.size.height / 3)

#import "XXGrid.h"
#import "XXBlock.h"
#import "XXLattice.h"

@interface XXGrid ()

@property (nonatomic, strong) NSMutableArray<XXBlock *> *blocks;

@property (nonatomic, strong) XXBlock *block;
@property (nonatomic, strong) CALayer *row;
@property (nonatomic, strong) CALayer *column;

@end


@implementation XXGrid

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _blocks = [NSMutableArray arrayWithCapacity:kBlockCount];
        
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
    for (int i = 0; i < kBlockCount; ++i) {
        XXBlock *block = [[XXBlock alloc] init];
        block.index = i;
        
        [self.blocks addObject:block];
    }
}

- (void)setupLayer {
    [self setupSingleRow];
}

- (void)setupNineBlock {
    CGFloat width = kBlockW;
    CGFloat height = kBlockH;
    
    for (int i = 0; i < self.blocks.count; ++i) {
        NSInteger r = ceil(i / 3);
        NSInteger c = i % 3;
        
        XXBlock *block = self.blocks[i];
        block.frame = CGRectMake(r * width, c * height, width, height);
        
        [self addSublayer:block];
    }
}

- (void)setupSingleBlock {
    [self addSublayer:self.block];
}

- (void)setupSingleRow {
    CGFloat width = kBlockW / 3;
    CGFloat height = kBlockW / 3;
    
    for (int i = 0; i < kLatticeCount; ++i) {
        XXLattice *lattice = [[XXLattice alloc] init];
        lattice.frame = CGRectMake((i * width), 0, width, height);
        [self.row addSublayer:lattice];
    }
    
    [self addSublayer:self.row];
}

- (void)setupSingleColumn {
    CGFloat width = kBlockW / 3;
    CGFloat height = kBlockW / 3;
    
    for (int i = 0; i < kLatticeCount; ++i) {
        XXLattice *lattice = [[XXLattice alloc] init];
        lattice.frame = CGRectMake(0, (i * width), width, height);
        [self.column addSublayer:lattice];
    }
    
    [self addSublayer:self.column];
}


#pragma mark - Data
- (void)loadData:(NSArray<NSArray *> *)data {
    for (int i = 0; i < data.count; ++i) {
        XXBlock *block = self.blocks[i];
        NSArray *blockValues = data[i];
        
        [block loadData:blockValues];
    }
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate


#pragma mark - Setter


#pragma mark - Getter
- (XXBlock *)block {
    if (!_block) {
        _block = [[XXBlock alloc] init];
        _block.frame = CGRectMake(0, 0, self.frame.size.width / 3, self.frame.size.height / 3);
    }
    
    return _block;
}

- (CALayer *)row {
    if (!_row) {
        _row = [[CALayer alloc] init];
        _row.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 3 / 3);
    }
    
    return _row;
}

- (CALayer *)column {
    if (!_column) {
        _column = [[CALayer alloc] init];
        _column.frame = CGRectMake(0, 0, self.frame.size.width / 3 / 3, self.frame.size.height);
    }
    
    return _column;
}


@end
