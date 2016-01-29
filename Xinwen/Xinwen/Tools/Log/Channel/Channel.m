//
//  Channel.m
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "Channel.h"
#import "NSObject+Extension.h"

@implementation Channel

-(void)setTid:(NSString *)tid
{
    _tid = tid.copy;
    _urls = [NSString stringWithFormat:@"%@/0-20.html", _tid];
}


+(NSArray *)channelList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *arr = dict[dict.keyEnumerator.nextObject];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    
    for (NSDictionary *dic in arr) {
        [arrM addObject:[self objectWithDict:dic]];
    }
    
    return [arrM sortedArrayUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
//    return arrM.copy;
}

// description 不要抽取，放在各自类中，写不好会死循环！
- (NSString *)description {
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}

@end
