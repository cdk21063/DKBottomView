//
//  DKBottomView.m
//  changchong2
//
//  Created by Jason Ma on 2019/4/23.
//  Copyright © 2019年 ios. All rights reserved.
//

#import "DKBottomView.h"

//CGFloat containerH = 340;
//CGFloat cornerRadius = 0;

@interface DKBottomView ()
//View
@property (nonatomic,strong) UIButton *bgBtn;//灰色底板
@property (nonatomic,strong) UIView *container;//容器,可自己添加需要的内容

@property (nonatomic,strong) UIButton *confirmBtn;//默认添加的确认按钮
//Model
@property (nonatomic,strong) NSDictionary *params;//传入的数据
@property (nonatomic,assign) CGFloat containerH;//默认340
@property (nonatomic,assign) CGFloat cornerRadius;//默认0
@end

@implementation DKBottomView

#pragma mark - Public
+ (void)showWithParams:(NSDictionary *)params delegate:(id <DKBottomViewDelegate>)delegate{
    
    [[self sharedView]showWithParams:params delegate:delegate containerH:340 cornerRadius:0];
}

#pragma mark - Private
+ (DKBottomView*)sharedView {
    static dispatch_once_t once;
    
    static DKBottomView *sharedView;
    
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds]; });
    
    return sharedView;
}

-(void)showWithParams:(NSDictionary *)params delegate:(id <DKBottomViewDelegate>)delegate containerH:(CGFloat)containerH cornerRadius:(CGFloat)cornerRadius{
    
    self.params = params;
    self.delegate = delegate;
    self.containerH = containerH;
    self.cornerRadius = cornerRadius;
    
    [self initSubViews];
    
    [[self frontWindow]addSubview:self];
    
    [self show];
}

//添加自定义view
- (void)initSubViews{
    
    self.bgBtn.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height));
    [self addSubview:self.bgBtn];
    
    self.container.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height), ([UIScreen mainScreen].bounds.size.width), self.containerH);
    [self addSubview:self.container];
    
    UIImageView *closeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pop_close_button"]];
    closeImgView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width) - 44, 0, 44, 44);
    closeImgView.contentMode = UIViewContentModeCenter;
    
    closeImgView.userInteractionEnabled = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeImgViewClick)];
    
    [closeImgView addGestureRecognizer:tap];
    
    [self.container addSubview:closeImgView];
    
    self.confirmBtn.frame = CGRectMake(20, self.containerH - 60, ([UIScreen mainScreen].bounds.size.width)-40, 40);
    
    [self.container addSubview:self.confirmBtn];
    
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

//关闭按钮点击
- (void)closeImgViewClick{
    
    [self remove];
    
}

//确认按钮点击
- (void)confirmBtnClick{
    
    if ([self.delegate respondsToSelector:@selector(confirmBtnClickWithParams:)]) {
        __weak __typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.delegate confirmBtnClickWithParams:nil];
        });
    }
    
    [self remove];
}

- (void)show{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgBtn.alpha = 0.5;
        self.container.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height)-self.containerH, ([UIScreen mainScreen].bounds.size.width), self.containerH);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)remove{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bgBtn.alpha = 0;
        self.container.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height), ([UIScreen mainScreen].bounds.size.width), self.containerH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Lazy
- (UIWindow *)frontWindow {
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    return nil;
}

-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_bgBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0;
        _bgBtn.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height));
    }
    return _bgBtn;
}

-(UIView *)container{
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.layer.cornerRadius = self.cornerRadius;
        _container.layer.borderWidth = 0.5;
        _container.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _container.backgroundColor = [UIColor whiteColor];
    }
    return _container;
}

-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_confirmBtn setBackgroundColor:[UIColor redColor]];
        
        _confirmBtn.layer.cornerRadius = 20;
        _confirmBtn.clipsToBounds = 1;
        
        
    }
    return _confirmBtn;
}
@end
