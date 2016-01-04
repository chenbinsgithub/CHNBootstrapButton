//
//  CHNBootstrapButton.h
//  CHNBootstrapButton
//
//  Created by Chen Bin on 15/9/6.
//  Copyright (c) 2015年 ZTESoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮风格样式
 */
typedef NS_ENUM(NSInteger, CHNButtonStyle) {
    /**
     *  默认风格样式
     */
    CHNButtonStyleDefault = 0,
    /**
     *  主风格样式，深蓝色
     */
    CHNButtonStylePrimary = 1,
    /**
     *  信息提示风格样式，浅蓝色
     */
    CHNButtonStyleInfo = 2,
    /**
     *  警告风格样式，黄色
     */
    CHNButtonStyleWarning = 3,
    /**
     *  成功风格样式，绿色
     */
    CHNButtonStyleSuccess = 4,
    /**
     *  危险风格样式，红色
     */
    CHNButtonStyleDanger = 5
};

/**
 *  自定义的仿Bootstrap风格的按钮
 */
@interface CHNBootstrapButton : UIButton

- (instancetype)initWithStyle:(CHNButtonStyle)style title:(NSString *)title frame:(CGRect)frame;
- (instancetype)initWithStyle:(CHNButtonStyle)style title:(NSString *)title;
- (instancetype)initWithStyle:(CHNButtonStyle)style frame:(CGRect)frame;
- (instancetype)initWithStyle:(CHNButtonStyle)style;

@property (nonatomic) CHNButtonStyle chnButtonStyle; // 按钮风格类型

/**
 *  支持为按钮设置在不同状态下的背景色
 *
 *  @param backgroundColor 背景色
 *  @param state           按钮状态：普通、高亮等
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
