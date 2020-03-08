//
//  ViewController.m
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "ViewController.h"

#import "XXGrid.h"

#import "XXNSScoreModel.h"

#import "XXSudokuService.h"


@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *lb_score;
@property (nonatomic, strong) UITextField *tf_input;
@property (nonatomic, strong) XXGrid *grid;
@property (nonatomic, strong) UIButton *btn_start;

@property (nonatomic, strong) XXNSScoreModel *score;

@end


@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.tf_input];
    [self.view addSubview:self.lb_score];
    [self.view addSubview:self.btn_start];
    
    [self setupNav];
    [self setupLayer];
}


- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(setting:)];
}


#pragma mark - Layer
- (void)setupLayer {
    [self.view.layer addSublayer:self.grid];
}


#pragma mark - Data
- (void)setupData {
    self.score = [[XXNSScoreModel alloc] init];
    
    [self updateScore];
}

- (void)updateScore {
    self.lb_score.text = [XXSudokuService getScoreWithScore:self.score];
}


#pragma mark - Event Response
- (void)clickedButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //  开始状态
        [self.tf_input becomeFirstResponder];
        
        [self displayGrid];
    } else {
        //  停止状态
        [self.tf_input resignFirstResponder];
    }
}

- (void)setting:(UIBarButtonItem *)sender {
    XXLog(@"设置样式");
}

- (void)input:(NSUInteger)input {
    //  计算成绩 更新成绩
    //  更新盘面
    
    self.tf_input.text = @"";
    
    [self displayGrid];
    [self updateScore];
}

- (void)displayGrid {
    [self.grid displayGrid:[XXSudokuService getGrid]];
}


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate
#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.tf_input == textField) {
        NSUInteger input = [[textField.text stringByReplacingCharactersInRange:range withString:string] integerValue];
        
//        XXLog(@"Input -> %lu", input);
        
        [self input:input];
    }
    
    return YES;
}


#pragma mark - Setter


#pragma mark - Getter
- (UILabel *)lb_score {
    if (!_lb_score) {
        _lb_score = [[UILabel alloc] init];
        _lb_score.frame = CGRectMake(kMargin, kStatusHeight + kMargin, (SCREEN_WIDTH - kMargin * 2), 35.f);
        _lb_score.numberOfLines = 0;
        _lb_score.font = [UIFont systemFontOfSize:10.f];
        _lb_score.textColor = [UIColor blackColor];
        _lb_score.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lb_score;
}

- (XXGrid *)grid {
    if (!_grid) {
        CGRect rect = CGRectMake(kMargin, CGRectGetMaxY(self.lb_score.frame) + kMargin, (SCREEN_WIDTH - kMargin * 2), (SCREEN_WIDTH - kMargin * 2));
        
        _grid = [[XXGrid alloc] init];
        _grid.frame = rect;
    }
    
    return _grid;
}

- (UITextField *)tf_input {
    if (!_tf_input) {
        CGFloat w = 35.f, h = 25.f;
        
        _tf_input = [[UITextField alloc] init];
        _tf_input.frame = CGRectMake((SCREEN_WIDTH - w) / 2, kStatusHeight, w, h);
        _tf_input.keyboardType = UIKeyboardTypeNumberPad;
        _tf_input.font = [UIFont systemFontOfSize:10.f];
        _tf_input.backgroundColor = [UIColor redColor];
        _tf_input.textAlignment = NSTextAlignmentCenter;
        _tf_input.delegate = self;
    }
    
    return _tf_input;
}

- (UIButton *)btn_start {
    if (!_btn_start) {
        CGFloat w = 75.f, h = 35.f;
        
        _btn_start = [[UIButton alloc] init];
        _btn_start.frame = CGRectMake((SCREEN_WIDTH - w) / 2, CGRectGetMaxY(self.grid.frame) + kMargin, w, h);
        _btn_start.backgroundColor = [UIColor blackColor];
        [_btn_start setTitle:@"START" forState:UIControlStateNormal];
        [_btn_start setTitle:@"PAUSE" forState:UIControlStateSelected];
        [_btn_start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_start addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_start;
}

@end
