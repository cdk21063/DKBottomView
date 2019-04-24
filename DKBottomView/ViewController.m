//
//  ViewController.m
//  DKBottomView
//
//  Created by Jason Ma on 2019/4/23.
//  Copyright © 2019年 CDK. All rights reserved.
//

#import "ViewController.h"
#import "DKBottomView.h"
@interface ViewController ()<DKBottomViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [DKBottomView showWithParams:nil delegate:self];
}
-(void)confirmBtnClickWithParams:(NSDictionary *)params{
    NSLog(@"confirmBtnClick");
}
@end
