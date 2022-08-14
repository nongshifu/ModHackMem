

#import <UIKit/UIKit.h>

%hook DES3Util

static NSString *uuid =nil ;

+ (NSString*)decrypt:(NSString*)arg1 gkey:(NSString *)gkey {
NSString* va = %orig;
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
+ (NSString*)encrypt:(NSString*)arg1 gkey:(NSString *)gkey {

if([arg1 containsString:@"maxoror"]){

uuid = [arg1 substringFromIndex:arg1.length-36];

}
return %orig;
}





%end

;
;
