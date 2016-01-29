//
//  News.h
//  Xinwen
//
//  Created by hyp on 16/1/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, assign) int replyCount;

@property (nonatomic, strong) NSArray *imgextra;

+(instancetype)newsWithDict:(NSDictionary *)dict;


+ (void)loadNewsListWithUrlString:(NSString *)urlString finished:(void (^)(NSArray *newlist))finished;

@end
