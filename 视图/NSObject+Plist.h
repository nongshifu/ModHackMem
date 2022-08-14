//
//  NSObject+Plist.h
//  iOsGods.Cn
//
//  Created by  十三哥 on 2022/1/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Plist)
-(void)初始化主菜单:(NSString*)标题 字体大小:(int)字体大小 方位:(int)方位 宽度:(int)宽度 高度:(int)高度 背景颜色:(NSString*)背景颜色 标题颜色:(NSString*)标题颜色 标题背景色:(NSString*)标题背景色 背景图片:(NSString* _Nullable)背景图片 背景图透明度:(float)背景图透明度 功能数:(int)功能数;
- (void)文字:(int)排序 菜单类型:(int)菜单类型 标题:(NSString*)标题 字体大小:(int)字体大小 标题颜色:(NSString*)标题颜色 方位:(int)方位 小标题:(NSString*_Nullable)小标题 小标题颜色:(NSString*)小标题颜色 归属:(int)归属 调用:(NSString*_Nullable)调用;
- (void)滑条:(int)排序 菜单类型:(int)菜单类型 小标题:(NSString*_Nullable)小标题 最大:(NSString*_Nullable)最大 最小:(NSString*_Nullable)最小 初始:(NSString*_Nullable)初始 滑块色:(NSString*)滑块色 归属:(int)归属 调用:(NSString*_Nullable)调用;
- (void)开关:(int)排序 菜单类型:(int)菜单类型 标题:(NSString*)标题 字体大小:(int)字体大小 方位:(int)方位 字体颜色:(NSString*)字体颜色 小标题:(NSString*_Nullable)小标题 小标题颜色:(NSString*)小标题颜色 开启图标地址:(NSString*_Nullable)开启图标地址 关闭图标地址:(NSString*_Nullable)关闭图标地址 归属:(int)归属 调用:(NSString*_Nullable)调用;

@end

NS_ASSUME_NONNULL_END
