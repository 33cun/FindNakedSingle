//
//  ViewController.m
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "ViewController.h"

#import "XXGrid.h"

@interface ViewController ()

@property (nonatomic, strong) XXGrid *grid;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLayer];
    [self setupData];
}


#pragma mark - Layer
- (void)setupLayer {
    [self.view.layer addSublayer:self.grid];
}


#pragma mark - Data
- (void)setupData {
    //[self.grid loadData:[XXSudokuService getInitialGrid]];
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate


#pragma mark - Setter


#pragma mark - Getter
- (XXGrid *)grid {
    if (!_grid) {
        CGRect rect = CGRectMake(kMargin, 100, (SCREEN_WIDTH - kMargin * 2), (SCREEN_WIDTH - kMargin * 2));
        
        _grid = [XXGrid layer];
        _grid.frame = rect;
    }
    
    return _grid;
}


@end
