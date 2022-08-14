//
//  NetTool.m
//  bsphpproxx
//
//  Created by Yi on 2019/8/5.
//

#import "NetTool.h"
#import "DES3Util.h"
#import "NSDictionary+StichingStringkeyValue.h"
#import "NSString+URLCode.h"
#import <Foundation/Foundation.h>
#define TESTLog(...)  NSLog(__VA_ARGS__)
@implementation NetTool
+ (void)Post_AppendURL:(NSString *)appendURL
                               myparameters:(NSDictionary *)param
                                  mysuccess:(void (^)(id responseObject))success  myfailure:(void (^)(NSError *error))failure{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"ok" forKey:@"json"];
    if (param != nil) {
                NSString *desString  =  [NSDictionary stitchingStringFromDictionary:param];
                NSString *md5String = [BSPHP_PASSWORD md5:BSPHP_PASSWORD];
                desString = [DES3Util encrypt:desString gkey:md5String];
//        签名
                NSString * sginstr = [BSPHP_INSGIN stringByReplacingOccurrencesOfString:@"[KEY]"withString:desString];
                NSString * sginstrMD5 = [sginstr md5:sginstr];
//                NSLog(@"replaceStr=%@",sginstrMD5);
                parameters[@"sgin"] = sginstrMD5;
        
                desString = [desString URLEncodedString];
                parameters[@"parameter"] = desString;
    }
    // 1、创建URL资源地址
    NSURL *url = [NSURL URLWithString:appendURL];
    // 2、创建Reuest请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 3、Request
    // 设置请求超时
    [request setTimeoutInterval:10.0];
    // 设置请求方法
    [request setHTTPMethod:@"POST"];
    // 设置头部参数
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 4、构造请求参数
    // 4.1、创建字典参数，将参数放入字典中，可防止程序员在主观意识上犯错误，即参数写错。
    // 4.2、遍历字典，以“key=value&”的方式创建参数字符串。
    NSMutableString *parameterString = [[NSMutableString alloc]init];
    int pos =0;
    for (NSString *key in parameters.allKeys) {
        // 拼接字符串
        [parameterString appendFormat:@"%@=%@", key, parameters[key]];
        if(pos<parameters.allKeys.count-1){
            [parameterString appendString:@"&"];
        }
        pos++;
    }
    // 4.3、NSString转成NSData数据类型。
    NSData *parametersData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
    // 5、设置请求报文
    [request setHTTPBody:parametersData];
    // 6、构造NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 设置在流量情况下是否继续请求
    configuration.allowsCellularAccess = YES;
    // 设置请求的header
    configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json",
                                            @"Accept-Language": @"en"};
    // 7、创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 8、创建会话任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 10、判断是否请求成功
        if (error)
        {
            failure(error);
        }else
        {
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSString *md5String = [BSPHP_PASSWORD md5:BSPHP_PASSWORD];
                str = [DES3Util decrypt:str gkey:md5String];
                //                                                             TESTLog(@"请求网址 = %@",appendURL);
                //                                                             TESTLog(@"parameters = %@",parameters);
                //                                                             TESTLog(@"服务器返回数据 = %@",str);
                NSData * jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                //                                                             TESTLog(@"dict = %@",json);
            
            
                NSString * insginString = [NSString stringWithFormat:@"%@%@%@%@%@", json[@"response"][@"data"], json[@"response"][@"date"],json[@"response"][@"unix"],json[@"response"][@"microtime"],json[@"response"][@"appsafecode"]];
            
                insginString = [BSPHP_TOSGIN stringByReplacingOccurrencesOfString:@"[KEY]"withString:insginString];
                //本地签名
                md5String = [insginString md5:insginString];
                NSString * sginstrMD5 = json[@"response"][@"sgin"];
                if([md5String isEqualToString:sginstrMD5]){
                    //success(data);
                    //                                                                 NSLog(@"签名验证通过\n");
                    //                                                                 NSLog(@"本地md5=%@\n",md5String);
                }else
                {
                    //                                                                 NSLog(@"签名验证未通过，安全事件可以把app关闭=%@\n",str);
                    //                                                                 NSLog(@"本地md5=%@\n",md5String);
            
                    NSData *testData = [@"-1000" dataUsingEncoding: NSUTF8StringEncoding];
                    jsonData = testData;
                }
            
//                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面...
                      success(jsonData);
//                });
        }
        
    }];
    // 9、执行任务
    [task resume];

    
}

@end
