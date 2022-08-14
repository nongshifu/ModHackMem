//
//  NSObject+Menu.m
//  iOsGods.Cn
//
//  Created by  十三哥 on 2022/1/1.
#import "DLGMemUIView.h"
#import "NSObject+UI.h"
#import "NSObject+Plist.h"
#import "NSObject+Menu.h"
#import "DLGMem.h"
#include <JRMemory/MemScan.h>
#import "DLGMemUIView.h"
@implementation NSObject (Menu)
+ (void)load
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //第一个初始化一个菜单 宽度为300 高度250  功能数就是 0开始为第一个 比如以下0~5 就是是6个功能  调用 就是调用的功能
        [NSObject 初始化主菜单:@"🔥420385778南风售后任何问题请联系此方式🔥" 字体大小:13 方位:0 宽度:330 高度:330
            背景颜色:@"0,0,0,0.1" 标题颜色:@"1,1,1,1" 标题背景色:@"0,0,0,0,0.1" 背景图片:nil 背景图透明度:0.1 功能数:40];
        [NSObject 滑条:0 菜单类型:0 小标题:@"后座自定义" 最大:@"0.09" 最小:@"0" 初始:@"0" 滑块色:@"1,0.6,0,1" 归属:0 调用:@"滑条DD后座"];// 滑条会调用
        [NSObject 开关:1 菜单类型:0 标题:@"射速" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"滑条2射速"];
        [NSObject 开关:2 菜单类型:0 标题:@"走速微调" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一把一开" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"滑条CC走速"];
        [NSObject 开关:3 菜单类型:0 标题:@"飞天" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一把一开" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"滑条4LL飞天"];
        [NSObject 开关:4 菜单类型:0 标题:@"单透" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一局开一次角色死了第2局生效" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关BB"];
        [NSObject 开关:5 菜单类型:0 标题:@"双透" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一局开一次角色死了第2局生效" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关透视2"];
        [NSObject 开关:6 菜单类型:0 标题:@"锁头" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"注意演戏拉闸仔" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关DD锁头"];
        [NSObject 开关:7 菜单类型:0 标题:@"挑战无敌" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"只可以进俱乐部打BOSS打死你后生效" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关EE挑战无敌"];
        [NSObject 开关:8 菜单类型:0 标题:@"范围射程加倍" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"加射程的" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关FF范围射程加倍"];
        [NSObject 开关:9 菜单类型:0 标题:@"隔墙透视" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一局开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关GG隔墙透视"];
        [NSObject 开关:10 菜单类型:0 标题:@"狙击穿牆" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"容易闪退" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关HH狙击穿牆"];
        [NSObject 开关:11 菜单类型:0 标题:@"屠龙刀速" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"屠龙刀有效果" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关JJ屠龙刀速"];
        [NSObject 开关:12 菜单类型:0 标题:@"人物视角加高" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"一局开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:0 调用:@"开关KK人物视角加高"];
        [NSObject 开关:13 菜单类型:0 标题:@"遁地" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"男角色使用" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:0 调用:@"开关QQ遁地"];
        [NSObject 开关:14 菜单类型:0 标题:@"步枪穿墙" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"步枪使用测试" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:0 调用:@"开关WWG步枪穿墙"];
        [NSObject 开关:15 菜单类型:0 标题:@"人物穿墙" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"测试中" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:0 调用:@"开关WAAG人物穿墙"];
        [NSObject 开关:16 菜单类型:0 标题:@"子弹穿墙" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"开关KK子弹穿墙"];
        [NSObject 开关:17 菜单类型:0 标题:@"DLG修改器" 字体大小:15 方位:0 字体颜色:@"1,0,1,1" 小标题:@"会修改再打开这个不过直播" 小标题颜色:@"1,0,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:0 调用:@"DLG"];
        
        
        
        [NSObject 文字:19 菜单类型:0 标题:@"双透" 字体大小:20 标题颜色:@"1,0,0,1" 方位:1 小标题:@"" 小标题颜色:@"0,1,1,1" 归属:0 调用:@"开关透视2"];
        
        
        [NSObject 开关:20 菜单类型:0 标题:@"祥龙39专区" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:20 调用:@"祥龙39专区"];
        [NSObject 滑条:9 菜单类型:1 小标题:@"祥龙39后座自定义" 最大:@"0.09" 最小:@"0" 初始:@"0" 滑块色:@"1,0.6,0,1" 归属:20 调用:@"滑条祥龙后座"];// 滑条会调用 滑条1范围
        [NSObject 滑条:10 菜单类型:1 小标题:@"祥龙39射速自定义" 最大:@"0.09" 最小:@"0" 初始:@"0" 滑块色:@"1,0.6,0,1" 归属:20 调用:@"祥龙39射速"];// 滑条会调用 滑条1范围
        [NSObject 开关:11 菜单类型:1 标题:@"范围0.5倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:20 调用:@"功能范围0.5倍"];
        
        
        [NSObject 开关:18 菜单类型:0 标题:@"范围" 字体大小:15 方位:0 字体颜色:@"1,1,1,1" 小标题:@"" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:nil 归属:18 调用:@"范围"];
        [NSObject 开关:1 菜单类型:1 标题:@"范围0.5倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围0.5倍"];
        [NSObject 开关:2 菜单类型:1 标题:@"范围1倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围1倍"];
        [NSObject 开关:3 菜单类型:1 标题:@"范围2倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围2倍"];
        [NSObject 开关:4 菜单类型:1 标题:@"范围3倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围3倍"];
        [NSObject 开关:5 菜单类型:1 标题:@"范围4倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围4倍"];
        [NSObject 开关:6 菜单类型:1 标题:@"范围5倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围5倍"];
        [NSObject 开关:7 菜单类型:1 标题:@"范围6倍" 字体大小:15 方位:0 字体颜色:@"0,1,0,6" 小标题:@"步枪手枪狙击使用只能开一次" 小标题颜色:@"1,1,1,1" 开启图标地址:nil 关闭图标地址:@"nil" 归属:18 调用:@"功能范围6倍"];
        [NSObject 滑条:8 菜单类型:1 小标题:@"祥龙39射速自定义" 最大:@"0.09" 最小:@"0" 初始:@"0" 滑块色:@"1,0.6,0,1" 归属:18 调用:@"祥龙39射速"];//滑条会调用 滑条1范围
        
        //归属 99就是 定义一个值99 可以是任意值 不能英文中文
        // 注意格式 第一个值 排序必须是数字 第二个值只有0和1 (0显示在主菜单 1显示在子菜单) 图片地址:不用图片就输入 英文 nil  小标题不用也可以输入nil
        // 初始化主菜单的标题最大是20 大于20也显示20 功能里字体大小最大是15
        // 方位: 有三个可选值 0 1 2  其中0 代表文字居左  1代表居左 2代表居右
        //各种 颜色: 里面必须有4个值 如: @"1,0,0,1"  分别为 @"红,绿,蓝,透明度"
        
    });
        
}
-(void)功能:(NSString *)调用 值:(NSString *)值
{
    //这里是判断传过来的 调用:选项 和 值:具体值
    //功能AA 传过来的是 功能AA 刚好符合上面 + (void)load 方法里的第一个主菜单第1个功能 滑条 所以当滑条滑动 就调用这里
    if ([调用 isEqualToString:@"DLG"]) {
     //   修改器
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[DLGMem alloc] DLG];
        });
     //   NSLog(@"功能AA =%@   调用:%@",值,调用);
    }
    if ([调用 isEqualToString:@"测试按钮"]) {
        
        NSLog(@"测试按钮倍点击了执行这里");
    }
     if ([调用 isEqualToString:@"祥龙39射速"]) {
                     //功能1战白金通用后座
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                 AddrRange range = (AddrRange){0x100000000,0x160000000};
                 float search = 0.096;
                 engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                 vector<void*>results = engine.getAllResults();
                 float modify =[值 floatValue];//
                 for(int i =0;i<results.size();i++){
                 if(i <=1000&&i>=0)
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                             }
                       });
             }
    
    
    
    
     if ([调用 isEqualToString:@"滑条祥龙后座"]) {
                  //功能1战白金通用后座
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
              AddrRange range = (AddrRange){0x100000000,0x160000000};
              float search = 0.43;
              engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
              vector<void*>results = engine.getAllResults();
              float modify =[值 floatValue];//
              for(int i =0;i<results.size();i++){
              if(i <=1000&&i>=0)
              engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                          }
                    });
          }
    
    
    
    
    
    if ([调用 isEqualToString:@"开关透视2"]) {
                //内存代码
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
           AddrRange range = (AddrRange){0x000000000,0x200000000};
       //     JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            uint32_t search = 512;
            engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
            float search1 = 2.5;
            engine.JRNearBySearch(0x200,&search1,JR_Search_Type_Float);
            float search2 = 0.01;
            engine.JRNearBySearch(0x200,&search2,JR_Search_Type_Float);
            uint32_t search3 = 512;
            engine.JRScanMemory(range,&search3,JR_Search_Type_UInt);
            vector<void*>results = engine.getAllResults();
            uint32_t modify = 1010550;
            for(int i =0;i<results.size();i++){
                engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
            }
                });
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x000000000,0x200000000};
          //    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
          uint32_t search = 1010550;
          engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
          float search1 = 2.5;
          engine.JRNearBySearch(0x200,&search1,JR_Search_Type_Float);
          float search2 = 0.01;
          engine.JRNearBySearch(0x200,&search2,JR_Search_Type_Float);
          float search3 = 2.5;
      engine.JRScanMemory(range,&search3,JR_Search_Type_Float);
      vector<void*>results = engine.getAllResults();
          float modify = 1000;
          for(int i =0;i<results.size();i++){
          engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
    
              
            }
           
                });
                   }
    if ([调用 isEqualToString:@"开关KK子弹穿墙"]) {
                            //内存代码
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                 AddrRange range = (AddrRange){0x100000000,0x160000000};
                                 uint32_t search = 1008981770;
                                 engine.JRScanMemory(range, &search, JR_Search_Type_UInt ); // 搜索
                                 uint32_t search1 = 900762;
                                 engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt);
                                 uint32_t search2 = 100;
                                 engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt);
                                 uint32_t search3 = 4;
                                 engine.JRNearBySearch(0x100,&search3,JR_Search_Type_UInt);
                                 uint32_t search4 = 4;
                                 engine.JRScanMemory(range, &search4, JR_Search_Type_UInt ); // 搜索
                                 vector<void*>results = engine.getAllResults();
                                uint32_t modify = 2144061856;
                                 for(int i =0;i<results.size();i++){
                                     engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);

                        }
                            });
                                //功能2
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                      AddrRange range = (AddrRange){0x100000000,0x160000000};
                                      uint32_t search = -1082130432;
                                      engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
                                      uint32_t search1 = 1013276738;
                                      engine.JRNearBySearch(0x150,&search1, JR_Search_Type_UInt);
                                      uint32_t search2 = -1082130432;
                                      engine.JRNearBySearch(0x150,&search2, JR_Search_Type_UInt);
                                      uint32_t search3 = -1082130432;
                                      engine.JRScanMemory(range, &search3,JR_Search_Type_UInt);
                                      vector<void*>results = engine.getAllResults();
                                      uint32_t modify = 2139666666;
                                      for(int i =0;i<results.size();i++){
                                      if(i <=5500&&i>=0)
                                      engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);

                           }
                           
                       });
                                                               //功能3
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
              AddrRange range = (AddrRange){0x100000000,0x200000000};    // 搜索范围
              uint32_t search = 1008981770;//f32搜索 0.05499718338
              engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
              uint32_t search1 = 100;//联合f32  223235232
              engine.JRNearBySearch(0x200,&search1,JR_Search_Type_UInt); // 联合
              uint32_t search2 = 900762;//联合f32  223235232
              engine.JRNearBySearch(0x200,&search2,JR_Search_Type_UInt); // 联合
              uint32_t search3 = 4;//联合f32  223235232
              engine.JRNearBySearch(0x200,&search3,JR_Search_Type_UInt); // 联合
              uint32_t search4 = 4;// 取消联合并搜索f32    0.05499718338
          engine.JRScanMemory(range, &search4,JR_Search_Type_UInt); // 取消联合并精确数值
          vector<void*>results = engine.getAllResults();
          uint32_t modify = 2144061856;   //搜索到刚刚取消联合的修改
          for(int i =0;i<results.size();i++){
          if(i <=3000&&i>=0)
          engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);

     
                        }
                       
                            });
                               }
    if ([调用 isEqualToString:@"测试范围"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
            float search = -1;//f32搜索 0.05499718338
            engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            uint32_t search1 = 180;//联合f32  223235232
            engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
            uint32_t search2 = 100;//联合f32  223235232
            engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
            float search3 = -1;// 取消联合并搜索f32    0.05499718338
            engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
            vector<void*>results = engine.getAllResults();
            float modify = 0.4; // 修改成
            for(int i =0;i<results.size();i++){
                if(i>0){
                    engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                    
                }
                
            }
            
        });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
        float search = 0.4;//f32搜索 0.05499718338
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = 0.0805;//联合f32  223235232
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 0.0805;// 取消联合并搜索f32    0.05499718338
        engine.JRScanMemory(range, &search2,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults();
        float modify = 0.075;   //搜索到刚刚取消联合的0.05499718338
        for(int i =0;i<results.size();i++){
            if(i>0){
            engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                
            }
            
        }
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
      AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
      float search = 0.075;//f32搜索 0.05499718338
      engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
      float search1 = 0.26;//联合f32  223235232
      engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
      float search2 = 0.26;// 取消联合并搜索f32    0.05499718338
      engine.JRScanMemory(range, &search2,JR_Search_Type_Float); // 取消联合并精确数值
      vector<void*>results = engine.getAllResults();
      float modify = 0.1;   //搜索到刚刚取消联合的0.05499718338
      for(int i =0;i<results.size();i++){
    if(i>0){
     engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                    }
                   }
              });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                     AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
                     float search = 0.01;//f32搜索 0.05499718338
                     engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                     uint32_t search1 = 180;//联合f32  223235232
                     engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                     uint32_t search2 = 100;//联合f32  223235232
                     engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                     float search3 = 0.01;// 取消联合并搜索f32    0.05499718338
                     engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                     vector<void*>results = engine.getAllResults();
                     float modify = 0.4;   //搜索到刚刚取消联合的0.05499718338
      for(int i =0;i<results.size();i++){
    if(i>0){
     engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                    }
                   }
              });
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                          AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
                          float search = 0.4;//f32搜索 0.05499718338
                          engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                          float search1 = 0.096;//联合f32  223235232
                          engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                          float search2 = 0.096;// 取消联合并搜索f32    0.05499718338
                          engine.JRScanMemory(range, &search2,JR_Search_Type_Float); // 取消联合并精确数值
                          vector<void*>results = engine.getAllResults();
                          float modify = 0.088;   //搜索到刚刚取消联合的0.05499718338
           for(int i =0;i<results.size();i++){
         if(i>0){
          engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                         }
                        }
                   });
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                          AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
                          float search = 0.088;//f32搜索 0.05499718338
                          engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                          float search1 = 0.43;//联合f32  223235232
                          engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                          float search2 = 0.43;// 取消联合并搜索f32    0.05499718338
                          engine.JRScanMemory(range, &search2,JR_Search_Type_Float); // 取消联合并精确数值
                          vector<void*>results = engine.getAllResults();
                          float modify = 0.1;   //搜索到刚刚取消联合的0.05499718338
           for(int i =0;i<results.size();i++){
           if(i>0){
            engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
               
               
               
               
               
               
               
                                     }
                                  }
                              });
                        }
       
        
        
             
                       if ([调用 isEqualToString:@"功能范围0.5倍"]) {
                                  
                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                               JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                               AddrRange range = (AddrRange){0x100000000,0x200000000};
                                uint32_t search = 1008981770;//搜索
                               engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
                                uint32_t search1 = 1036831949;//联合
                               engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                                uint32_t search2 = 1036831949;//联合
                               engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                                uint32_t search3 = 1008981770;// 取消联合并搜索
                               engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
                               vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                                uint32_t modify = 1028443341; // 修改成
                               for(int i =0;i<results.size();i++){
                               if(i>0){
                               engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
                              
                                                 }
                                              }
                                          });
                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                              JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                               AddrRange range = (AddrRange){0x100000000,0x200000000};
                             float search = 0.1;//搜索
                              engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                              float search1 = -1;//联合
                               engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                               float search2 = -1;//联合
                               engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                              float search3 = -1;// 取消联合并搜索
                              engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                              vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                                float modify = 0.05; // 修改成
                              for(int i =0;i<results.size();i++){
                            if(i>0){
                             engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                            }
                                           }
                                      });
                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                              JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                               AddrRange range = (AddrRange){0x100000000,0x200000000};
                               float search = 0.1;//搜索
                              engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                              float search1 = 0.00999999978;//联合
                              engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                               float search2 = 0.00999999978;//联合
                               engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                               float search3 = 0.00999999978;// 取消联合并搜索
                               engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                              vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                               float modify = 0.05; // 修改成
                              for(int i =0;i<results.size();i++){
                              if(i>0){
                               engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                        }
                                                     }
                                                 });
                                           }
             
             
             
             
             
             
        
        
               if ([调用 isEqualToString:@"功能范围4倍"]) {
                             
                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                          JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                          AddrRange range = (AddrRange){0x100000000,0x200000000};
                           uint32_t search = 1008981770;//搜索
                          engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
                           uint32_t search1 = 1036831949;//联合
                          engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                           uint32_t search2 = 1036831949;//联合
                          engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                           uint32_t search3 = 1008981770;// 取消联合并搜索
                          engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
                          vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                           uint32_t modify = 1053609165; // 修改成
                          for(int i =0;i<results.size();i++){
                          if(i>0){
                          engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
                         
                                            }
                                         }
                                     });
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                          AddrRange range = (AddrRange){0x100000000,0x200000000};
                        float search = 0.1;//搜索
                         engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                         float search1 = -1;//联合
                          engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                          float search2 = -1;//联合
                          engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                         float search3 = -1;// 取消联合并搜索
                         engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                         vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                           float modify = 0.4; // 修改成
                         for(int i =0;i<results.size();i++){
                       if(i>0){
                        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                       }
                                      }
                                 });
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                          AddrRange range = (AddrRange){0x100000000,0x200000000};
                          float search = 0.1;//搜索
                         engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                         float search1 = 0.00999999978;//联合
                         engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                          float search2 = 0.00999999978;//联合
                          engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                          float search3 = 0.00999999978;// 取消联合并搜索
                          engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                         vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                          float modify = 0.4; // 修改成
                         for(int i =0;i<results.size();i++){
                         if(i>0){
                          engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                   }
                                                }
                                            });
                                      }
        
        
        
        
        
        
        
              if ([调用 isEqualToString:@"功能范围2倍"]) {
                            
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                         AddrRange range = (AddrRange){0x100000000,0x200000000};
                          uint32_t search = 1008981770;//搜索
                         engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
                          uint32_t search1 = 1036831949;//联合
                         engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                          uint32_t search2 = 1036831949;//联合
                         engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                          uint32_t search3 = 1008981770;// 取消联合并搜索
                         engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
                         vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                          uint32_t modify = 1045220557; // 修改成
                         for(int i =0;i<results.size();i++){
                         if(i>0){
                         engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
                        
                                           }
                                        }
                                    });
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                         AddrRange range = (AddrRange){0x100000000,0x200000000};
                         float search = 0.1;//搜索
                         engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                         float search1 = -1;//联合
                         engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                         float search2 = -1;//联合
                         engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                         float search3 = -1;// 取消联合并搜索
                         engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                         vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                          float modify = 0.2; // 修改成
                         for(int i =0;i<results.size();i++){
                         if(i>0){
                         engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                       }
                                     }
                                });
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                         AddrRange range = (AddrRange){0x100000000,0x200000000};
                         float search = 0.1;//搜索
                        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                        float search1 = 0.00999999978;//联合
                        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                         float search2 = 0.00999999978;//联合
                         engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                         float search3 = 0.00999999978;// 取消联合并搜索
                         engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                         float modify = 0.2; // 修改成
                        for(int i =0;i<results.size();i++){
                        if(i>0){
                         engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                  }
                                               }
                                           });
                                     }
          
        
         if ([调用 isEqualToString:@"功能范围1倍"]) {
                          
                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                       AddrRange range = (AddrRange){0x100000000,0x200000000};
                        uint32_t search = 1008981770;//搜索
                       engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
                        uint32_t search1 = 1036831949;//联合
                       engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                        uint32_t search2 = 1036831949;//联合
                       engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                        uint32_t search3 = 1008981770;// 取消联合并搜索
                       engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
                       vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                        uint32_t modify = 1036831949; // 修改成
                       for(int i =0;i<results.size();i++){
                       if(i>0){
                       engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
                      
                                         }
                                      }
                                  });
                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                       AddrRange range = (AddrRange){0x100000000,0x200000000};
                       float search = 0.1;//搜索
                       engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                       float search1 = -1;//联合
                       engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                       float search2 = -1;//联合
                       engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                       float search3 = -1;// 取消联合并搜索
                       engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                       vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                        float modify = 0.1; // 修改成
                       for(int i =0;i<results.size();i++){
                       if(i>0){
                       engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                     }
                                   }
                              });
                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                       AddrRange range = (AddrRange){0x100000000,0x200000000};
                       float search = 0.1;//搜索
                      engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                      float search1 = 0.00999999978;//联合
                      engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                       float search2 = 0.00999999978;//联合
                       engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                       float search3 = 0.00999999978;// 取消联合并搜索
                       engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                      vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                       float modify = 0.1; // 修改成
                      for(int i =0;i<results.size();i++){
                      if(i>0){
                       engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                }
                                             }
                                         });
                                   }
        
        
        
        
        
        
        
        
        
        
        
        
        if ([调用 isEqualToString:@"功能范围6倍"]) {
                   
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x100000000,0x200000000};
                 uint32_t search = 1008981770;//搜索
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
                 uint32_t search1 = 1036831949;//联合
                engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
                 uint32_t search2 = 1036831949;//联合
                engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
                 uint32_t search3 = 1008981770;// 取消联合并搜索
                engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
                vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                 uint32_t modify = 1058642330; // 修改成
                for(int i =0;i<results.size();i++){
                if(i>0){
                engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
               
                                  }
                               }
                           });
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x100000000,0x200000000};
                float search = 0.1;//搜索
                engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                float search1 = -1;//联合
                engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                float search2 = -1;//联合
                engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                float search3 = -1;// 取消联合并搜索
                engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                 float modify = 0.6; // 修改成
                for(int i =0;i<results.size();i++){
                if(i>0){
                engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                              }
                            }
                       });
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x100000000,0x200000000};
                float search = 0.1;//搜索
               engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
               float search1 = 0.00999999978;//联合
               engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                float search2 = 0.00999999978;//联合
                engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                float search3 = 0.00999999978;// 取消联合并搜索
                engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
               vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                float modify = 0.6; // 修改成
               for(int i =0;i<results.size();i++){
               if(i>0){
                engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                         }
                                      }
                                  });
                            }
        
        
        
        
        
        
        if ([调用 isEqualToString:@"功能范围3倍"]) {
                
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x100000000,0x200000000};
              uint32_t search = 1008981770;//搜索
             engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
              uint32_t search1 = 1036831949;//联合
             engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
              uint32_t search2 = 1036831949;//联合
             engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
              uint32_t search3 = 1008981770;// 取消联合并搜索
             engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
             vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
              uint32_t modify = 1059000000; // 修改成
             for(int i =0;i<results.size();i++){
             if(i>0){
             engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
            
                               }
                            }
                        });
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x100000000,0x200000000};
             float search = 0.1;//搜索
             engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
             float search1 = -1;//联合
             engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
             float search2 = -1;//联合
             engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
             float search3 = -1;// 取消联合并搜索
             engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
             vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
              float modify = 0.3; // 修改成
             for(int i =0;i<results.size();i++){
             if(i>0){
             engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                           }
                         }
                    });
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x100000000,0x200000000};
             float search = 0.1;//搜索
            engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            float search1 = 0.00999999978;//联合
            engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
             float search2 = 0.00999999978;//联合
             engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
             float search3 = 0.00999999978;// 取消联合并搜索
             engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
            vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
             float modify = 0.3; // 修改成
            for(int i =0;i<results.size();i++){
            if(i>0){
             engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                      }
                                   }
                               });
                         }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
         if ([调用 isEqualToString:@"开关WAAG人物穿墙"]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
               AddrRange range = (AddrRange){0x100000000,0x160000000};
               uint32_t search = 1034147594;
               engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
               uint32_t search1 = 1051931443;
               engine.JRNearBySearch(0x150,&search1, JR_Search_Type_UInt);
               uint32_t search2 = 1051931443;
               engine.JRNearBySearch(0x150,&search2, JR_Search_Type_UInt);
               uint32_t search3 = 1034147594;
               engine.JRScanMemory(range, &search3,JR_Search_Type_UInt);
               vector<void*>results = engine.getAllResults();
               uint32_t modify = 2139000000;
               for(int i =0;i<results.size();i++){
               if(i <=5500&&i>=0)
               engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                          }
                       });
                   }
        
        
         if ([调用 isEqualToString:@"开关WWG步枪穿墙"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
       uint32_t search = 1008981770;
        engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
        uint32_t search1 = 900762;
        engine.JRNearBySearch(0x200,&search1,JR_Search_Type_UInt);
        uint32_t search2 = 100;
        engine.JRNearBySearch(0x200,&search2,JR_Search_Type_UInt);
        uint32_t search3 = 4;
        engine.JRNearBySearch(0x200,&search3,JR_Search_Type_UInt);
        uint32_t search4 = 4;
        engine.JRNearBySearch(0x200,&search4,JR_Search_Type_UInt);
        vector<void*>results = engine.getAllResults();
        uint32_t modify = 2144061856;
        for(int i = 0;i<results.size();i++){
         if(i >0)engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                          }
                       });
                      }
        
        
        
        
        
        
         if ([调用 isEqualToString:@"开关WW瞬移"]) {
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x100000000,0x160000000};
                //uint32_t search = 8101253640064557426;
                uint64_t search = 4692750812785410048;
                engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
                vector<void*>results = engine.getAllResults();
                uint64_t modify = -477218586901872640;
                for(int i =0;i<results.size();i++){
                    if(i <=200&&i>=1)engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
                   }
                });
               }
        
        
        
        
        
        if ([调用 isEqualToString:@"开关QQ遁地"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
          AddrRange range = (AddrRange){0x100000000,0x500000000};    // 搜索范围
           float search = 0.85;//搜索
             engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
               float search1 = 90;//联合
                engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                  float search2 = 90;//联合
                  engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                  float search3 = 0.85;// 取消联合并搜索
                      engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                          float modify =5; // 修改成
                           for(int i =0;i<results.size();i++){
            if(i >0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
            }
         });
        }
        
        
        
        
         if ([调用 isEqualToString:@"滑条4LL飞天"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
       AddrRange range = (AddrRange){0x100000000,0x500000000};    // 搜索范围
       
       float search = 0.85;//搜索
       engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
       float search1 = 90;//联合
       engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
       float search2 = 90;//联合
       engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
       float search3 = 0.85;// 取消联合并搜索
       engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
       vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
       float modify = -15; // 修改成
       for(int i =0;i<results.size();i++){
           if(i <=1000&&i>=0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
            }
         });
        }
            
         if ([调用 isEqualToString:@"开关KK人物视角加高"]) {
              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                 AddrRange range = (AddrRange){0x00000000,0x500000000};    // 搜索范围
                 float search = 0.7;//搜索
                 engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                 float search1 = 10;//联合
                 engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                 float search2 = 10;//联合
                 engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                 float search3 = 10;// 取消联合并搜索
                 engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                 vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
                 float modify = -80; // 修改成
                 for(int i =0;i<results.size();i++){
                 if(i >0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                          }
                                                 });
                                             }
        
         if ([调用 isEqualToString:@"开关JJ屠龙刀速"]) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        float search = 0.4;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
        vector<void*>results = engine.getAllResults();
        float modify = 0.01;
        for(int i =0;i<results.size();i++){
        if(i>0)
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                         }
                      });
          }
                                                 
         if ([调用 isEqualToString:@"开关HH狙击穿牆"]) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        uint32_t search = -1082130432;
        engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
        uint32_t search1 = 1013276738;
        engine.JRNearBySearch(0x150,&search1, JR_Search_Type_UInt);
        uint32_t search2 = -1082130432;
        engine.JRNearBySearch(0x150,&search2, JR_Search_Type_UInt);
        uint32_t search3 = -1082130432;
        engine.JRScanMemory(range, &search3,JR_Search_Type_UInt);
        vector<void*>results = engine.getAllResults();
        uint32_t modify = 2139666666;
        for(int i =0;i<results.size();i++){
        if(i <=5500&&i>=0)
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                   }
                });
            }
         if ([调用 isEqualToString:@"开关GG隔墙透视"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x200000000};
            uint32_t search = 1043878380;
            engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
             uint32_t search1 = 1043878380;
            engine.JRScanMemory(range, &search1, JR_Search_Type_UInt);
              vector<void*>results = engine.getAllResults();
              uint32_t modify = 1075750000;
             for(int i =0;i<results.size();i++){
              if(i <=500&&i>=0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
                           }
                                            });
                                        }
         if ([调用 isEqualToString:@"开关FF范围射程加倍"]) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        uint32_t search = 1036831949;
        engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
        uint32_t search1 = 100;
        engine.JRNearBySearch(0x100,&search1, JR_Search_Type_UInt);
        uint32_t search2 = -1082130432;
        engine.JRNearBySearch(0x100,&search2, JR_Search_Type_UInt);
        uint32_t search3 = 100;
        engine.JRScanMemory(range, &search3,JR_Search_Type_UInt);
        vector<void*>results = engine.getAllResults();
        uint32_t modify = 2139000000;
        for(int i =0;i<results.size();i++){
        if(i <=80000&&i>=0)
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                               });
                              }
         if ([调用 isEqualToString:@"开关EE挑战无敌"]) {
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x160000000};
            float search = 0.2;
            engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            float search1 = 2;
            engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
            float search2 = 0.1;
            engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
            float search3 = 1;
            engine.JRNearBySearch(0x100,&search3,JR_Search_Type_Float); // 联合
            float search4 = 0.1;
            engine.JRScanMemory(range, &search4,JR_Search_Type_Float); // 取消联合并精确数值
            vector<void*>results = engine.getAllResults();
            float modify = 8555;
            for(int i =0;i<results.size();i++){
            if(i <=5000&&i>=0)
            engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                              }
                            });
                            }
       if ([调用 isEqualToString:@"开关DD锁头"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x00000000,0x500000000};    // 搜索范围
            float search = 0.1;//搜索
            engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            float search1 = -0.075;//联合
            engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
            float search2 = 0.01;//联合
            engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
            float search3 = 0.1;// 取消联合并搜索
            engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
            vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
            float modify = 0.4; // 修改成
            for(int i =0;i<results.size();i++){
            if(i >0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                              }
                                           });
                                           }
         if ([调用 isEqualToString:@"开关BB"]) {
               //内存代码
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
           AddrRange range = (AddrRange){0x100000000,0x200000000};
           float search = 7.1746481e-43;//搜索
           engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
           float search1 = 0.01;//联合
           engine.JRNearBySearch(0x200,&search1,JR_Search_Type_Float); // 联合
           float search2 = 2.5;//联合
           engine.JRNearBySearch(0x200,&search2,JR_Search_Type_Float); // 联合
           float search3 = 7.1746481e-43;// 取消联合并搜索
           engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
           vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
           float modify = 1.4160822e-39; // 修改成
           for(int i =0;i<results.size();i++){
           if(i >0)
           engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
           }
               });
                   //功能2
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
           AddrRange range = (AddrRange){0x100000000,0x200000000};
           float search = 1.4160822e-39;//搜索
           engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
           float search1 = 0.01;//联合
           engine.JRNearBySearch(0x200,&search1,JR_Search_Type_Float); // 联合
           float search2 = 2.5;//联合
           engine.JRNearBySearch(0x200,&search2,JR_Search_Type_Float); // 联合
           float search3 = 2.5;// 取消联合并搜索
           engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
           vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
           float modify = 1000; // 修改成
           for(int i =0;i<results.size();i++){
           if(i>0)
           engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
           }
          
               });
                  }
        
        
        
        
        
         if ([调用 isEqualToString:@"滑条DD后座"]) {
            //功能1战白金通用后座
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        float search = 0.26;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
        vector<void*>results = engine.getAllResults();
        float modify =[值 floatValue];//
        for(int i =0;i<results.size();i++){
        if(i <=1000&&i>=0)
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
            }
                });
           //功能2究极烈焰祥后坐
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
          AddrRange range = (AddrRange){0x100000000,0x160000000};
          float search = 0.43;
           engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            float search1 = 0.43;
            engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
            float search2 = 0.43;
            engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
            float search3 = 0.43;
          engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
           vector<void*>results = engine.getAllResults();
            float modify =[值 floatValue];//
            for(int i =0;i<results.size();i++){
              if(i <=100&&i>=0)
               engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                      }
                          });
                            //功能3虚空无后座
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
              AddrRange range = (AddrRange){0x100000000,0x160000000};    // 搜索范围
            float search = 0.4;
             engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
              vector<void*>results = engine.getAllResults();
              float modify =[值 floatValue];//
               for(int i =0;i<results.size();i++){
                if(i <=6650&&i>=0)engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float );
                        }
                         });
                          //功能4究恶魔龙无后座
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x100000000,0x160000000};
             float search = 0.38;
            engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
             vector<void*>results = engine.getAllResults();
              float modify =[值 floatValue];//
             for(int i =0;i<results.size();i++){
              if(i <=300&&i>=0)
              engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                   }
                });
              //功能5貂蝉后座
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x160000000};
            float search = 0.66;
            engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
            vector<void*>results = engine.getAllResults();
            float modify =[值 floatValue];//
            for(int i =0;i<results.size();i++){
             if(i <=300&&i>=0)
             engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                     }
                       });
                           //功能6炎龙后座
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x160000000};
            float search = 0.5;
            engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
            float search1 = -1;
            engine.JRNearBySearch(0x210,&search1,JR_Search_Type_Float); // 联合
            float search2 = -1;
            engine.JRScanMemory(range, &search2,JR_Search_Type_Float); // 取消联合并精确数值
            vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的-1
           float modify =[值 floatValue];//
            for(int i =0;i<results.size();i++){
             if(i <=5000&&i>=0)
             engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                      }
                  });
              }
        
        
        
          if ([调用 isEqualToString:@"滑条CC走速"]) {
                      //内存代码
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
             AddrRange range = (AddrRange){0x100000000,0x200000000};
             uint64_t search = 4602678820244291584;
             engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
             float search1 = 7;
             engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
             float search2 = 7;
             engine.JRScanMemory(range, &search2,JR_Search_Type_Float);
             vector<void*>results = engine.getAllResults();
             float modify = 7.8; // 修改成
             for(int i =0;i<results.size();i++){
             if(i>0)
             engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                   }
               });
           }
        

        //这里是传过来的值：调用开关BB 刚好是符合上面主菜单第二个调用功能:调用开关BB
        if ([调用 isEqualToString:@"功能范围5倍"]) {
           
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
         uint32_t search = 1008981770;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_UInt); // 搜索
         uint32_t search1 = 1036831949;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_UInt); // 联合
         uint32_t search2 = 1036831949;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_UInt); // 联合
         uint32_t search3 = 1008981770;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_UInt); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
         uint32_t modify = 1056964608; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_UInt);
       
                          }
                       }
                   });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.1;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = -1;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = -1;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = -1;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
         float modify = 0.5; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                      }
                    }
               });
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.1;//搜索
       engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
       float search1 = 0.00999999978;//联合
       engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 0.00999999978;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = 0.00999999978;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
       vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
        float modify = 0.5; // 修改成
       for(int i =0;i<results.size();i++){
       if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                 }
                              }
                          });
                    }
        //这里是传过来的值：调用开关BB 刚好是符合上面主菜单第二个调用功能:调用开关BB
        if ([调用 isEqualToString:@"滑条2射速"]) {
        //第一个功能“炎龙射速”
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.11;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = 0.5;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 0.11;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = 0.11;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
        float modify = 0.01; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                 }
                             }
                         });
                         //第2个功能“狂龙射速”
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 1.42;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = 1.4;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 1.15;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = 1.15;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
        float modify = 0.01; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                 }
                             }
                             
                         });
            //第三个“祥龙射速”烈焰射速‘白金祥龙射速
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.43;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = 0.01;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 0.096;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = 0.096;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
        float modify = 0.01; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                 }
                             }
                             
                         });
                //第三个“祥龙射速37”烈焰射速37‘白金祥龙37射速
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.43;//搜索
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
        float search1 = 0.01;//联合
        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
        float search2 = 0.097;//联合
        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
        float search3 = 0.097;// 取消联合并搜索
        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
        vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
        float modify = 0.01; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                           }
                          }
                        });
       
            //第4个功能“英雄之心38射速
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 0.88;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
        vector<void*>results = engine.getAllResults();
        float modify = 0.01; // 修改成
        for(int i =0;i<results.size();i++){
        if(i>0){
        engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                }
        }
    });
            //第5个功能“虚空射速
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
      AddrRange range = (AddrRange){0x100000000,0x200000000};
      float search = 0.1;//搜索
      engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
      float search1 = 1.2;//联合
      engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
      float search2 = 0.1;//联合
      engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
      float search3 = 0.1;// 取消联合并搜索
      engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
      vector<void*>results = engine.getAllResults(); //搜索到刚刚取消联合的
      float modify = 0.01; // 修改成
      for(int i =0;i<results.size();i++){
      if(i>0){
      engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
             }
                 }
                  });
                //第6个功能 甄姬射速
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
      AddrRange range = (AddrRange){0x100000000,0x200000000};
      float search = 0.71;
      engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
      vector<void*>results = engine.getAllResults();
      float modify = 0.01; // 修改成
      for(int i =0;i<results.size();i++){
      if(i>0){
      engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                       }
                                                   }
                                                   
                                               });
                         
                                          //第6个功能 战龙39射速
                                                                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                                    
                                                                                     JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                     AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                  float search = 0.0805;
                                                                                 engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                                                                                 vector<void*>results = engine.getAllResults();
                                                                                    float modify = 0.01; // 修改成
                                                                                     for(int i =0;i<results.size();i++){
                                                                                         if(i>0){
                                                                                             engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                                                         }
                                                                                     }
                                                                                     
                                                                                 });
                         
                                     //第7个功能 战龙37射速
                                                                                                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                         
                                                                                                                            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                                                            AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                                                         float search = 0.081;
                                                                                                                        engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                                                                                                                        vector<void*>results = engine.getAllResults();
                                                                                                                            float modify = 0.01; // 修改成
                                                                                                                            for(int i =0;i<results.size();i++){
                                                                                                                                if(i>0){
                                                                                                                                    engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                                                                                                }
                                                                                                                            }
                                                                                                                            
                                                                                                                        });
                                                                
                         //第7个功能 疾风39射速
                                                                                                                                                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                        
                                                                                                                                                      JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                                                                                      AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                                                                                   float search = 0.073;
                                                                                                                                                  engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                                                                                                                                                  vector<void*>results = engine.getAllResults();
                                                                                                                                                      float modify = 0.01; // 修改成
                                                                                                                                                      for(int i =0;i<results.size();i++){
                                                                                                                                                          if(i>0){
                                                                                                                                                              engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                                                                                                                          }
                                                                                                                                                      }
                                                                                                                                                      
                                                                                                                                                  });
                         
                         //第8个功能“魔龙39射速
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       
                                                 JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                 AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                      float search = 1.22;//搜索
                                                      engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                                                      float search1 = -1;//联合
                                                      engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                                                      float search2 = 0.8;//联合
                                                      engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                                                      float search3 = 0.8;// 取消联合并搜索
                                                      engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                                                      vector<void*>results = engine.getAllResults();

                                                 float modify = 0.01; // 修改成
                                                 for(int i =0;i<results.size();i++){
                                                     if(i>0){
                                                         engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                     }
                                                 }
                                                 
                                             });
                         
                          //第8个功能“魔龙射速
                                                                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                              
                                                                                                   JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                                   AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                                                                        float search = 1.22;//搜索
                                                                                                        engine.JRScanMemory(range, &search, JR_Search_Type_Float); // 搜索
                                                                                                        float search1 = -1;//联合
                                                                                                        engine.JRNearBySearch(0x100,&search1,JR_Search_Type_Float); // 联合
                                                                                                        float search2 = 0.084;//联合
                                                                                                        engine.JRNearBySearch(0x100,&search2,JR_Search_Type_Float); // 联合
                                                                                                        float search3 = 0.084;// 取消联合并搜索
                                                                                                        engine.JRScanMemory(range, &search3,JR_Search_Type_Float); // 取消联合并精确数值
                                                                                                        vector<void*>results = engine.getAllResults();

                                                                                                   float modify = 0.01; // 修改成
                                                                                                   for(int i =0;i<results.size();i++){
                                                                                                       if(i>0){
                                                                                                           engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                                                                       }
                                                                                                   }
                                                                                                   
                                                                                               });
                                                                           
                               //第9个功能 邪龙射速
                                                                                                                                                                                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                
                                                                                                                                                                                                   JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                                                                                                                                   AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                                                                                                                                float search = 0.085;
                                                                                                                                                                                               engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                                                                                                                                                                                               vector<void*>results = engine.getAllResults();
                                                                                                                                                                                                   float modify = 0.01; // 修改成
                                                                                                                                                                                                   for(int i =0;i<results.size();i++){
                                                                                                                                                                                                       if(i>0){
                                                                                                                                                                                                           engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                                                                                                                                                                                       }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   
                                                                                                                                                                                               });
                         
                                //第10个功能 貂蝉37
                                                                                                                                                                                                                                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                    
                                                                                                                                                                                                                                               JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                                                                                                                                                                                                                                               AddrRange range = (AddrRange){0x100000000,0x200000000};
                                                                                                                                                                                                            float search = 0.094;
                                                                                                                                                                                                                                           engine.JRScanMemory(range, &search, JR_Search_Type_Float ); // 搜索
                                                                                                                                                                                                                                           vector<void*>results = engine.getAllResults();
                                                                                                                                                                                                                                               float modify = 0.01; // 修改成
                                                                                                                                                                                                                                               for(int i =0;i<results.size();i++){
                                                                                                                                                                                                                                                   if(i>0){
                                                                                                                                                                                                                                                       engine.JRWriteMemory((unsigned long long )(results[i]),&modify,JR_Search_Type_Float);
                                      }
                                   }
                               });
                         }
       
        
        

              }
    @end
