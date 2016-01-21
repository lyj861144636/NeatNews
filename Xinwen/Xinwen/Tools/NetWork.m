//
//  NetWork.m
//  Xinwen
//
//  Created by hyp on 16/1/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

+ (instancetype)sharedNetWork
{
    static NetWork *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc] initWithBaseURL:url];
    });
    return instance;
}


@end
