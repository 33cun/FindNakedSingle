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
@property (nonatomic, strong) NSMutableArray<CALayer *> *grids;

@property (nonatomic, strong) XXBlock *block;
@property (nonatomic, strong) CALayer *row;
@property (nonatomic, strong) CALayer *column;

@end


@implementation XXGrid

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _blocks = [NSMutableArray arrayWithCapacity:kBlockCount];
        _grids = [NSMutableArray arrayWithCapacity:0];
        
        self.borderWidth = 2.f;
        
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
    [self setupSingleColumn];
    [self setupSingleBlock];
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
    [self.grids addObject:self.block];
    [self addSublayer:self.block];
}

- (void)setupSingleRow {
    CGFloat width = kBlockW / 3;
    CGFloat height = kBlockW / 3;
    
    for (int i = 0; i < kLatticeCount; ++i) {
        XXLattice *lattice = [[XXLattice alloc] init];
        lattice.frame = CGRectMake((i * width), 0, width, height);
        lattice.borderW = 1.f;
        [self.row addSublayer:lattice];
    }
    
    [self.grids addObject:self.row];
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
    
    [self.grids addObject:self.column];
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
- (void)displayGrid:(NSDictionary *)dict {
    GridStyle style = [dict[KEY_GRIDSTYLE] integerValue];
    NSArray *initiial = dict[KEY_INITIAL];
    
    CALayer *tmp;
    
    switch (style) {
        case GridStyleRow : {
            tmp = self.row;
        } break;
        
        case GridStyleColumn : {
            tmp = self.column;
        } break;
        
        case GridStyleBlock : {
            tmp = self.block;
        } break;
            
        default:
            break;
    }
    
    for (CALayer *grid in self.grids) {
        grid.hidden = YES;
    }
    
    tmp.hidden = NO;
    
    for (int i = 0; i < initiial.count; ++i) {
        XXLattice *lattice = tmp.sublayers[i];
        lattice.value = [initiial[i] integerValue];
    }
}


#pragma mark - Private Methods


#pragma mark - Delegate


#pragma mark - Setter


#pragma mark - Getter
- (XXBlock *)block {
    if (!_block) {
        _block = [[XXBlock alloc] init];
        _block.frame = CGRectMake(0, 0, self.frame.size.width / 3, self.frame.size.height / 3);
        _block.hidden = YES;
    }
    
    return _block;
}

- (CALayer *)row {
    if (!_row) {
        _row = [[CALayer alloc] init];
        _row.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 3 / 3);
        _row.hidden = YES;
    }
    
    return _row;
}

- (CALayer *)column {
    if (!_column) {
        _column = [[CALayer alloc] init];
        _column.frame = CGRectMake(0, 0, self.frame.size.width / 3 / 3, self.frame.size.height);
        _column.hidden = YES;
    }
    
    return _column;
}


@end
