//
//  ChannelLabel.m
//  Xinwen
//
//  Created by hyp on 16/1/27.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

#define CZNormalFontSize 14.0
#define CZSelectedFontSize 18.0

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    ChannelLabel *l = [[ChannelLabel alloc] init];
    
    l.text = title;
    // 文本对齐方式
    l.textAlignment = NSTextAlignmentCenter;
    
    // 设置大字体，预留出左右的间距
    l.font = [UIFont systemFontOfSize:CZSelectedFontSize];
    // 根据大字体设置大小
    [l sizeToFit];
    
    // 设置成小字体
    l.font = [UIFont systemFontOfSize:CZNormalFontSize];
    
    // 允许用户交互
    [l setUserInteractionEnabled:YES];
    
    return l;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(channelLabelDidSelected:)]) {
        [self.delegate channelLabelDidSelected:self];
    }
}

- (void)setScale:(float)scale {
    // (18 - 14) / 14
    float percent = (CZSelectedFontSize - CZNormalFontSize) / CZNormalFontSize;
    // scale = 0  percent = 1
    // scale = 1  4/14 + 1;
    percent = percent * scale + 1;
    
    // 通过 transform 设置大小
    self.transform = CGAffineTransformMakeScale(percent, percent);
    
    // 设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}
@end
