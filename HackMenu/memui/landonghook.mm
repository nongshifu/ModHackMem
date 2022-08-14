#line 1 "/Users/macgu/Desktop/landonghook/landonghook/landonghook.xm"


#import <UIKit/UIKit.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class DES3Util; 
static NSString* (*_logos_meta_orig$_ungrouped$DES3Util$decrypt$gkey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString*, NSString *); static NSString* _logos_meta_method$_ungrouped$DES3Util$decrypt$gkey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString*, NSString *); static NSString* (*_logos_meta_orig$_ungrouped$DES3Util$encrypt$gkey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString*, NSString *); static NSString* _logos_meta_method$_ungrouped$DES3Util$encrypt$gkey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString*, NSString *); 

#line 5 "/Users/macgu/Desktop/landonghook/landonghook/landonghook.xm"


static NSString *uuid =nil ;

static NSString* _logos_meta_method$_ungrouped$DES3Util$decrypt$gkey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString* arg1, NSString * gkey) {
NSString* va = _logos_meta_orig$_ungrouped$DES3Util$decrypt$gkey$(self, _cmd, arg1, gkey);
NSLog(@"加密字符----%@密钥----%@解密字符----%@",arg1,gkey,va);

if([va containsString:@"response"]){
if ([va rangeOfString:@"激活"].location == NSNotFound) {

} else {
NSMutableString* ca=[[NSMutableString alloc]initWithString:@"{\"response\":{\"data\":\"01|1081|\",\"date\":\"\",\"unix\":\"32472115200\",\"microtime\":\"0.104014\",\"appsafecode\":\"\",\"sgin\":\"8c4edb35a66376a016ad67ebf548c5e4\"}}"];
[ca insertString:uuid atIndex:29];
va = ca;
}
}else {

}

return va;

}
static NSString* _logos_meta_method$_ungrouped$DES3Util$encrypt$gkey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString* arg1, NSString * gkey) {

if([arg1 containsString:@"maxoror"]){

uuid = [arg1 substringFromIndex:arg1.length-36];

}
return _logos_meta_orig$_ungrouped$DES3Util$encrypt$gkey$(self, _cmd, arg1, gkey);
}
;
;
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$DES3Util = objc_getClass("DES3Util"); Class _logos_metaclass$_ungrouped$DES3Util = object_getClass(_logos_class$_ungrouped$DES3Util); MSHookMessageEx(_logos_metaclass$_ungrouped$DES3Util, @selector(decrypt:gkey:), (IMP)&_logos_meta_method$_ungrouped$DES3Util$decrypt$gkey$, (IMP*)&_logos_meta_orig$_ungrouped$DES3Util$decrypt$gkey$);MSHookMessageEx(_logos_metaclass$_ungrouped$DES3Util, @selector(encrypt:gkey:), (IMP)&_logos_meta_method$_ungrouped$DES3Util$encrypt$gkey$, (IMP*)&_logos_meta_orig$_ungrouped$DES3Util$encrypt$gkey$);} }
#line 46 "/Users/macgu/Desktop/landonghook/landonghook/landonghook.xm"
