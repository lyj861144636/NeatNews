//
//  NetWork.h
//  Xinwen
//
//  Created by hyp on 16/1/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetWork : AFHTTPSessionManager

+ (instancetype)sharedNetWork;

@end
