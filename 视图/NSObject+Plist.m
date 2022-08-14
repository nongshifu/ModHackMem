//
//  NSObject+Plist.m
//  iOsGods.Cn
//
//  Created by  十三哥 on 2022/1/1.
//

#import "NSObject+Plist.h"
static NSString* 路径;
@implementation NSObject (Plist)

-(void)初始化主菜单:(NSString*)标题 字体大小:(int)字体大小 方位:(int)方位 宽度:(int)宽度 高度:(int)高度 背景颜色:(NSString*)背景颜色 标题颜色:(NSString*)标题颜色 标题背景色:(NSString*)标题背景色 背景图片:(NSString* _Nullable)背景图片 背景图透明度:(float)背景图透明度 功能数:(int)功能数
{
    if (背景图片==nil) {
        背景图片=@"";
    }
    路径 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"菜单.plist"];
    NSMutableDictionary *写文件 = [[NSMutableDictionary alloc ] init];
    //创建文件
    NSDictionary *主菜单 = @{};
    NSDictionary *子菜单 = @{};
    NSDictionary *菜单样式 = @{
        @"标题": 标题,
        @"字体大小":[NSString stringWithFormat:@"%d",字体大小],
        @"方位":[NSString stringWithFormat:@"%d",方位],
        @"宽度":[NSString stringWithFormat:@"%d",宽度],
        @"高度":[NSString stringWithFormat:@"%d",高度],
        @"背景颜色":背景颜色,
        @"标题颜色":标题颜色,
        @"标题背景色":标题背景色,
        @"背景图片":背景图片,
        @"背景图透明度":[NSString stringWithFormat:@"%.2f",背景图透明度],
        @"功能数":[NSString stringWithFormat:@"%.d",功能数]
        
    };
    [写文件 setObject:主菜单 forKey:@"主菜单"];
    [写文件 setObject:子菜单 forKey:@"子菜单"];
    [写文件 setObject:菜单样式 forKey:@"菜单样式"];
    [写文件 writeToFile:路径 atomically:YES];
    //初始化
    NSDictionary *主菜单功能 = @{
       
    };
    NSDictionary *子菜单功能 = @{
       
    };
    
    
    //获取路径
    NSMutableDictionary *infolist= [[[NSMutableDictionary alloc]initWithContentsOfFile:路径] mutableCopy];

    //读取主菜单
    NSMutableDictionary *读取主菜单 = [infolist objectForKey:@"主菜单"];
    NSMutableDictionary *读取子菜单 = [infolist objectForKey:@"主菜单"];
    //转换为 NSDictionary
    NSDictionary *初始化主菜单 = [读取主菜单 objectForKey:@"主菜单"];
    NSDictionary *初始化子菜单 = [读取子菜单 objectForKey:@"子菜单"];
    //进行替换修改器
    初始化主菜单 = 主菜单功能;
    初始化子菜单 = 子菜单功能;
    for (int i=0; i<50; i++){
        [读取主菜单 setValue:主菜单功能 forKey:[NSString stringWithFormat:@"%d",i]];
        [读取子菜单 setValue:子菜单功能 forKey:[NSString stringWithFormat:@"%d",i]];
    }
    //储存到NSDictionary 保存
    [infolist setValue:读取主菜单 forKey:@"主菜单"];
    [infolist setValue:读取子菜单 forKey:@"子菜单"];
    [infolist writeToFile:路径 atomically:YES];
    

    
}
- (void)文字:(int)排序 菜单类型:(int)菜单类型 标题:(NSString*)标题 字体大小:(int)字体大小 标题颜色:(NSString*)标题颜色 方位:(int)方位 小标题:(NSString*_Nullable)小标题 小标题颜色:(NSString*)小标题颜色 归属:(int)归属 调用:(NSString*_Nullable)调用
{
    if (小标题==nil) {
        小标题=@"";
    }
    if (调用==nil) {
        调用=@"";
    }
    NSDictionary *功能 = @{
        @"排序": [NSString stringWithFormat:@"%d",排序],
        @"添加类型": @"添加文字",
        @"菜单类型": [NSString stringWithFormat:@"%d",菜单类型],
        @"标题": 标题,
        @"字体大小":[NSString stringWithFormat:@"%d",字体大小],
        @"标题颜色": 标题颜色,
        @"方位":[NSString stringWithFormat:@"%d",方位],
        @"小标题": 小标题,
        @"小标题颜色": 小标题颜色,
        @"归属": [NSString stringWithFormat:@"%d",归属],
        @"调用":调用
    };
    NSMutableDictionary *读取为可变字典= [[[NSMutableDictionary alloc] initWithContentsOfFile:路径]mutableCopy];
    //获取初一班的信息
    NSString* 类型;
    if (菜单类型==0) {
        类型=@"主菜单";
    } else {
        类型=@"子菜单";
    }
    NSMutableDictionary *info = [读取为可变字典 objectForKey:类型];
    NSString* 排序ID=[NSString stringWithFormat:@"%d",排序];
    NSDictionary *转换 = [info objectForKey:排序ID];
    转换 = 功能;
    [info setValue:转换 forKey:排序ID];
    [读取为可变字典 setValue:info forKey:类型];
    [读取为可变字典 writeToFile:路径 atomically:YES];
}
- (void)滑条:(int)排序 菜单类型:(int)菜单类型 小标题:(NSString*_Nullable)小标题 最大:(NSString*_Nullable)最大 最小:(NSString*_Nullable)最小 初始:(NSString*_Nullable)初始 滑块色:(NSString*)滑块色 归属:(int)归属 调用:(NSString*_Nullable)调用
{
    if (小标题==nil) {
        小标题=@"";
    }
    if (调用==nil) {
        调用=@"";
    }
    NSDictionary *功能 = @{
        @"排序": [NSString stringWithFormat:@"%d",排序],
        @"添加类型": @"添加滑条",
        @"菜单类型": [NSString stringWithFormat:@"%d",菜单类型],
        @"小标题": 小标题,
        @"最大":最大,
        @"最小":最小,
        @"初始":初始,
        @"滑块色": 滑块色,
        @"归属":[NSString stringWithFormat:@"%d",归属],
        @"调用":调用
        
    };
    NSMutableDictionary *读取为可变字典= [[[NSMutableDictionary alloc] initWithContentsOfFile:路径]mutableCopy];
    //获取初一班的信息
    NSString* 类型;
    if (菜单类型==0) {
        类型=@"主菜单";
    } else {
        类型=@"子菜单";
    }
    NSMutableDictionary *info = [读取为可变字典 objectForKey:类型];
    NSString* 排序ID=[NSString stringWithFormat:@"%d",排序];
    NSDictionary *转换 = [info objectForKey:排序ID];
    转换 = 功能;
    [info setValue:转换 forKey:排序ID];
    [读取为可变字典 setValue:info forKey:类型];
    [读取为可变字典 writeToFile:路径 atomically:YES];

    
}
- (void)开关:(int)排序 菜单类型:(int)菜单类型 标题:(NSString*)标题 字体大小:(int)字体大小 方位:(int)方位 字体颜色:(NSString*)字体颜色 小标题:(NSString*_Nullable)小标题 小标题颜色:(NSString*)小标题颜色 开启图标地址:(NSString * _Nullable)开启图标地址 关闭图标地址:(NSString * _Nullable)关闭图标地址 归属:(int)归属 调用:(NSString*_Nullable)调用
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:标题];
    });
    if (开启图标地址==nil) {
        开启图标地址=@"";
    }
    if (关闭图标地址==nil) {
        关闭图标地址=@"";
    }
    if (小标题==nil) {
        小标题=@"";
    }
    if (调用==nil) {
        调用=@"";
    }
    NSDictionary *功能 = @{
        @"排序": [NSString stringWithFormat:@"%d",排序],
        @"添加类型": @"添加开关",
        @"菜单类型": [NSString stringWithFormat:@"%d",菜单类型],
        @"标题": 标题,
        @"字体大小": [NSString stringWithFormat:@"%d",字体大小],
        @"方位": [NSString stringWithFormat:@"%d",方位],
        @"字体颜色": 字体颜色,
        @"小标题": 小标题,
        @"小标题颜色": 小标题颜色,
        @"开启图标地址": [NSString stringWithFormat:@"%@",开启图标地址],
        @"关闭图标地址": [NSString stringWithFormat:@"%@",关闭图标地址],
        @"归属": [NSString stringWithFormat:@"%d",归属],
        @"调用":调用,
        
        
    };
    NSMutableDictionary *读取为可变字典= [[[NSMutableDictionary alloc] initWithContentsOfFile:路径]mutableCopy];
    //获取初一班的信息
    NSString* 类型;
    if (菜单类型==0) {
        类型=@"主菜单";
    } else {
        类型=@"子菜单";
    }
    NSMutableDictionary *info = [读取为可变字典 objectForKey:类型];
    NSString* 排序ID=[NSString stringWithFormat:@"%d",排序];
    NSDictionary *转换 = [info objectForKey:排序ID];
    转换 = 功能;
    [info setValue:转换 forKey:排序ID];
    [读取为可变字典 setValue:info forKey:类型];
    [读取为可变字典 writeToFile:路径 atomically:YES];

    
}
@end
