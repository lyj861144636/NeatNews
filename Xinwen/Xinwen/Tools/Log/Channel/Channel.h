//
//  Channel.h
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;


@property (nonatomic, strong, readonly) NSString *urls;


+ (NSArray *)channelList;

@end
