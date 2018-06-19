//
//  ViewController.m
//  YJSPayManagerDemo
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 YJS. All rights reserved.
//
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGH [[UIScreen mainScreen] bounds].size.height

#ifdef DEBUG
////测试API
#define SB @"HELLO WORLD _ DEBUG";
#else
//开发API
#define SB @"HELLO WORLD _ RELEASE";
#endif

#import "ViewController.h"
#import "YJSPayManager.h"
//#import <FBRetainCycleDetector.h>

typedef void (^myBlock)(NSString * name);

@interface ViewController (){
    void (^_handlerBlock)();
}
@property (strong, nonatomic) NSString * name;

@property (strong, nonatomic) NSTimer * timer;

- (void)printName:(myBlock)block;

@property (copy,nonatomic) myBlock block;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.block = ^(NSString * name){
        NSLog(@"%@",self);
    };
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    }];
    
    _handlerBlock = ^{
        NSLog(@"%@",self);
    };
    
//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@", retainCycles);
    
    UIButton * applePayBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, WIDTH - 40, 40)];
    [applePayBtn setTitle:@"苹果支付" forState:UIControlStateNormal];
    [applePayBtn addTarget:self action:@selector(applePayBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    applePayBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:applePayBtn];
    
    UIButton * weChatPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(applePayBtn.frame) + 20, WIDTH - 40, 40)];
    [weChatPayBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [weChatPayBtn addTarget:self action:@selector(weChatPayBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    weChatPayBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:weChatPayBtn];
    
    UIButton * aliPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(weChatPayBtn.frame) + 20, WIDTH - 40, 40)];
    [aliPayBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [aliPayBtn addTarget:self action:@selector(aliPayBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    aliPayBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:aliPayBtn];
    
    UIButton * unionPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(aliPayBtn.frame) + 20, WIDTH - 40, 40)];
    [unionPayBtn setTitle:@"银联支付" forState:UIControlStateNormal];
    [unionPayBtn addTarget:self action:@selector(unionPayBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    unionPayBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:unionPayBtn];
    
    NSString * str = SB;
    NSLog(@"str = %@",str);
}

//苹果支付
- (void)applePayBtnEvent{
    //先获取Apple Pay支付参数
    //...
    
    YJSPayManager *manager = [YJSPayManager sharedManager];
    [manager applePayWithTraderInfo:nil viewController:self respBlock:^(NSInteger respCode, NSString *respMsg) {
        
        //处理支付结果
        
    }];
}

//微信支付
- (void)weChatPayBtnEvent{
    //先获取微信支付参数
    //...
    
    YJSPayManager *manager = [YJSPayManager sharedManager];
    [manager wechatPayWithAppId:@"" partnerId:@"" prepayId:@"" package:@"" nonceStr:@"" timeStamp:@"" sign:@"" respBlock:^(NSInteger respCode, NSString *respMsg) {
        
        //处理支付结果
        
    }];
}

//支付宝支付
- (void)aliPayBtnEvent{
    //先获取支付宝支付参数
    //...
    
    YJSPayManager *manager = [YJSPayManager sharedManager];
    [manager aliPayOrder:@"" scheme:@"" respBlock:^(NSInteger respCode, NSString *respMsg) {
        
        //处理支付结果
        
    }];
}

//银联支付
- (void)unionPayBtnEvent{
    //先获取银联支付参数
    //...
    
    YJSPayManager *manager = [YJSPayManager sharedManager];
    [manager unionPayWithSerialNo:@"" viewController:self respBlock:^(NSInteger respCode, NSString *respMsg) {
        
        //处理支付结果
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
