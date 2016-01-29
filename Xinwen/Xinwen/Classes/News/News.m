//
//  News.m
//  Xinwen
//
//  Created by hyp on 16/1/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "News.h"
#import "NetWork.h"
#import "NSObject+Extension.h"

@implementation News

+(instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}


+(void)loadNewsListWithUrlString:(NSString *)urlString finished:(void (^)(NSArray *))finished
{
   NSAssert(finished != nil, @"必须传入完成回调");
    [[NetWork sharedNetWork] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSLog(@"url ==== %@", urlString);
        NSArray *arr = responseObject[responseObject.keyEnumerator.nextObject];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dic in arr) {
            [arrM addObject:[self newsWithDict:dic]];
        }
        
        finished(arrM.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



-(NSString *)description
{
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}
@end
