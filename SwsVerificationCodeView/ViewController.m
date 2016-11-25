//
//  ViewController.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "ViewController.h"
#import "SwsVerificationCodeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    SwsVerificationCodeView *view = [[SwsVerificationCodeView alloc] initWithFrame:CGRectMake(140, 240, 100, 30) inBlock:^{
        
        NSLog(@"111");
        _label.text = @"发送验证码中...";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _label.text = @"Label";
        });
        
    }];
    [self.view addSubview:view];
}

@end
