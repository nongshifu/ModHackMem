//
//  UserInfoManager.m
//  MyView
//
//  Created by MRW on 2017/9/9.
//  Copyright © 2017年 WangzhiSong. All rights reserved.
//

#import "UserInfoManager.h"
static UserInfoManager *manager = nil;
@implementation UserInfoManager
+ (UserInfoManager *)__attribute__((optnone))shareUserInfoManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc]init];
    });
    return manager;
}
@end
