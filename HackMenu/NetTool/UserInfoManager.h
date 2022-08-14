//
//  UserInfoManager.h
//  MyView
//
//  Created by MRW on 2017/9/9.
//  Copyright © 2017年 WangzhiSong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject
+ (UserInfoManager *)shareUserInfoManager;
@property (nonatomic,strong) NSString * state01;//01
@property (nonatomic,strong) NSString * state1081;//1081
@property (nonatomic,copy) NSString * deviceID;//机器码
@property (nonatomic,copy) NSString * returnData;//返回数据
//@property (nonatomic,assign) NSUInteger *  AuthorizationState;//授权状态
@property (nonatomic,copy) NSString * activationTime;//激活时间
@property (nonatomic,copy) NSString * expirationTime;//过期时间
@end
