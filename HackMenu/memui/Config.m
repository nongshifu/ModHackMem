// 十三哥 QQ350722326
//官网 https://iosgods.cn
#import "NetWorkingApiClient.h"
#import "Config.h"
#import "DES3Utill.h"
#import "NSDictionary+StichingStringkeyValue.h"
#import "NSString+MD5.h"
#import "NSString+URLCode.h"
#define TESTLog(...)  NSLog(__VA_ARGS__)


@implementation NetTool : NSObject
+ (NSURLSessionDataTask *)__attribute__((optnone))Post_AppendURL:(NSString *)appendURL
myparameters:(NSDictionary *)param
mysuccess:(void (^)(id responseObject))success myfailure:(void (^)(NSError *error))failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString * strpwd = NULL;
    strpwd  = [DES3Utill decrypt:LD_APIPASS gkey:LD_AAAA];
    NSString * strpwdin = NULL;
    strpwdin  = [DES3Utill decrypt:LD_IN gkey:LD_AAAA];
    NSString * strpwdto = NULL;
    strpwdto  = [DES3Utill decrypt:LD_TO gkey:LD_AAAA];
    [parameters setObject:@"ok" forKey:@"json"];
    if (param != nil) {
        NSString *desString  =  [NSDictionary stitchingStringFromDictionary:param];
        NSString *md5String = [strpwd md5:strpwd];
        desString = [DES3Utill encrypt:desString gkey:md5String];
        NSString * sginstr = [strpwdin stringByReplacingOccurrencesOfString:@"[KEY]"withString:desString];
        NSString * sginstrMD5 = [sginstr md5:sginstr];
        NSLog(@"replaceStr=%@",sginstrMD5);
        parameters[@"sgin"] = sginstrMD5;
        desString = [desString URLEncodedString];
        parameters[@"parameter"] = desString;
    }
    return [[NetWorkingApiClient sharedNetWorkingApiClient] POST:appendURL
                                                      parameters:parameters
                                                        progress:nil
                                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                             
                                                             NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                             NSString *md5String = [strpwd md5:strpwd];
                                                             str = [DES3Utill decrypt:str gkey:md5String];
                                                             //TESTLog(@"请求网址 = %@",appendURL);
                                                             ///TESTLog(@"parameters = %@",parameters);
                                                             //TESTLog(@"服务器返回数据 = %@",str);
                                                             NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
                                                             //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                             //TESTLog(@"dict = %@",dict);
                                                             
                                                             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                             
                                                             NSString * insginString = [NSString stringWithFormat:@"%@%@%@%@%@", json[@"response"][@"data"], json[@"response"][@"date"],json[@"response"][@"unix"],json[@"response"][@"microtime"],json[@"response"][@"appsafecode"]];
                                                             
                                                             insginString = [strpwdto stringByReplacingOccurrencesOfString:@"[KEY]"withString:insginString];
                                                             //本地签名
                                                             md5String = [insginString md5:insginString];
                                                             NSString * sginstrMD5 = json[@"response"][@"sgin"];
                                                             if([md5String isEqualToString:sginstrMD5]){
                                                                 //success(data);
                                                                 NSLog(@"签名验证通过\n");
                                                                 
                                                             }else{
                                                                 NSLog(@"签名验证未通过\n");
                                                                 
                                                                 
                                                                 NSData *testData = [@"-1000" dataUsingEncoding: NSUTF8StringEncoding];
                                                                 data = testData;
                                                             }
                                                             
                                                             
                                                             
                                                             success(data);
                                                         }
                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             TESTLog(@"%@",error);
                                                             failure(error);
                                                         }];
    
}




@end
