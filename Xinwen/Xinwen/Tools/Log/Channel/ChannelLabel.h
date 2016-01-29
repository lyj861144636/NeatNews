//
//  ChannelLabel.h
//  Xinwen
//
//  Created by hyp on 16/1/27.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChannelLabelDelegate;

@interface ChannelLabel : UILabel

@property (nonatomic, weak) id<ChannelLabelDelegate> delegate;



+ (instancetype)channelLabelWithTitle:(NSString *)title;

/**
 从 0~1
 0: 14 号字
 1: 18 号字
 */
@property (nonatomic, assign) float scale;

@end



@protocol ChannelLabelDelegate <NSObject>

- (void)channelLabelDidSelected:(ChannelLabel *)label;

@end
