//
//  PubgLoad.m
//  pubg
//
//  Created by 李良林 on 2021/2/14.
//

#import "PubgLoad.h"
#import <UIKit/UIKit.h>
#import "JHPP.h"
#import "JHDragView.h"
#import "NSObject+UI.h"
@interface PubgLoad()
@end

@implementation PubgLoad

static PubgLoad *extraInfo;
static BOOL MenDeal;

+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        extraInfo =  [PubgLoad new];
        [extraInfo initTapGes];
        [extraInfo tapIconView];
    });
}

-(void)initTapGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;//点击次数
    tap.numberOfTouchesRequired = 3;//手指数
    [[JHPP currentViewController].view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView)];
}


-(void)tapIconView
{
    JHDragView *view = [[JHPP currentViewController].view viewWithTag:100];
    if (!view) {
        view = [[JHDragView alloc] init];
        view.tag = 100;
        [[JHPP currentViewController].view addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onConsoleButtonTapped)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
    }
    
    if (!MenDeal) {
        view.hidden = NO;
        [[UIView alloc] 显示图标];
    } else {
        view.hidden = YES;
        [[UIView alloc] 隐藏图标];
    }
    
    MenDeal = !MenDeal;
}


-(void)onConsoleButtonTapped
{
    
   

}


@end
