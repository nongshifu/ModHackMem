//
//  example.m
//  PUBGMOBILENewiOSGodsComJailed
//
//  Created by apple on 2019/4/2.
//

#import <Foundation/Foundation.h>
//#import "NSURLSession+PLCategory.h"
#import <objc/runtime.h>

void swizzing(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
@implementation NSURLSession (QYCategory)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSURLSession class];
        swizzing(class, @selector(sessionWithConfiguration:), @selector(qy_sessionWithConfiguration:));
        
        swizzing(class, @selector(sessionWithConfiguration:delegate:delegateQueue:),
                 @selector(qy_sessionWithConfiguration:delegate:delegateQueue:));
    });
}

+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                     delegate:(nullable id<NSURLSessionDelegate>)delegate
                                delegateQueue:(nullable NSOperationQueue *)queue
{
    if (!configuration)
    {
        configuration = [[NSURLSessionConfiguration alloc] init];
    }
    configuration.connectionProxyDictionary = @{};
    return [self pl_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}

+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (configuration)
    {
        configuration.connectionProxyDictionary = @{};
    }
    return [self pl_sessionWithConfiguration:configuration];
}
@end
