//
//  CHButton.m
//  DataEncryptionDemo
//
//  Created by Chen Bin on 15/9/6.
//  Copyright (c) 2015年 ZTESoft. All rights reserved.
//

#import "CHNBootstrapButton.h"

#define UICOLOR_FROM_HEX(hex_value) [UIColor colorWithRed:((float)((hex_value & 0xFF0000) >> 16))/255.0 green:((float)((hex_value & 0xFF00) >> 8))/255.0 blue:((float)(hex_value & 0xFF))/255.0 alpha:1.0]

@interface CHNBootstrapButton () {
    NSMutableDictionary *_colors;
}
@end

@implementation CHNBootstrapButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (instancetype)initWithStyle:(CHNButtonStyle)style title:(NSString *)title frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
        self.chnButtonStyle = style;
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithStyle:(CHNButtonStyle)style title:(NSString *)title {
    if (self = [super init]) {
        [self setupButton];
        self.chnButtonStyle = style;
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithStyle:(CHNButtonStyle)style {
    if (self = [super init]) {
        [self setupButton];
        self.chnButtonStyle = style;
    }
    return self;
}

- (instancetype)initWithStyle:(CHNButtonStyle)style frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
        self.chnButtonStyle = style;
    }
    return self;
}

/**
 *  设置图片样式
 */
- (void)setupButton {
     _colors = [NSMutableDictionary dictionary];
    // 设置圆角
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    // 初始化为默认样式
    self.chnButtonStyle = CHNButtonStyleDefault;
}

/**
 *  重写 chnButtonType setter 方法，根据类型修改按钮样式
 *
 *  @param chnButtonType 按钮样式
 */
- (void)setChnButtonStyle:(CHNButtonStyle)chnButtonStyle {
    switch (chnButtonStyle) {
        case CHNButtonStyleDefault: {
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0XCCCCCC) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0XCCCCCC).CGColor;
        }
            break;
        case CHNButtonStylePrimary: {
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X337ab7) forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X2e6da4) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0X2e6da4).CGColor;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case CHNButtonStyleInfo: {
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X5bc0de) forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X46b8da) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0X46b8da).CGColor;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case CHNButtonStyleSuccess: {
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X5cb85c) forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0X4cae4c) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0X4cae4c).CGColor;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case CHNButtonStyleWarning: {
            [self setBackgroundColor:UICOLOR_FROM_HEX(0Xf0ad4e) forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0Xeea236) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0Xeea236).CGColor;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case CHNButtonStyleDanger: {
            [self setBackgroundColor:UICOLOR_FROM_HEX(0Xd9534f) forState:UIControlStateNormal];
            [self setBackgroundColor:UICOLOR_FROM_HEX(0Xd43f3a) forState:UIControlStateHighlighted];
            self.layer.borderColor = UICOLOR_FROM_HEX(0Xd43f3a).CGColor;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    // If it is normal then set the standard background here
    if(state == UIControlStateNormal) {
        [super setBackgroundColor:backgroundColor];
    }
    // Store the background colour for that state
    [_colors setValue:backgroundColor forKey:[self keyForState:state]];
}

- (UIColor *)backgroundColorForState:(UIControlState)state {
    return [_colors valueForKey:[self keyForState:state]];
}

- (NSString *)keyForState:(UIControlState)state {
    return [NSString stringWithFormat:@"state_%zi", state];
}

- (void)setHighlighted:(BOOL)highlighted {
    // Do original Highlight
    [super setHighlighted:highlighted];
    // Highlight with new colour OR replace with orignial
    NSString *highlightedKey = [self keyForState:UIControlStateHighlighted];
    UIColor *highlightedColor = [_colors valueForKey:highlightedKey];
    
    if (highlighted && highlightedColor) {
        [super setBackgroundColor:highlightedColor];
    } else {
        // 由于系统在调用setSelected后，会再触发一次setHighlighted，故做如下处理，否则，背景色会被最后一次的覆盖掉。
        if ([self isSelected]) {
            NSString *selectedKey = [self keyForState:UIControlStateSelected];
            UIColor *selectedColor = [_colors valueForKey:selectedKey];
            [super setBackgroundColor:selectedColor];
        } else {
            NSString *normalKey = [self keyForState:UIControlStateNormal];
            [super setBackgroundColor:[_colors valueForKey:normalKey]];
        }
    }
}

- (void)setSelected:(BOOL)selected {
    // Do original Selected
    [super setSelected:selected];
    
    // Select with new colour OR replace with orignial
    NSString *selectedKey = [self keyForState:UIControlStateSelected];
    UIColor *selectedColor = [_colors valueForKey:selectedKey];
    if (selected && selectedColor) {
        [super setBackgroundColor:selectedColor];
    } else {
        NSString *normalKey = [self keyForState:UIControlStateNormal];
        [super setBackgroundColor:[_colors valueForKey:normalKey]];
    }
}

@end
