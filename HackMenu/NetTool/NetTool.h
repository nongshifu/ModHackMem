//
//  NetTool.h
//  bsphpproxx
//
//  Created by Yi on 2019/8/5.
//

#import <Foundation/Foundation.h>
//全局服务器地址配置bsphp
#define BSPHP_HOST  @"http://iospubg.cn/AppEn.php?appid=14453246&m=7fc8ef3925df117c3ac79ee90eb6ce74"
//通信key
#define BSPHP_MUTUALKEY @"429f52997f799d939df9d951785cc0d2"
//通信密码
#define BSPHP_PASSWORD @"gcz4xsRtvg4wdlBHTh"
//签名in进认证
#define BSPHP_INSGIN @"[KEY]sf7480547"
//签名to本地认证
#define BSPHP_TOSGIN @"[KEY]sf7480547"

NS_ASSUME_NONNULL_BEGIN

@interface NetTool : NSObject
+ (void)Post_AppendURL:(NSString *)appendURL
                              myparameters:(NSDictionary *)param
                                  mysuccess:(void (^)(id responseObject))success  myfailure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
