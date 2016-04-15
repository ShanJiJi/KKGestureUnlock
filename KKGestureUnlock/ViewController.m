//
//  ViewController.m
//  KKGestureUnlock
//
//  Created by 珍玮 on 16/4/15.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "ViewController.h"
#import "KKGestureView.h"

@interface ViewController ()<GetUnlockStringDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _unlockLab.text = @"";
    
    //创建手势界面
    KKGestureView *gestureView = [[KKGestureView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    gestureView.delegate = self;
    
    //设置手势界面居中
    gestureView.center = self.view.center;
    //将手势界面添加到视图中
    [self.view addSubview:gestureView];
    
    
    
    
}

-(void)GetGestureUnlockString:(NSString *)string{
    
    _unlockLab.text = string;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
