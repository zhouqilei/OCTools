//
//  Singleton.m
//  SYApp
//
//  Created by DuQ on 14/12/12.
//  Copyright (c) 2014年 DuQ. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
    });
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)saveUserMessage{
    
    if ([Singleton shareInstance].userInfo) {
        NSString *jsstr=[[Singleton shareInstance].userInfo toJSONString];
        [USERDEFAULTS setObject:jsstr forKey:USERINFO];
    }
}

-(void)getUserMessage{
    
    NSString *jsstr=[USERDEFAULTS  valueForKey:USERINFO];
    
    if (jsstr) {
        [Singleton shareInstance].userInfo = [[UserInfo alloc]initWithString:jsstr error:nil];
    }
    
}

@end
