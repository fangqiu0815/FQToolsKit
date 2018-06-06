//
//  ViewController.m
//  FQCustomTextField
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+FQCustomTextField.h"
#import "FQConfigDefine.h"
#import "UIView+FQFrame.h"

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *textField;

@property(nonatomic, strong) UILabel *label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];


}

- (void)setupUI
{
    self.title = @"BATextField";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    self.label1.frame = CGRectMake(20, 80, BAKit_SCREEN_WIDTH - 20 * 2, 30);
    self.textField.frame = CGRectMake(20, self.label1.bottom + 20, BAKit_SCREEN_WIDTH - 20 * 2, 30);
}


#pragma mark - setter / getter

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.placeholder = @"这里是 placeholder！限制最大位数：6！";
        _textField.backgroundColor = [UIColor lightGrayColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        // placeholder：文字颜色
        _textField.fq_placeholderColor = [UIColor blueColor];
        // placeholder：文字字体
        _textField.fq_placeholderFont = [UIFont systemFontOfSize:11];
        // 限制最大输入长度
        _textField.fq_maxLength = 6;

        [self.view addSubview:_textField];
    }
    return _textField;
}

- (UILabel *)label1
{
    if (!_label1)
    {
        NSString *msg = @"1、自定义 placeholder 字体和颜色，限制最大位数为 6 位！";
        _label1 = [self fq_addLabelWithMsg:msg];
        
        [self.view addSubview:_label1];
    }
    return _label1;
}

- (UILabel *)fq_addLabelWithMsg:(NSString *)msg
{
    UILabel *label = [UILabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:11];
    
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
