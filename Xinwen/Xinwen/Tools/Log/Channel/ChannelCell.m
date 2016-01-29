//
//  ChannelCell.m
//  Xinwen
//
//  Created by hyp on 16/1/28.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "ChannelCell.h"

@interface ChannelCell()



@end


@implementation ChannelCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vc = [[ViewController alloc] init];
    
        [self addSubview:self.vc.view];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.vc.view.frame = self.bounds;
}

-(void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    self.vc.urlUrl = urlStr;
}




@end
