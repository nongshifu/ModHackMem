
// 十三哥 QQ350722326
//官网 https://iosgods.cn

#import <Foundation/Foundation.h>
//全局配置BSPHP
//下面信息通过软件后台>软件>对应软件设置上获得
//全局服务器地址
#define  LD_API  @"DvGVQ9MtoxCe/AwHeEPqJpFf3CWbRftibaXZzvSCIoDTDvUyrDXKyNW7tOqXL5ha7qlSTEwBNeoew52I+DqxuCab87Y3ooYNpM8t+Lq4LbA="

//通信key
#define LD_KEY @"57a9pjKKhyYoocxvOQENu2RNkQvruIY/Km/HlPgjzvW23Cua8FwrgA=="

//通信密码
#define LD_APIPASS @"Ha3OaKKbkmsZdPvnwdK/H1CunMrGYm7l"
//默认无修改
#define LD_AAAA @"123456781234567812345678"
//远程菜单
//QQ飞飞车pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfH0VQ5tMgsyU9MEjXAMKKCA==
//王者pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfx8SpJ05NV2xi+eupx7CFnO1JTJeqmJOY
#define LD_URL @"pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfH0VQ5tMgsyU9MEjXAMKKCA=="
//签名in进认证
#define LD_IN @"Qyrxke2qEaC59N/oeuSajQ=="
//签名to本地认证
#define LD_TO @"Qyrxke2qEaC59N/oeuSajQ=="

#define LD_VERSION @"RGL0bZgWeOw="


//POST默认

@interface NetTool : NSObject

/**
 *  AFN异步发送post请求，返回原生数据
 *
 *  @param appendURL 追加URL
 *  @param param     参数字典
 *  @param success   成功Block
 *  @param failure   失败Block
 *
 *  @return NSURLSessionDataTask任务类型
 */
+ (NSURLSessionDataTask *)__attribute__((optnone))Post_AppendURL:(NSString *)appendURL myparameters:(NSDictionary *)param mysuccess:(void (^)(id responseObject))success myfailure:(void (^)(NSError *error))failure;
@end
