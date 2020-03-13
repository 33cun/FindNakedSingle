//
//  ViewController.m
//  FindNakedSingle
//
//  Created by 肖鑫 on 2020/3/8.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kBtnW   90.f
#define kBtnH   35.f


#import "ViewController.h"
#import "XXHistoryVC.h"
#import "XXSettingVC.h"
#import "XXSudokuService.h"

#import "XXGrid.h"
#import "YYFPSLabel.h"

#import "XXNSScoreModel.h"

#import <AudioToolbox/AudioToolbox.h>



@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *lb_score;
@property (nonatomic, strong) UITextField *tf_input;
@property (nonatomic, strong) XXGrid *grid;
@property (nonatomic, strong) UIButton *btn_history;
@property (nonatomic, strong) UIButton *btn_start;
@property (nonatomic, strong) UIButton *btn_setting;

@property (nonatomic, strong) XXNSScoreModel *score;
@property (nonatomic, copy) NSDictionary *curInitialGrid;

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
    [self.view addSubview:self.btn_history];
    [self.view addSubview:self.btn_start];
    [self.view addSubview:self.btn_setting];
    
    YYFPSLabel *lb_fps = [[YYFPSLabel alloc] initWithFrame:CGRectMake(kMargin, kStatusHeight, kSize.width, kSize.height)];
    [self.view addSubview:lb_fps];
    
    [self setupLayer];
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
- (void)clickedStartBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //  开始状态
        [self.tf_input becomeFirstResponder];
        
        [self repeatDrawGrid];
    } else {
        //  停止状态
        [self.tf_input resignFirstResponder];
    }
}

- (void)clickedHistoryBtn:(UIButton *)sender {
    XXHistoryVC *vc = [[XXHistoryVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickedSettingBtn:(UIButton *)sender {
    XXSettingVC *vc = [[XXSettingVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)input:(NSUInteger)input {
    //  计算成绩 更新成绩
    //  重绘盘面
    
    [self calculatingResult:input];
    [self repeatDrawGrid];
}


#pragma mark - Public Methods


#pragma mark - Private Methods
/// 计算成绩
/// @param input Modifiable
- (void)calculatingResult:(NSUInteger)input {
    BOOL isRight = ([self.curInitialGrid[KEY_ANSWER] unsignedIntValue] == input);
    
    [XXSudokuService calculatingResult:self.score andIsRight:isRight];
    
    [self updateScore];
}

/// 更新初盘数据
- (void)updateInitialGrid {
    self.curInitialGrid = [XXSudokuService getGrid];
}

/// 绘制盘面
- (void)drawGrid {
    [self.grid displayGrid:self.curInitialGrid];
}

/// 重新绘制
- (void)repeatDrawGrid {
    [self updateInitialGrid];
    [self drawGrid];
}


#pragma mark - Delegate
#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    AudioServicesPlaySystemSound(1519);
    
    if (self.tf_input == textField) {
        NSUInteger input = [string integerValue];
        
        [self input:input];
    }
    
    return NO;
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
        _tf_input.hidden = YES;
    }
    
    return _tf_input;
}

- (UIButton *)btn_history {
    if (!_btn_history) {
        _btn_history = [[UIButton alloc] init];
        _btn_history.frame = CGRectMake(CGRectGetMinX(self.grid.frame), CGRectGetMaxY(self.grid.frame) + kMargin, kBtnW, kBtnH);
        _btn_history.backgroundColor = [UIColor blackColor];
        [_btn_history setTitle:@"HISTORY" forState:UIControlStateNormal];
        [_btn_history setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_history addTarget:self action:@selector(clickedHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_history;
}

- (UIButton *)btn_start {
    if (!_btn_start) {
        _btn_start = [[UIButton alloc] init];
        _btn_start.frame = CGRectMake((SCREEN_WIDTH - kBtnW) / 2, CGRectGetMinY(self.btn_history.frame), kBtnW, kBtnH);
        _btn_start.backgroundColor = [UIColor blackColor];
        [_btn_start setTitle:@"START" forState:UIControlStateNormal];
        [_btn_start setTitle:@"PAUSE" forState:UIControlStateSelected];
        [_btn_start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_start addTarget:self action:@selector(clickedStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_start;
}

- (UIButton *)btn_setting {
    if (!_btn_setting) {
        _btn_setting = [[UIButton alloc] init];
        _btn_setting.frame = CGRectMake((CGRectGetMaxX(self.grid.frame) - kBtnW), CGRectGetMaxY(self.grid.frame) + kMargin, kBtnW, kBtnH);
        _btn_setting.backgroundColor = [UIColor blackColor];
        [_btn_setting setTitle:@"SETTING" forState:UIControlStateNormal];
        [_btn_setting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_setting addTarget:self action:@selector(clickedSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_setting;
}

@end
