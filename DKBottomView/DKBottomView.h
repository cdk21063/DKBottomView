//
//  DKBottomView.h
//  changchong2
//
//  Created by Jason Ma on 2019/4/23.
//  Copyright © 2019年 ios. All rights reserved.
//
/*
 1.通用的底部弹窗,独立低耦合,可以自定义内容,都放在container属性里面即可,
 2.目前支持自定义高度和圆角,
 3.也可以自己导入masonry,使用masonry布局,
 4.支持数据传入与回传,使用代理回传.
 5.有问题或建议可以联系QQ226315016
 */
#import <UIKit/UIKit.h>

@protocol DKBottomViewDelegate<NSObject>

@optional
//消失代理方法
- (void)closeWithParams:(NSDictionary *)params;

//确认按钮点击代理方法
- (void)confirmBtnClickWithParams:(NSDictionary *)params;

//可以自己添加需要的代理方法
@end

@interface DKBottomView : UIView

@property (nonatomic,weak) id <DKBottomViewDelegate> delegate;

/**
 <#Description#>

 @param params 传入需要展示的数据
 @param delegate 事件代理
 */
+ (void)showWithParams:(NSDictionary *)params delegate:(id <DKBottomViewDelegate>)delegate;

/**
 <#Description#>
 
 @param params 传入需要展示的数据
 @param delegate 事件代理
 @param containerH 显示容器高度
 @param cornerRadius 显示容器圆角大小
 */
+ (void)showWithParams:(NSDictionary *)params delegate:(id <DKBottomViewDelegate>)delegate containerH:(CGFloat)containerH cornerRadius:(CGFloat)cornerRadius;
@end
