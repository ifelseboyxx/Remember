// 所有的全局宏配置

#import <UIKit/UIKit.h>

//日志输出
#ifdef DEBUG
#define RRLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RRLog(format, ...)
#endif

//Hex Color
#define RRHexColor(HexStr) [UIColor colorWithHexString:HexStr];
#define RRHexColorAlpha(HexStr,Aplha) [UIColor colorWithHexString:RRHeaderTextColor withAlpha:Aplha];

//语言切换 (zh-Hans、zh-Hant、en)
#define RRLanguage(format) [[NSUserDefaults standardUserDefaults] setObject:@[format] forKey:@"AppleLanguages"];

/***********************************业务*******************************************/

//下拉字体颜色
#define RRHeaderTextColor (@"#383639")

//是否授权标示 (有值表示相关权限授权完毕)
UIKIT_EXTERN NSString *const RRAuthorizationed;
