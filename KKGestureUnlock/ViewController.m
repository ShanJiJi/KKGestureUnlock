//
//  ViewController.m
//  KKGestureUnlock
//
//  Created by 珍玮 on 16/4/15.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "ViewController.h"
#import "KKGestureView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    KKGestureView *gestureView = [[KKGestureView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    gestureView.center = self.view.center;
    
    [self.view addSubview:gestureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
