//
//  NSObject+UI.m
//  iOsGods.Cn
//
//  Created by  十三哥 on 2022/1/1.
#import "DLGMemUIView.h"
#import "NSObject+Plist.h"
#import "NSObject+Menu.h"
#import "WMDragView.h"
#import "NSObject+UI.h"
#import "HeeeNoScreenShotView.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define 悬浮图标地址 @"http://144.48.241.28/ZQQ.jpg"
//图开关标 默认 当菜单里面是nil 空 时候调用
#define 统一开关开启图标地址 @"http://144.48.241.28/E7D1DC.png"
#define 统一开关关闭图标地址 @"http://144.48.241.28/E7D1DC.png"
//开关按钮图片的大小 默认0.8最佳 超过就大于开关
#define 开关按钮图片的大小 1
//子菜单开关大小 0.8 最佳
#define 子菜单开关大小 1
#define 子菜单开启颜色
#define DLG排序 17
static UIWindow *根视图;
static UIView *添加主菜单视图;
static UIScrollView *滑动视图;
static WMDragView *图标拖动视图;
static HeeeNoScreenShotView *隐藏视图;

static UILabel *添加文字视图[100];
static UILabel *小提示视图[100];
static UILabel *滑条值提示[100];
static UIImageView *背景图[103];
static UIImageView *图标视图[103];
static UIView *滚动列表视图;
static UIImage*缩放[106];
static UISwitch *添加开关视图[100];
static UILabel *开关状态提示[100];
static BOOL 开关排序[100];
static NSString* 开关传值[101];
static NSString* 文字传值[101];
static UISlider *添加滑条视图[100];
static NSString* 滑条值[100];
static NSString* 滑条小标题[100];
static int 滑条归属[100];

float 小标题不为空像素差[100];

static NSString* 路径;

//=============
static BOOL 判断子菜单打开状态;
static int 展开的子菜单归属;
static UIView *extraInfo;
@implementation NSObject (UI)
#pragma mark - 主视图
+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"点击 懒加载");
            [NSObject 启用统一图标];
            
        });
    });
}
-(void)启用统一图标
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURL *urlImage = [NSURL URLWithString:统一开关开启图标地址];   //  统一图标地址
        NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
        UIImage *image = [UIImage imageWithData:dataImage];
        CGFloat width = CGImageGetWidth(image.CGImage);
        CGFloat height = CGImageGetHeight(image.CGImage);
        缩放[105] = [NSObject 原图片:image 新图片:CGSizeMake(width, height) 排序:105];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         NSURL *urlImage = [NSURL URLWithString:统一开关关闭图标地址];   //  统一图标地址
           NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
           UIImage *image = [UIImage imageWithData:dataImage];
           CGFloat width = CGImageGetWidth(image.CGImage);
           CGFloat height = CGImageGetHeight(image.CGImage);
           缩放[104] = [NSObject 原图片:image 新图片:CGSizeMake(width, height) 排序:104];
    });
}
-(void)显示图标
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //图标
         NSURL *urlImage = [NSURL URLWithString:悬浮图标地址];
         NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
         UIImage *image = [UIImage imageWithData:dataImage];
         图标视图[102]= [[UIImageView alloc] initWithImage:image];
         图标视图[102].backgroundColor =[UIColor clearColor];
         图标视图[102].frame = CGRectMake(0, 0, 50, 50);
         图标视图[102].image = image;
         图标视图[102].alpha=1;
         图标视图[102].layer.cornerRadius = 25;//圆角 等于图片宽度的二分之一刚好圆形
         图标视图[102].layer.masksToBounds = YES;
         
         图标拖动视图=[[WMDragView alloc]initWithFrame:CGRectMake(100,100 ,50 , 50)];
         图标拖动视图.backgroundColor =[UIColor colorWithRed:1 green:0 blue:0 alpha:0];
         图标拖动视图.layer.cornerRadius = 25;
         图标拖动视图.userInteractionEnabled=YES;
         
         HeeeNoScreenShotView *隐藏图标视图=[[HeeeNoScreenShotView alloc] init];
         隐藏图标视图.layer.cornerRadius = 15;
         隐藏图标视图.backgroundColor =[UIColor clearColor];
         隐藏图标视图.userInteractionEnabled=YES;
        
        
         [隐藏图标视图 addSubview:图标视图[102]];
         [图标拖动视图 addSubview:隐藏图标视图];
         UIView *gg= [[[UIApplication sharedApplication] delegate] window];
         gg.backgroundColor =[UIColor clearColor];
         [gg addSubview:图标拖动视图];
    });
}

-(void)隐藏图标
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [图标拖动视图 removeFromSuperview];
    });
}

- (void)主视图
{
    int 宽度,高度,字体大小,方位,功能数;
    NSString *标题;
    NSString *标题颜色;
    NSString *标题背景色;
    NSString *背景颜色;
    NSString *背景图片;
    float 背景图透明度;
    路径 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"菜单.plist"];
    //读取主菜单
    NSDictionary *读取全部= [[[NSMutableDictionary alloc] initWithContentsOfFile:路径] mutableCopy];
    //获取菜单样式
    NSDictionary *读取 = [读取全部 objectForKey:@"菜单样式"];
    宽度 = [[读取 objectForKey:@"宽度"] intValue];
    高度 = [[读取 objectForKey:@"高度"] intValue];
    字体大小 = [[读取 objectForKey:@"字体大小"] intValue];
    方位 = [[读取 objectForKey:@"方位"] intValue];
    功能数 = [[读取 objectForKey:@"功能数"] intValue];
    标题=[读取 objectForKey:@"标题"];
    标题颜色=[读取 objectForKey:@"标题颜色"];
    标题背景色=[读取 objectForKey:@"标题背景色"];
    背景颜色=[读取 objectForKey:@"背景颜色"];
    背景图片=[读取 objectForKey:@"背景图片"];
    背景图透明度=[[读取 objectForKey:@"背景图透明度"] floatValue];
    //开始绘制
    if (字体大小>20) {
        字体大小=20;
    }
    NSLog(@"点击 主视图");
    //添加添加主菜单视图===========================================================
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        添加主菜单视图 = [[WMDragView alloc]initWithFrame:CGRectMake(kWidth/2-宽度/2, kHeight/2-高度/2 ,宽度 , 高度)];
        NSArray *背景色 = [背景颜色 componentsSeparatedByString:@","];
        // 添加主菜单视图.backgroundColor = [UIColor colorWithRed:[背景色[0] floatValue] green:[背景色[1] floatValue] blue:[背景色[2] floatValue] alpha:[背景色[3] floatValue]];
        //添加主菜单视图.backgroundColor = [UIColor colorWithRed:[背景色[0] floatValue] green:[背景色[0] floatValue] blue:[背景色[0] floatValue] alpha:[背景色[0] floatValue]];
        float 红 = arc4random() % 255;
        float 蓝 = arc4random() % 255;
        float 绿 = arc4random() % 255;
        添加主菜单视图.backgroundColor = [UIColor colorWithRed:红 / 255.0 green:蓝 / 255.0 blue:绿 / 255.0 alpha:0.3]; //  随机 下面 背景变色//字体颜色greenColor绿色whiteColor白色 其他颜色百度
        
        
        [添加主菜单视图.layer setCornerRadius:20];
        添加主菜单视图.layer.masksToBounds = YES;
        添加主菜单视图.layer.borderWidth = 0.08;
        [添加主菜单视图.layer setBorderColor:[UIColor clearColor].CGColor];//边框细线颜色
        [UIView animateWithDuration:1 animations:^{
            添加主菜单视图.transform = CGAffineTransformMakeScale(1, 1);
        }];   // 这里改最底部细框
        //背景图
        NSLog(@"当前开关==背景图=%@",背景图片);
        if (背景图片.length>10) {
            NSURL *urlImage = [NSURL URLWithString:背景图片];
            NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
            UIImage *image = [UIImage imageWithData:dataImage];
            缩放[100] = [NSObject 原图片:image 新图片:CGSizeMake(宽度, 高度) 排序:100];
            背景图[100]= [[UIImageView alloc] initWithFrame:CGRectMake(0,0 ,宽度 , 高度)];
            背景图[100].image = 缩放[100];
            背景图[100].alpha=背景图透明度;
            [添加主菜单视图 addSubview:背景图[100]];
        }
    });
    //磨砂
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]; // 磨砂效果，枚举中还提供另外几种效果，可供尝试
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, 添加主菜单视图.frame.size.width, 添加主菜单视图.frame.size.height); // 设置虚化背景尺寸，整个视图可以直接 bounds
        [添加主菜单视图 addSubview:effectview];
    });
    //标题背景-=======================================================
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         UILabel *labelbeijing = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 添加主菜单视图.frame.size.width, 30)];
        NSArray *标题背景 = [标题背景色 componentsSeparatedByString:@","];
        labelbeijing.backgroundColor=[UIColor colorWithRed:[标题背景[0] floatValue] green:[标题背景[1] floatValue] blue:[标题背景[2] floatValue] alpha:[标题背景[3] floatValue]];
        [添加主菜单视图 addSubview:labelbeijing];
                 
    });
    //标题-==================================================================
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, -5, 添加主菜单视图.frame.size.width, 40)];
        label.backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"Verdana-Bold" size:字体大小];
        label.font=font;
        NSArray *标题色 = [标题颜色 componentsSeparatedByString:@","];
        label.textColor=[UIColor colorWithRed:[标题色[0] floatValue] green:[标题色[1] floatValue] blue:[标题色[2] floatValue] alpha:[标题色[3] floatValue]];
        label.text = 标题;
        label.numberOfLines = 0;
        if (方位==0) {
            label.textAlignment = NSTextAlignmentLeft;
        }else if(方位==1){
            label.textAlignment = NSTextAlignmentCenter;
        }else if(方位==2){
            label.textAlignment = NSTextAlignmentRight;
        }
        [添加主菜单视图 addSubview:label];
    });
    //点击按钮
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UILabel *按钮点击 = [[UILabel alloc]initWithFrame:CGRectMake(0, 添加主菜单视图.frame.size.height-30, 滑动视图.frame.size.width, 15)];
        按钮点击.backgroundColor=[UIColor clearColor]; //字体背景色
        UIFont*font22=[UIFont fontWithName:@"Verdana-Bold" size:10];//字体大小
        按钮点击.font=font22;
        按钮点击.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];//文字色
        按钮点击.text = @"点击我🦄️进入聊天室";
        按钮点击.numberOfLines = 0;
        按钮点击.textAlignment = NSTextAlignmentCenter;
        //添加点击事件
        按钮点击.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(点击:)];
        [按钮点击 addGestureRecognizer:labelTapGestureRecognizer];
        [添加主菜单视图 addSubview:按钮点击];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         UILabel *关闭按钮背景 = [[UILabel alloc]initWithFrame:CGRectMake(0,  添加主菜单视图.frame.size.width-20, 添加主菜单视图.frame.size.width, 40)];
         //关闭按钮背景.backgroundColor=[UIColor colorWithRed:231 green:170 blue:52 alpha:0.1];//背景色
         //到期时间
        UILabel *到期时间 = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 滑动视图.frame.size.width, 15)];
        到期时间.backgroundColor=[UIColor clearColor];
        UIFont*font22=[UIFont fontWithName:@"Verdana-Bold" size:10];
        到期时间.font=font22;
        到期时间.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];//文字色
        UIDevice *device =[[UIDevice alloc] init];//获取设备信息
        到期时间.text = [NSString stringWithFormat:@"当前设备已开启菜单过录屏:%@",device.name];
        到期时间.numberOfLines = 0;
        到期时间.textAlignment = NSTextAlignmentCenter;
        [关闭按钮背景 addSubview:到期时间];
        [添加主菜单视图 addSubview:关闭按钮背景];
        
    });
        
    //显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        隐藏视图=[[HeeeNoScreenShotView alloc] initWithFrame:CGRectMake(0,0,kWidth,kHeight)];
        [隐藏视图 addSubview:添加主菜单视图];
        根视图 = [[[UIApplication sharedApplication] delegate] window];
        [根视图 addSubview:隐藏视图];
    });
    //绘制
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self 绘制];
    });
}

-(void)点击:(UITapGestureRecognizer *)recognizer{
      
   UILabel *label=(UILabel*)recognizer.view;
   NSLog(@"%@被点击了",label.text);
    NSString *urlStr = [NSString stringWithFormat:@"http://zuiqing.top"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
   
}

// 主菜单》》绘制
#pragma mark - 读取数据 判断类型绘制
-(void)绘制
{
    
    路径 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"菜单.plist"];
    //读取全部
    NSDictionary *读取全部= [[[NSMutableDictionary alloc] initWithContentsOfFile:路径] mutableCopy];
    //开始绘制
    
    if (判断子菜单打开状态 ==NO) {
        //绘制主菜单 开关没打开 NO
        NSDictionary *读取 = [读取全部 objectForKey:@"菜单样式"];
        //循环绘制
        int 功能数;
        功能数 = [[读取 objectForKey:@"功能数"] intValue];
        //读取主菜单
        NSDictionary *读取主菜单 = [读取全部 objectForKey:@"主菜单"];
        //添加上下滑动视图===========================================================
        滑动视图 = [[UIScrollView alloc] initWithFrame:CGRectMake(10,24 ,添加主菜单视图.frame.size.width-20 , 添加主菜单视图.frame.size.height-54)];
        滑动视图.showsVerticalScrollIndicator = FALSE;
        滑动视图.contentSize = CGSizeMake(添加主菜单视图.frame.size.width-40, 40*功能数+80);
        滑动视图.bounces = YES;
        滑动视图.userInteractionEnabled=YES;
        滑动视图.backgroundColor = [UIColor clearColor];  //    滑动 背景颜色
        //滑动视图.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        //   float 红 = arc4random() % 255;
        //   float 蓝 = arc4random() % 255;
        //   float 绿 = arc4random() % 255;
        //   滑动视图.backgroundColor = [UIColor colorWithRed:红 / 255.0 green:蓝 / 255.0 blue:绿 / 255.0 alpha:0.3]; //  随机 下面 背景变色
        //字体颜色greenColor绿色whiteColor白色 其他颜色百度
        for (int i=0; i<功能数+1; i++) {
            //表格
            滚动列表视图=[[UIView alloc] initWithFrame:CGRectMake(0, 40*i, 滑动视图.frame.size.width, 2)];
            滚动列表视图.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
            [滚动列表视图.layer setCornerRadius:2];
            [滑动视图 addSubview:滚动列表视图];
            //按功能数读取数组
            NSDictionary *功能数组 = [读取主菜单 objectForKey:[NSString stringWithFormat:@"%d",i]];
            //读取菜单 类型 是否是主菜单
            int 菜单类型 = [[功能数组 objectForKey:@"菜单类型"] intValue];
            //判断 菜单类型 是不是0 既主菜单 ==0 就绘制
            if (菜单类型==0) {
                //读取添加类型
                NSString * 添加类型=[功能数组 objectForKey:@"添加类型"];
                if ([添加类型 containsString:@"添加文字"]) {
                    //判断是添加文字就 解析
                    NSString * 小标题;
                    NSString * 小标题颜色;
                    NSString * 标题;
                    NSString * 标题颜色;
                    NSString * 调用;
                    int 字体大小,归属,排序,方位;
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    小标题颜色 =[功能数组 objectForKey:@"小标题颜色"];
                    标题颜色 =[功能数组 objectForKey:@"标题颜色"];
                    标题 =[功能数组 objectForKey:@"标题"];
                    字体大小=[[功能数组 objectForKey:@"字体大小"] intValue];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    方位=[[功能数组 objectForKey:@"方位"] intValue];
                    调用=[功能数组 objectForKey:@"调用"];
                    //绘制
                    [NSObject 绘制文字:排序 标题:标题 字体大小:字体大小 标题颜色:标题颜色 方位:方位 小标题:小标题 小标题颜色:小标题颜色 归属:归属 调用:调用];
                }
                if ([添加类型 containsString:@"添加开关"]) {
                    //判断是添加开关就 读取开关
                    NSString *字体颜色;
                    NSString *小标题;
                    NSString *小标题颜色;
                    NSString *标题;
                    NSString *开启图标地址;
                    NSString *关闭图标地址;
                    NSString *调用;
                    int 字体大小,归属,排序,方位;
                    开启图标地址 =[功能数组 objectForKey:@"开启图标地址"];
                    关闭图标地址 =[功能数组 objectForKey:@"关闭图标地址"];
                    字体颜色 =[功能数组 objectForKey:@"字体颜色"];
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    小标题颜色 =[功能数组 objectForKey:@"小标题颜色"];
                    标题 =[功能数组 objectForKey:@"标题"];
                    字体大小=[[功能数组 objectForKey:@"字体大小"] intValue];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    方位=[[功能数组 objectForKey:@"方位"] intValue];
                    调用=[功能数组 objectForKey:@"调用"];
                    //绘制
                    [NSObject 绘制开关:排序 标题:标题 字体大小:字体大小 方位:方位 字体颜色:字体颜色 小标题:小标题 小标题颜色:小标题颜色 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址 归属:归属 调用:调用];
                }
                if ([添加类型 containsString:@"添加滑条"]) {
                    //判断是添加滑条就 调用绘制滑条
                    NSString * 小标题;
                    NSString * 滑块色;
                    NSString * 调用;
                    NSString * 最大;
                    NSString * 最小;
                    NSString * 初始;
                    int 归属,排序;
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    滑块色 =[功能数组 objectForKey:@"滑块色"];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    最大=[功能数组 objectForKey:@"最大"];
                    最小=[功能数组 objectForKey:@"最小"];
                    初始=[功能数组 objectForKey:@"初始"];
                    
                    调用=[功能数组 objectForKey:@"调用"];
                    [NSObject 绘制滑条:排序 小标题:小标题 最大:最大 最小:最小 初始:初始 滑块色:滑块色 归属:归属 调用:调用];
                    
                }
                
            }
        }
        
    } else if (判断子菜单打开状态 ==YES){
        //绘制子菜单 开关打开 YES
        //循环绘制
        int 菜单类型,主菜单功能数,打开的归属;
        NSString *添加类型;
        //读取主菜单
        NSDictionary *读取子菜单 = [读取全部 objectForKey:@"子菜单"];
        int 功能数量 = 0;
        for (int i=0; i<50; i++) {
            //按功能数读取数组
            NSDictionary *功能数组 = [读取子菜单 objectForKey:[NSString stringWithFormat:@"%d",i]];
            //读取菜单 类型 是否是主菜单
            菜单类型 = [[功能数组 objectForKey:@"菜单类型"] intValue];
            //判断 菜单类型 是不是0 既主菜单 ==0 就绘制
            if (菜单类型==1) {
                //读取添加类型
                添加类型=[功能数组 objectForKey:@"添加类型"];
                int 归属=[[功能数组 objectForKey:@"归属"] intValue];
                if (([添加类型 containsString:@"添加文字"] || [添加类型 containsString:@"添加开关"] || [添加类型 containsString:@"添加滑条"])&& 归属==展开的子菜单归属) {
                    功能数量++;
                }
            }
            if (i==49) {
                
                //添加上下滑动视图===========================================================
                滑动视图 = [[UIScrollView alloc] initWithFrame:CGRectMake(10,40 ,添加主菜单视图.frame.size.width-20 , 添加主菜单视图.frame.size.height-30)];
                滑动视图.showsVerticalScrollIndicator = FALSE;
                滑动视图.contentSize = CGSizeMake(添加主菜单视图.frame.size.width-40, 40*功能数量+80);
                滑动视图.bounces = YES;
                滑动视图.userInteractionEnabled=YES;
                滑动视图.backgroundColor = [UIColor clearColor];
                //表格
                for (int i=0; i<功能数量+2; i++) {
                    滚动列表视图=[[UIView alloc] initWithFrame:CGRectMake(0, 40*i, 滑动视图.frame.size.width, 2)];
                    滚动列表视图.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
                    [滚动列表视图.layer setCornerRadius:2];
                    [滑动视图 addSubview:滚动列表视图];
                    [添加主菜单视图 addSubview:滑动视图];
                }
            }
            
        }
        int 重新排序=0;
        for (int i=0; i<50; i++) {
            //按功能数读取数组
            NSDictionary *功能数组 = [读取子菜单 objectForKey:[NSString stringWithFormat:@"%d",i]];
            //读取菜单 类型 是否是主菜单
            菜单类型 = [[功能数组 objectForKey:@"菜单类型"] intValue];
            //判断 菜单类型 是不是0 既主菜单 ==0 就绘制
            if (菜单类型==1) {
                //读取添加类型
                添加类型=[功能数组 objectForKey:@"添加类型"];
                if ([添加类型 containsString:@"添加文字"]) {
                    //判断是添加文字就 解析
                    NSString * 小标题;
                    NSString * 小标题颜色;
                    NSString * 标题;
                    NSString * 标题颜色;
                    NSString * 调用;
                    int 字体大小,归属,排序,方位;
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    小标题颜色 =[功能数组 objectForKey:@"小标题颜色"];
                    标题颜色 =[功能数组 objectForKey:@"标题颜色"];
                    标题 =[功能数组 objectForKey:@"标题"];
                    调用 =[功能数组 objectForKey:@"调用"];
                    字体大小=[[功能数组 objectForKey:@"字体大小"] intValue];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    方位=[[功能数组 objectForKey:@"方位"] intValue];
                    //绘制
                    if (归属==展开的子菜单归属) {
                        重新排序++;
                        [NSObject 绘制文字:重新排序 标题:标题 字体大小:字体大小 标题颜色:标题颜色 方位:方位 小标题:小标题 小标题颜色:小标题颜色 归属:归属 调用:调用];
                    }
                }
                if ([添加类型 containsString:@"添加开关"]) {
                    //判断是添加开关就 读取开关
                    NSString *字体颜色;
                    NSString *小标题;
                    NSString *小标题颜色;
                    NSString *标题;
                    NSString *开启图标地址;
                    NSString *关闭图标地址;
                    NSString *调用;
                    int 字体大小,归属,排序,方位;
                    字体颜色 =[功能数组 objectForKey:@"字体颜色"];
                    开启图标地址 =[功能数组 objectForKey:@"开启图标地址"];
                    关闭图标地址 =[功能数组 objectForKey:@"关闭图标地址"];
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    小标题颜色 =[功能数组 objectForKey:@"小标题颜色"];
                    标题 =[功能数组 objectForKey:@"标题"];
                    字体大小=[[功能数组 objectForKey:@"字体大小"] intValue];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    方位=[[功能数组 objectForKey:@"方位"] intValue];
                    调用=[功能数组 objectForKey:@"调用"];
                    //绘制
                    if (归属==展开的子菜单归属) {
                        重新排序++;
                        [NSObject 绘制开关:重新排序 标题:标题 字体大小:字体大小 方位:方位 字体颜色:字体颜色 小标题:小标题 小标题颜色:小标题颜色 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址 归属:归属 调用:调用];
                    }
                    
                }
                if ([添加类型 containsString:@"添加滑条"]) {
                    //判断是添加滑条就 调用绘制滑条
                    NSString * 小标题;
                    NSString * 滑块色;
                  
                    NSString * 初始;
                    NSString * 最大;
                    NSString * 最小;
                    NSString * 调用;
                    int 归属,排序;
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    滑块色 =[功能数组 objectForKey:@"滑块色"];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    最大=[功能数组 objectForKey:@"最大"];
                    最小=[功能数组 objectForKey:@"最小"];
                    初始=[功能数组 objectForKey:@"初始"];
                    
                    调用 =[功能数组 objectForKey:@"调用"];
                    if (归属==展开的子菜单归属) {
                        重新排序++;
                        [NSObject 绘制滑条:重新排序 小标题:小标题 最大:最大 最小:最小 初始:初始 滑块色:滑块色 归属:归属 调用:调用];
                    }
                    
                    
                }
            }
            
        }
        
        //读取子菜单开关
        NSDictionary *读取 = [读取全部 objectForKey:@"菜单样式"];
        主菜单功能数 = [[读取 objectForKey:@"功能数"] intValue];
        NSDictionary *读取主菜单 = [读取全部 objectForKey:@"主菜单"];
        for (int i=0; i<主菜单功能数; i++) {
            NSDictionary *功能数组 = [读取主菜单 objectForKey:[NSString stringWithFormat:@"%d",i]];
            //读取菜单 类型 是否是主菜单
            菜单类型 = [[功能数组 objectForKey:@"菜单类型"] intValue];
            if (菜单类型==0) {
                打开的归属 = [[功能数组 objectForKey:@"归属"] intValue];
                if (打开的归属==展开的子菜单归属) {
                    NSString *字体颜色;
                    NSString *小标题;
                    NSString *小标题颜色;
                    NSString *标题;
                    NSString *开启图标地址;
                    NSString *关闭图标地址;
                    NSString *调用;
                    int 字体大小,归属,排序,方位;
                    开启图标地址 =[功能数组 objectForKey:@"开启图标地址"];
                    关闭图标地址 =[功能数组 objectForKey:@"关闭图标地址"];
                    字体颜色 =[功能数组 objectForKey:@"字体颜色"];
                    小标题 =[功能数组 objectForKey:@"小标题"];
                    小标题颜色 =[功能数组 objectForKey:@"小标题颜色"];
                    标题 =[功能数组 objectForKey:@"标题"];
                    字体大小=[[功能数组 objectForKey:@"字体大小"] intValue];
                    归属=[[功能数组 objectForKey:@"归属"] intValue];
                    排序=[[功能数组 objectForKey:@"排序"] intValue];
                    方位=[[功能数组 objectForKey:@"方位"] intValue];
                    调用 =[功能数组 objectForKey:@"调用"];
                    //绘制
                    if (字体大小>15) {
                        字体大小=15;
                    }
                    CGRect rect=CGRectMake(滑动视图.frame.size.width-50, 5, 0, 0);
                    添加开关视图[99] =[[UISwitch alloc] initWithFrame:rect];
                    if (开关排序[排序]==YES){
                        [添加开关视图[99] setOn:YES animated:YES];
                        [NSObject 开关状态提示:0 状态:YES 归属:归属];
                    } else {
                        [添加开关视图[99] setOn:NO animated:YES];
                        [NSObject 开关状态提示:0 状态:NO 归属:归属];
                    }
                    添加开关视图[99].tag=排序; //这里是你要传递的参数值
                    添加开关视图[99].userInteractionEnabled=YES;
                    添加开关视图[99].layer.cornerRadius=16;//按钮背景圆角 越大越圆角 0是正方形 15 圆形匹配最佳
                    添加开关视图[99].transform = CGAffineTransformMakeScale(子菜单开关大小, 子菜单开关大小);//子菜单整体缩放
                    添加开关视图[99].backgroundColor = [UIColor colorWithRed:1 green:0 blue:6 alpha:0.5];//子菜单按钮背景色
                    [添加开关视图[99] setOnTintColor:[UIColor colorWithRed:1 green:0 blue:6 alpha:0.5]];//子菜单开启状态颜色
                    [添加开关视图[99] setTintColor:[UIColor colorWithRed:0 green:1 blue:1 alpha:0.7]];//子菜单关闭状态颜色
                    [添加开关视图[99] addTarget:self action:@selector(开关:) forControlEvents:UIControlEventValueChanged];
                    开关传值[99]=[NSString stringWithFormat:@"%d,%d,%@,%@,%@",排序,归属,开启图标地址,关闭图标地址,调用];
                    
                    [滑动视图 addSubview:添加开关视图[99]];
                    //大标题-===========
                    if (小标题 !=nil) {
                        小标题不为空像素差[排序]=0;
                        [NSObject 绘制小提示:99 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
                    }else{
                        小标题不为空像素差[排序]=5;
                        [NSObject 绘制小提示:99 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
                    }
                    UILabel*label;
                    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 滑动视图.frame.size.width-52, 40)];
                    label.backgroundColor=[UIColor clearColor];
                    UIFont*font=[UIFont fontWithName:@"AlNile-Bold" size:字体大小];
                    label.font=font;
                    NSArray *文字色 = [字体颜色 componentsSeparatedByString:@","];
                    label.textColor=[UIColor colorWithRed:[文字色[0] floatValue] green:[文字色[1] floatValue] blue:[文字色[2] floatValue] alpha:[文字色[3] floatValue]];
                    label.text = 标题;
                    label.numberOfLines = 0;
                    if (方位==0) {
                        label.textAlignment = NSTextAlignmentLeft;
                    }else if(方位==1){
                        label.textAlignment = NSTextAlignmentCenter;
                    }else if(方位==2){
                        label.textAlignment = NSTextAlignmentRight;
                    }
                    [滑动视图 addSubview:label];
                     [NSObject 图标:99 状态:开关排序[排序] 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
                    if (开关排序[排序]==YES){
                        [NSObject 开关状态提示:99 状态:YES 归属:归属];
                    } else {
                       [NSObject 开关状态提示:99 状态:NO 归属:归属];
                    }
                    
                    
                }
                
            }
        }
        
        
    }
    [添加主菜单视图 addSubview:滑动视图];
    
}

#pragma mark - 各种UI 视图 方法
- (void)绘制文字:(int)排序 标题:(NSString*)标题 字体大小:(int)字体大小 标题颜色:(NSString*)标题颜色 方位:(int)方位 小标题:(NSString*__nullable)小标题 小标题颜色:(NSString* _Nullable)小标题颜色 归属:(int)归属 调用:(NSString* _Nullable)调用
{
    //标题-===========
    if (字体大小>15) {
        字体大小=15;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (标题!=nil) {
            
            if (小标题 !=nil) {
                [NSObject 绘制小提示:排序 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
                添加文字视图[排序] = [[UILabel alloc]initWithFrame:CGRectMake(0, (排序)*40-5, 滑动视图.frame.size.width, 40)];
            }else{
                添加文字视图[排序] = [[UILabel alloc]initWithFrame:CGRectMake(0, (排序)*40, 滑动视图.frame.size.width, 40)];
            }
        }
        添加文字视图[排序].backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"Verdana-Bold" size:字体大小];
        添加文字视图[排序].font=font;
        NSArray *文字色 = [标题颜色 componentsSeparatedByString:@","];
        添加文字视图[排序].textColor=[UIColor colorWithRed:[文字色[0] floatValue] green:[文字色[1] floatValue] blue:[文字色[2] floatValue] alpha:[文字色[3] floatValue]];
        添加文字视图[排序].text = 标题;
        添加文字视图[排序].numberOfLines = 0;
        添加文字视图[排序].tag=排序;
        [[NSUserDefaults standardUserDefaults] setObject:调用 forKey:@"按钮点击"];
        添加文字视图[排序].userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(按钮调用:)];
        [添加文字视图[排序] addGestureRecognizer:labelTapGestureRecognizer];
        if (方位==0) {
            添加文字视图[排序].textAlignment = NSTextAlignmentLeft;
        }else if(方位==1){
            添加文字视图[排序].textAlignment = NSTextAlignmentCenter;
        }else if(方位==2){
            添加文字视图[排序].textAlignment = NSTextAlignmentRight;
        }
        [滑动视图 addSubview:添加文字视图[排序]];
        if (小标题 !=nil) {
            [NSObject 绘制小提示:排序 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
        }
    });
}
- (void)绘制开关:(int)排序 标题:(NSString*)标题 字体大小:(int)字体大小 方位:(int)方位 字体颜色:(NSString*)字体颜色 小标题:(NSString*_Nullable)小标题 小标题颜色:(NSString* _Nullable)小标题颜色 开启图标地址:(NSString*_Nullable)开启图标地址 关闭图标地址:(NSString*_Nullable)关闭图标地址 归属:(int)归属 调用:(NSString*_Nullable)调用
{
    NSString *获取开关状态 = [[NSUserDefaults standardUserDefaults] objectForKey:标题];
    
    if (字体大小>15) {
        字体大小=15;
    }
    if (![关闭图标地址 containsString:@"http"]) {
        开启图标地址=@"";
    }
    if (![开启图标地址 containsString:@"http"]) {
        开启图标地址=@"";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        开关传值[排序]=[NSString stringWithFormat:@"%d,%d,%@,%@,%@,%@",排序,归属,开启图标地址,关闭图标地址,调用,标题];
        CGRect rect=CGRectMake(滑动视图.frame.size.width-52, (排序)*40+5, 0, 0);
        添加开关视图[排序] =[[UISwitch alloc] initWithFrame:rect];
        if ([获取开关状态 containsString:@"YES"]){
            [添加开关视图[排序] setOn:YES animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 开关状态提示:排序 状态:YES 归属:归属];
                [NSObject 图标:排序 状态:YES 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
            
        } else {
            [添加开关视图[排序] setOn:NO animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 开关状态提示:排序 状态:NO 归属:归属];
                [NSObject 图标:排序 状态:NO 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
        }
        添加开关视图[排序].tag=排序; //这里是你要传递的参数值
        添加开关视图[排序].userInteractionEnabled=YES;
        添加开关视图[排序].layer.cornerRadius=16;//按钮背景圆角 越大越圆角 0是正方形 15 圆形匹配最佳
        添加开关视图[排序].transform = CGAffineTransformMakeScale(1, 1);//整体缩放
        
     //   float 红 = arc4random() % 255;
      //   float 蓝 = arc4random() % 255;
      //   float 绿 = arc4random() % 235;
     //   添加开关视图[排序].backgroundColor = [UIColor colorWithRed:红 / 255.0 green:蓝 / 255.0 blue:绿 / 255.0 alpha:0.5]; //  随机 下面 背景变色
        
        添加开关视图[排序].backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.1];//按钮背景色
       
      //  float 红1 = arc4random() % 255;
       //  float 蓝1 = arc4random() % 200;
      //   float 绿1 = arc4random() % 255;
     //   [添加开关视图[排序] setOnTintColor:[UIColor colorWithRed:红1 / 255.0 green:蓝1 / 255.0 blue:绿1 / 255.0 alpha:1.0]]; //  随机 下面 背景变色
        
        
        
        
        
        [添加开关视图[排序] setOnTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];//开启状态颜色
        
     //   float 红2 = arc4random() % 215;
    //     float 蓝2 = arc4random() % 255;
    //     float 绿2 = arc4random() % 255;
    //    [添加开关视图[排序] setTintColor:[UIColor colorWithRed:红2 / 255.0 green:蓝2 / 255.0 blue:绿2 / 255.0 alpha:1.0]]; //  随机 下面 背景变色
        
        
        
        
        [添加开关视图[排序] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];//关闭状态颜色
        [添加开关视图[排序] addTarget:self action:@selector(开关:) forControlEvents:UIControlEventValueChanged];
        [滑动视图 addSubview:添加开关视图[排序]];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //大标题-===========
        if (小标题 !=nil) {
            小标题不为空像素差[排序]=0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 绘制小提示:排序 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
            });
        }else{
            小标题不为空像素差[排序]=5;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 绘制小提示:排序 小标题:小标题 方位:方位 小标题颜色:小标题颜色 归属:归属];
            });
        }
        UILabel*label;
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, (排序)*40, 滑动视图.frame.size.width-52, 40)];
        label.backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"AlNile-Bold" size:字体大小];
        label.font=font;
        NSArray *文字色 = [字体颜色 componentsSeparatedByString:@","];
        label.textColor=[UIColor colorWithRed:[文字色[0] floatValue] green:[文字色[1] floatValue] blue:[文字色[2] floatValue] alpha:[文字色[3] floatValue]];
        label.text = 标题;
        label.numberOfLines = 0;
        if (方位==0) {
            label.textAlignment = NSTextAlignmentLeft;
        }else if(方位==1){
            label.textAlignment = NSTextAlignmentCenter;
        }else if(方位==2){
            label.textAlignment = NSTextAlignmentRight;
        }
        [滑动视图 addSubview:label];
           
        
            
    });
}

- (void)绘制滑条:(int)排序 小标题:(NSString* __nullable)小标题 最大:(NSString* __nullable)最大 最小:(NSString* __nullable)最小 初始:(NSString* __nullable)初始 滑块色:(NSString*)滑块色 归属:(int)归属 调用:(NSString*_Nullable)调用
{
    滑条归属[排序]=归属;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:调用 forKey:[NSString stringWithFormat:@"滑条传值%d",排序]];
        if (小标题!=nil) {
            添加滑条视图[排序]=[[UISlider alloc]initWithFrame:CGRectMake(0, (排序)*40-5, 滑动视图.frame.size.width, 40)];
        } else {
            添加滑条视图[排序]=[[UISlider alloc]initWithFrame:CGRectMake(0, (排序)*40, 滑动视图.frame.size.width, 40)];
        }
        添加滑条视图[排序].backgroundColor = [UIColor clearColor];//滑条背景色
        添加滑条视图[排序].minimumValue=[最小 floatValue];//滑条最大值
        添加滑条视图[排序].maximumValue=[最大 floatValue];//滑条最小值
        添加滑条视图[排序].value=[滑条值[排序] floatValue];
        添加滑条视图[排序].tag=排序;
        // minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
        
        float 红 = arc4random() % 244;
        float 蓝 = arc4random() % 216;
        float 绿 = arc4random() % 250;
        添加滑条视图[排序].minimumTrackTintColor = [UIColor colorWithRed:红 / 255.0 green:蓝 / 255.0 blue:绿 / 255.0 alpha:1.0]; //  随机 下面 背景变色
       
        
       // 添加滑条视图[排序].minimumTrackTintColor = [UIColor colorWithRed:255 green:204 blue:255 alpha:1.0]; // 滑条颜色
        // maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
        添加滑条视图[排序].maximumTrackTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        // thumbTintColor : 当前滑块的颜色，默认为白色
        添加滑条视图[排序].thumbTintColor = [UIColor colorWithRed:1 green:0 blue:6 alpha:1];;
        
        if (滑块色!=nil) {
            NSArray *颜色 = [滑块色 componentsSeparatedByString:@","];
            添加滑条视图[排序].thumbTintColor=[UIColor colorWithRed:[颜色[0] floatValue] green:[颜色[1] floatValue] blue:[颜色[2] floatValue] alpha:[颜色[3] floatValue]];
        }
        添加滑条视图[排序].transform = CGAffineTransformMakeScale(1, 1);//缩放
        //滑块拖动时的事件
        [添加滑条视图[排序] addTarget:self action:@selector(滑条调用:) forControlEvents:UIControlEventValueChanged];
        //滑动拖动后的事件
        [添加滑条视图[排序] addTarget:self action:@selector(滑条停止调用:) forControlEvents:UIControlEventTouchUpInside];
        //视图
        [滑动视图 addSubview:添加滑条视图[排序]];
    });
    
    if (小标题 !=nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NSObject 绘制小提示:排序 小标题:小标题  方位:0 小标题颜色:@"1,1,1,1 " 归属:归属];
        });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *BB=[NSString stringWithFormat:@"值(%@)",滑条值[排序]];
        [NSObject 绘制小提示:排序 小标题:BB 方位:2 小标题颜色:@"1,1,1,1" 归属:滑条归属[排序]];
    });
}
- (void)绘制小提示:(int)排序 小标题:(NSString*)小标题 方位:(int)方位 小标题颜色:(NSString*)小标题颜色 归属:(int)归属
{
    [小提示视图[排序] removeFromSuperview];
    //标题-===========
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (排序==99) {
            CGRect rect =CGRectMake(0, 23, 滑动视图.frame.size.width, 20);
            小提示视图[排序] = [[UILabel alloc]initWithFrame:rect];
        }else{
            CGRect rect =CGRectMake(0, (排序)*40+23, 滑动视图.frame.size.width, 20);
            小提示视图[排序] = [[UILabel alloc]initWithFrame:rect];
        }
        
        
        小提示视图[排序].backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"Verdana-Bold" size:8];
        小提示视图[排序].font=font;
        NSArray *文字色 = [小标题颜色 componentsSeparatedByString:@","];
        小提示视图[排序].textColor=[UIColor colorWithRed:[文字色[0] floatValue] green:[文字色[1] floatValue] blue:[文字色[2] floatValue] alpha:[文字色[3] floatValue]];
        小提示视图[排序].text =小标题;
        
        小提示视图[排序].numberOfLines = 0;//行数
        if (方位==0) {
            小提示视图[排序].textAlignment = NSTextAlignmentLeft;
        } else if(方位==2){
            小提示视图[排序].textAlignment = NSTextAlignmentRight;
        }else{
            小提示视图[排序].textAlignment = NSTextAlignmentCenter;
        }
        [滑动视图 addSubview:小提示视图[排序]];
    });
    
}
- (void)滑条值提示:(int)排序 小标题:(NSString*)小标题 方位:(int)方位 小标题颜色:(NSString*)小标题颜色 归属:(int)归属
{
    
    //标题-===========
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (排序==99) {
            [滑条值提示[排序] removeFromSuperview];
            CGRect rect =CGRectMake(0, 23, 滑动视图.frame.size.width-60, 20);
            滑条值提示[排序] = [[UILabel alloc]initWithFrame:rect];
        }else{
            [滑条值提示[排序] removeFromSuperview];
            CGRect rect =CGRectMake(0, (排序)*40+23, 滑动视图.frame.size.width-60, 20);
            滑条值提示[排序] = [[UILabel alloc]initWithFrame:rect];
        }
        
        
        滑条值提示[排序].backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"Verdana-Bold" size:8];
        滑条值提示[排序].font=font;
        NSArray *文字色 = [小标题颜色 componentsSeparatedByString:@","];
        滑条值提示[排序].textColor=[UIColor colorWithRed:[文字色[0] floatValue] green:[文字色[1] floatValue] blue:[文字色[2] floatValue] alpha:[文字色[3] floatValue]];
        滑条值提示[排序].text =小标题;
        
        滑条值提示[排序].numberOfLines = 0;//行数
        if (方位==0) {
            滑条值提示[排序].textAlignment = NSTextAlignmentLeft;
        } else if(方位==2){
            滑条值提示[排序].textAlignment = NSTextAlignmentRight;
        }else{
            滑条值提示[排序].textAlignment = NSTextAlignmentCenter;
        }
        [滑动视图 addSubview:滑条值提示[排序]];
    });
    
}
-(void)滑条调用:(UISlider *)slider
{
    int 排序=(int)(slider.tag);
    滑条值[排序]=[NSString stringWithFormat:@"%.2f",添加滑条视图[排序].value];
    [滑条值提示[排序] removeFromSuperview];
    NSString*标题 =[NSString stringWithFormat:@"滑动值(%@)",滑条值[排序]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSObject 滑条值提示:(int)(添加滑条视图[排序].tag) 小标题:标题 方位:2 小标题颜色:@"1,1,0,1" 归属:滑条归属[排序]];
    });
}
-(void)滑条停止调用:(UISlider *)slider
{
    int 排序=(int)(slider.tag);
    滑条值[排序]=[NSString stringWithFormat:@"%.2f",添加滑条视图[排序].value];
    NSString* 功能 = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"滑条传值%d",排序]];
     NSLog(@"滑条 功能=%@  排序=%d",功能,排序);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSObject 功能:功能 值: 滑条值[排序]];
    });
}
float 开关像素差;
- (void)开关状态提示:(int)排序 状态:(BOOL)状态 归属:(int)归属
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *开关状态;
        if (状态==YES) {
            开关像素差=0;
            开关状态=@"";
        }else{
            开关像素差=20;
            开关状态=@"";  //开关字修改
        }
        //标题-===========
        if (排序==99) {
            CGRect rect =CGRectMake(滑动视图.frame.size.width-40+开关像素差, 10, 50, 20);
            开关状态提示[排序] = [[UILabel alloc]initWithFrame:rect];
        }else{
            CGRect rect =CGRectMake(滑动视图.frame.size.width-40+开关像素差, (排序)*40+10, 50, 20);
            开关状态提示[排序] = [[UILabel alloc]initWithFrame:rect];
        }
        
        开关状态提示[排序].backgroundColor=[UIColor clearColor];
        UIFont*font=[UIFont fontWithName:@"Verdana-Bold" size:8];
        开关状态提示[排序].font=font;
        开关状态提示[排序].textColor=[UIColor colorWithRed:1 green:0 blue:6 alpha:1];
        开关状态提示[排序].text = 开关状态;
        开关状态提示[排序].numberOfLines = 0;
        开关状态提示[排序].textAlignment = NSTextAlignmentLeft;
        [滑动视图 addSubview:开关状态提示[排序]];
    });
    
}
- (void)图标:(int)排序 状态:(BOOL)状态 归属:(int)归属 开启图标地址:(NSString*_Nullable)开启图标地址 关闭图标地址:(NSString*_Nullable)关闭图标地址
{
    [图标视图[排序] removeFromSuperview];
    if (状态==YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *图标地址;
            if (![开启图标地址 containsString:@"http"]) {
                if (排序==99) {
                    图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-31.5, 5, 30.5, 31.5)];
                }else{
                    图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-31.5, (排序)*40+5, 30, 30)];
                }
                //这里是开启图标按钮偏移
                图标视图[排序].image = 缩放[105];
                CALayer *lay  = 图标视图[排序].layer;//获取ImageView的层
                [lay setMasksToBounds:YES];
                [lay setCornerRadius:15.0];//值越大，角度越圆
                图标视图[排序].transform = CGAffineTransformMakeScale(开关按钮图片的大小, 开关按钮图片的大小);//缩放
                [滑动视图 addSubview:图标视图[排序]];
                
            } else {
                图标地址=开启图标地址;
                NSURL *urlImage = [NSURL URLWithString:图标地址];
                NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
                UIImage *image = [UIImage imageWithData:dataImage];
                CGFloat width = CGImageGetWidth(image.CGImage);
                CGFloat height = CGImageGetHeight(image.CGImage);
                缩放[排序] = [NSObject 原图片:image 新图片:CGSizeMake(width, height) 排序:排序];
                if (排序==99) {
                    图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-31.5, 5, 30.5, 31.5)];
                }else{
                    图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-31.5, (排序)*40+5, 30, 30)];
                }
                //这里是开启图标按钮偏移
                图标视图[排序].image = 缩放[排序];
                CALayer *lay  = 图标视图[排序].layer;//获取ImageView的层
                [lay setMasksToBounds:YES];
                [lay setCornerRadius:15.0];//值越大，角度越圆
                图标视图[排序].transform = CGAffineTransformMakeScale(开关按钮图片的大小, 开关按钮图片的大小);//缩放
                [滑动视图 addSubview:图标视图[排序]];
            }
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *图标地址;
            if (![关闭图标地址 containsString:@"http"]) {
                图标地址 =统一开关关闭图标地址;
                图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-51.5, (排序)*40+5, 30, 30)];
                图标视图[排序].image = 缩放[104];
                CALayer *lay  = 图标视图[排序].layer;//获取ImageView的层
                [lay setMasksToBounds:YES];
                [lay setCornerRadius:15.0];//值越大，角度越圆
                图标视图[排序].transform = CGAffineTransformMakeScale(开关按钮图片的大小, 开关按钮图片的大小);//缩放
                [滑动视图 addSubview:图标视图[排序]];
            } else {
                图标地址=关闭图标地址;
                NSURL *urlImage = [NSURL URLWithString:图标地址];   //  按钮偏移度修改地址下面
                NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
                UIImage *image = [UIImage imageWithData:dataImage];
                CGFloat width = CGImageGetWidth(image.CGImage);
                CGFloat height = CGImageGetHeight(image.CGImage);
                缩放[排序] = [NSObject 原图片:image 新图片:CGSizeMake(width, height) 排序:排序];
                图标视图[排序] = [[UIImageView alloc] initWithFrame:CGRectMake(滑动视图.frame.size.width-51.5, (排序)*40+5, 30, 30)];
                图标视图[排序].image = 缩放[排序];
                CALayer *lay  = 图标视图[排序].layer;//获取ImageView的层
                [lay setMasksToBounds:YES];
                [lay setCornerRadius:15.0];//值越大，角度越圆
                图标视图[排序].transform = CGAffineTransformMakeScale(开关按钮图片的大小, 开关按钮图片的大小);//缩放
                [滑动视图 addSubview:图标视图[排序]];
            }
            
        });
    }
}

- (void)开关:(UISwitch*)开关{
    NSInteger 传值过来的排序= 开关.tag;
    if(开关.on == YES) {
        NSArray *分割 = [开关传值[传值过来的排序] componentsSeparatedByString:@","];
        int 排序= [分割[0] intValue];
        int 归属 = [分割[1] intValue];
        NSString *开启图标地址=分割[2];
        NSString *关闭图标地址=分割[3];
        NSString *调用=分割[4];
        NSString *标题=分割[5];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:标题];
        开关排序[排序]=YES;
        
        
        //判断是不是子菜单
        if (归属!=0) {
            // !=0 的都是子菜单 标记为YES
            判断子菜单打开状态=YES;
            //如果 开启 就只循环显示当前开关为YES 归属
            展开的子菜单归属=归属;
            if(归属==排序){
                [self 隐藏];
                [self 显示];
                
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 图标:排序 状态:YES 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 图标:排序 状态:YES 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NSObject 功能:调用 值:调用];
        });
        NSLog(@"当前开关=排序=%d  归属=%d 展开的子菜单归属=%d 判断子菜单打开状态=%d",排序,归属,展开的子菜单归属,判断子菜单打开状态);

    } else if(开关.on == NO) {
        
        NSArray *分割 = [开关传值[传值过来的排序] componentsSeparatedByString:@","];
        int 排序= [分割[0] intValue];
        int 归属 = [分割[1] intValue];
        NSString *开启图标地址=分割[2];
        NSString *关闭图标地址=分割[3];
        NSString *标题=分割[5];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:标题];
        开关排序[排序]=NO;
        
        //判断是不是子菜单
        if (归属!=0) {
            // !=0 的都是子菜单 标记为NO
            判断子菜单打开状态=NO;
            if(归属==排序 ){
                [self 隐藏];
                [self 显示];
                
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 图标:排序 状态:NO 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
           
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject 图标:排序 状态:NO 归属:归属 开启图标地址:开启图标地址 关闭图标地址:关闭图标地址];
            });
        }
        
        if (排序==DLG排序) {
             DLGMemUIView *view = [DLGMemUIView instance];
            if (view.expanded) [view doCollapse];
            NSArray *gestures = view.gestureRecognizers;
            for (UIGestureRecognizer *gesture in gestures) {
                [view removeGestureRecognizer:gesture];
            }
            [view removeFromSuperview];
        }
    }
    
}
-(void)按钮调用:(UITapGestureRecognizer *)recognizer{
    NSString *按钮点击=[[NSUserDefaults standardUserDefaults] objectForKey:@"按钮点击"];
    NSLog(@"按钮调用被点击了 排序=%@",按钮点击);
    
    [NSObject 功能:按钮点击 值:按钮点击];
}
//图像缩放
-(UIImage*)原图片:(UIImage*)原图片 新图片:(CGSize)新图片 排序:(int)排序
{
    CGSize imageSize =原图片.size;
    int width =imageSize.width;
    int height =imageSize.height;
    float 宽比例 =新图片.width/width;
    float 高比例 =新图片.height/height;
    float 最小比例 =(宽比例 < 高比例) ? 宽比例 : 高比例;
    float 新宽度 =width *最小比例;
    float 新高度 =height *最小比例;
    CGSize 尺寸对象 =CGSizeMake(新宽度, 新高度);
    UIGraphicsBeginImageContext(尺寸对象);
    [原图片 drawInRect:CGRectMake(0, 0, 新宽度, 新高度)];
    缩放[排序] = UIGraphicsGetImageFromCurrentImageContext();
    return 缩放[排序];
}
-(void)显示
{
    NSLog(@"点击 显示");
    [self 主视图];
}
-(void)隐藏
{
    NSLog(@"点击 隐藏");
    for(UIView *view in [滑动视图 subviews])
        {
            [view removeFromSuperview];
        }
    for(UILabel *view in [滑动视图 subviews])
        {
            [view removeFromSuperview];
        }
    for(UISwitch *view in [滑动视图 subviews])
        {
            [view removeFromSuperview];
        }
    for(UIImageView *view in [滑动视图 subviews])
        {
            [view removeFromSuperview];
        }
    [滑动视图 removeFromSuperview];
    [隐藏视图 removeFromSuperview];
    [添加主菜单视图 removeFromSuperview];
    
}
-(void)删除视图
{
    [隐藏视图 removeFromSuperview];
}

@end
