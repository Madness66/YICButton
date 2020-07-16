//
//  ViewController.m
//  YICButton
//
//  Created by YIC on 2020/7/16.
//  Copyright © 2020 YIC. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+YICEventInterval.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"QiButton_EventInterval";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor lightGrayColor];
    button.frame = CGRectMake(30.0, self.view.bounds.size.height / 2, self.view.bounds.size.width - 30.0 * 2, 50.0);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@(0).stringValue forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //! 设置按钮的点击响应间隔时间
    button.yic_eventInterval = 2.0;
}


#pragma mark - Action functions

- (void)buttonClicked:(UIButton *)sender {
    
    NSInteger titleInteger = sender.currentTitle.integerValue;
    [sender setTitle:@(++titleInteger).stringValue forState:UIControlStateNormal];
}


@end
