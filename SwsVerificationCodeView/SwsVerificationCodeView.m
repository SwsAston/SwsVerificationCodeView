//
//  SwsVerificationCodeView.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "SwsVerificationCodeView.h"

#define Time_Num 5

#define Radius 5.0

#define Border_Color [UIColor orangeColor].CGColor

typedef void (^TouchBlock)();

@interface SwsVerificationCodeView ()

@property (copy) TouchBlock touchBlock;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) NSTimer   *timer;
@property (nonatomic, assign) NSInteger timeNum;

@end

@implementation SwsVerificationCodeView

- (SwsVerificationCodeView *)initWithFrame:(CGRect)frame
                                   inBlock:(void (^)())inBlock {
    
    SwsVerificationCodeView *verificationCodeView = [[[NSBundle mainBundle] loadNibNamed:@"SwsVerificationCodeView" owner:self options:nil] firstObject];
    
    verificationCodeView.frame = frame;
    verificationCodeView.touchBlock = inBlock;
    verificationCodeView.timeNum = Time_Num;
    
    verificationCodeView.layer.cornerRadius = Radius;
    verificationCodeView.layer.masksToBounds = YES;
    verificationCodeView.layer.borderColor = Border_Color;
    verificationCodeView.layer.borderWidth = 0.5;
    
    return verificationCodeView;
}

- (IBAction)clickButton:(UIButton *)sender {
    
    _button.userInteractionEnabled = NO;
    _titleLabel.text = [NSString stringWithFormat:@"%ld秒后重发",_timeNum];
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self selector:@selector(processTimer)
                                                userInfo:nil
                                                 repeats:HUGE_VAL];
    } else {
        
        _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    }
    _touchBlock();
}

- (void)processTimer {
    
    _timeNum -- ;
    _titleLabel.text = [NSString stringWithFormat:@"%ld秒后重发",_timeNum];
    if (0 == _timeNum) {
        
        _button.userInteractionEnabled = YES;
        _timeNum = Time_Num;
        _titleLabel.text = @"获取验证码";
        _timer.fireDate = [NSDate distantFuture];
    }
}

@end
