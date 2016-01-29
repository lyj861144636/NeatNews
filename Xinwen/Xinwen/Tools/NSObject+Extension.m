//
//  NSObject+Extension.m
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (instancetype)objectWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    NSArray *propertis = [self loadProperties];
    
    for (NSString *key in propertis) {
        // 判断 dict 是否存在 key
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    
    return obj;
}

#pragma mark － 运行时方法
// 动态加载`类`的属性
const char *kPropertiesKey = "kPropertiesKey";
+ (NSArray *)loadProperties {
    
    // 利用`关联`对象，给`类`添加属性，OC中的类，本身就是一个特殊对象
    /**
     获取关联对象
     1. 对象，属性关联到的对象
     2. key，属性的 key
     */
    NSArray *pList = objc_getAssociatedObject(self, kPropertiesKey);
    if (pList != nil) {
        return pList;
    }
    
    /**
     1. 类
     2. 属性计数指针
     */
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSLog(@"属性数量 %u", count);
    
    // 遍历数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; ++i) {
        // C语言中没有对象的概念，一般不需要使用 `*`
        objc_property_t pty = list[i];
        
        // 属性名称
        const char *cname = property_getName(pty);
        
        // 添加到数组
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    NSLog(@"%@", arrayM);
    
    // 释放对象
    free(list);
    
    // 设置关联对象对象
    /**
     设置关联对象属性，运行时机制中，在OC开发的应用，关联对象使用的频率最高！
     
     1. 属性关联的对象
     2. key
     3. 值
     4. 引用关系
     */
    objc_setAssociatedObject(self, kPropertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, kPropertiesKey);
}


@end
