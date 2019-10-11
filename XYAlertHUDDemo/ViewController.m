//
//  ViewController.m
//  XYAlertHUDDemo
//
//  Created by wuxiaoyuan on 2019/9/29.
//  Copyright © 2019 lange. All rights reserved.
//

#import "ViewController.h"
#import "XYAlertHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[XYLancooAlert lancooAlertWithTitle:@"提示" msg:@"qing" sureTitle:@"23" sureBlock:^{
//        NSLog(@"123");
//    }] show];
    [XYAlert alertSuccessWithMessage:@"vi" confirmBlock:^{
        
    }];
    

//    [XYAlert showErrorWithStatus:@"233"];
}


@end
