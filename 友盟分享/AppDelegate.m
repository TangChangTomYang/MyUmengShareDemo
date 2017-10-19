//
//  AppDelegate.m
//  友盟分享
//
//  Created by yangrui on 2017/5/18.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>


#define  UMShareAppKey_YR       @"591b862eae1bf84712001897" //友盟分享的appKey 杨锐 个人的
#define  UMShareAppKey_Lettin  @"5863260745297d084500254e"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self initsetupUmShare];
    
    return YES;
}

#pragma mark- 初始化设置友盟分享
-(void)initsetupUmShare{
    /** 打开调试 日志 */
    UMSocialManager *UMSMgr = [UMSocialManager defaultManager];
   
    [UMSMgr openLog:YES];
    
    /** 设置友盟分享 的 app key */
//    [UMSMgr setUmSocialAppkey:UMShareAppKey_YR];

    [UMSMgr setUmSocialAppkey:UMShareAppKey_Lettin];
    /** 打开图片水印*/
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialWarterMarkConfig defaultWarterMarkConfig].imageWarterMarkConfig.warterMarkImage = [UIImage imageNamed:@"share_icon_room_highlight"];
    /** 配置第三方分享的平台 信息 */
    [self configSharedPlatformsInfo];
}

#pragma mark- 配置友盟分享的各个 平台 的信息
-(void)configSharedPlatformsInfo{

    
    UMSocialManager *UMSMgr = [UMSocialManager defaultManager];

    /** 设置微信的 appkey 和 secret */
    NSString *wechatAppkey = @"wx5372cd705ff92d38";
    NSString *wechatAppSceret = @"cfe953b72037a27bf2ba5ed721e8b9b5" ;
    NSString *wechatRedirectUrl = @"http://mobile.umeng.com/social";
    [UMSMgr setPlaform:UMSocialPlatformType_WechatSession appKey:wechatAppkey appSecret:wechatAppSceret redirectURL:wechatRedirectUrl];

    /** 设置QQ的 appkey 和 secret   lettinios */
//    NSString *QQAppkey = @"1106078265";
//    NSString *QQAppSceret = nil; // qq 不需要
//    NSString *QQRedirectUrl = @"http://mobile.umeng.com/social";
//    [UMSMgr setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey appSecret:QQAppSceret redirectURL:QQRedirectUrl];

    /** 设置QQ的 appkey 和 secret   lettin */
    NSString *QQAppkey = @"1106197454";
    NSString *QQAppSceret = nil; // qq 不需要
    NSString *QQRedirectUrl = @"http://mobile.umeng.com/social";
    [UMSMgr setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey appSecret:QQAppSceret redirectURL:QQRedirectUrl];

    
    /** 设置新浪微博的 appkey 和 secret */
    NSString *sinaAppkey = @"2518043615";
    NSString *sinaAppSceret = @"bf03948bd3bfc31c6020f86487fe425b";
    NSString *sinaRedirectUrl = @"http://lettin.cn";
    [UMSMgr setPlaform:UMSocialPlatformType_Sina appKey:sinaAppkey appSecret:sinaAppSceret redirectURL:sinaRedirectUrl];
    
    
  

}

#pragma  mark- 设置umeng 分享系统回调 （支持所有的ios 系统） 这种方式是 友盟建议的，切新浪只支持这种
-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{

    
   BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (result == NO) {
        //其他支付等SDk 回调
    }
    return result;
}







































@end
