//
//  TopView.m
//  Xinwen
//
//  Created by hyp on 16/1/27.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "TopView.h"
#import "Channel.h"

@implementation TopView


- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewsArr:arr];
    }
    return self;
}

- (void)createViewsArr:(NSArray *)arr
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.frame.size.height)];
    [self addSubview:scroll];
    
    
    
    NSInteger index = 0;
    for (Channel *channel in arr) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(index, 4, lab.bounds.size.width, self.frame.size.height);
        lab.text = channel.tname;
        lab.font = [UIFont systemFontOfSize:18];
        lab.textAlignment = NSTextAlignmentCenter;
        [lab sizeToFit];

        lab.font = [UIFont systemFontOfSize:14];
        
       index += lab.bounds.size.width;
        [scroll addSubview:lab];
    }
    
    scroll.contentSize = CGSizeMake(index + 8, self.frame.size.height);
}


@end
