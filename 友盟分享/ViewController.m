//
//  ViewController.m
//  友盟分享
//
//  Created by yangrui on 2017/5/18.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h> //UI 方面的框架

#import "UIViewController+share.h"
#import "UIImage+Color.h"
@interface ViewController ()<UMSocialShareMenuViewDelegate>

@end

@implementation ViewController
-(UIImage *)shareRQCodeImage{
    
    return [UIImage createQRCodeImageByString:@"你二大爷的图片" imageSize:200];

}
- (IBAction)shareBtnClick:(id)sender {
     [self showShareMenu];
}

- (IBAction)thirdPartyLoginBtnClick:(id)sender {
    
    [self showThirdParty_LoginMenu];
}


/** -----------分享------------------------------------------- */
#pragma  mark- 调用分享面板
-(void)showShareMenu{
    
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]] == YES) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
//        return;
//    }
    
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareImageObj = [UMShareImageObject shareObjectWithTitle:@"分享图片标题" descr:@"分享图片描述" thumImage: [UIImage imageNamed:@"Leftbar_icon_share_white"]];
    shareImageObj.shareImage = [self  shareRQCodeImage];
    
    msgObj.shareObject = shareImageObj;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:msgObj currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
    
    
    
    return;
    
    //
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://"]];
   //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weibo://"]];
     //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Whatsapp://"]];
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Whatsapp://"]]) {
//        NSLog(@"可以打开 WhatsApp");
//    }else{
//         NSLog(@"不  可以打开 WhatsApp");
//    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        NSLog(@"可以打开 WhatsApp");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }else{
        NSLog(@"不  可以打开 WhatsApp");
    }
    
    return;
    
    //自定义 第三方平台
    [self customDefine_ThirdParty_Platforms];

    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //分享文字
        //[self shareText:@"just 文字分享" ToPlatform:platformType];
        
        //分享图片
        //[self shareImage:[UIImage imageNamed:@"bcd.jpg"] ToPlatfor:platformType];
        
        //分享图文
        [self shareImage:[UIImage imageNamed:@"bcd.jpg"] AndText:@"图文分享的 文字" ToPlatfor:platformType];
        
        //分享网页
        //[self shareWebpageUrlStr:@"http://lettin.cn" title:@"网页分享标题 固定" subTitle:@"网页分享自标题固定" thumbImg:[UIImage imageNamed:@"bcd.jpg"] ToPlatform:platformType];
        
        //分享视频
        //[self shareMovieUrlStr:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html" title:@"分享视频标题 固定" subTitle:@"分享视频 子标题 固定" thumbImg:[UIImage imageNamed:@"bcd.jpg"] ToPlatform:platformType];
     
        //分享音乐
        NSString  *musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
        NSString  *musicDataUrl = @"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3";
        
        [self shareMusicUrlStr:musicUrl musicDataUrl:nil title:@"分享音乐标题 固定" subTitle:@"分享音乐 子标题 固定" thumbImg:[UIImage imageNamed:@"bcd.jpg"] ToPlatform:platformType];
    }];
}


#pragma mark- 自定义 第三方平台
-(void)customDefine_ThirdParty_Platforms{
    
    
    NSArray *platforms = @[@(UMSocialPlatformType_Sina),
                           @(UMSocialPlatformType_WechatSession),
                           @(UMSocialPlatformType_WechatTimeLine),
                           @(UMSocialPlatformType_QQ),
                           @(UMSocialPlatformType_Qzone),
                           @(UMSocialPlatformType_Whatsapp)];
    [UMSocialUIManager setPreDefinePlatforms:platforms];
}

#pragma mark- 字定义分享面板的样式
-(void)customDefimeMenuViewStyle{
    

}

#pragma  mark- 设置分享面板的代理
-(void)UMSocialShareMenuViewDidAppear{
    
    NSLog(@"分享面板出现");
}

-(void)UMSocialShareMenuViewDidDisappear{
    NSLog(@"分享面板消失");
}



/** -----------分第三方登录------------------------------------------- */

/** 想必很多人都遇到过这个错误吧，新浪微博分享的时候出现：sso package or sign error。出现这个问题是因为你在新浪微博开放平台上申请的应用的bundle identifier 和你项目的bundle identifier不一致造成的。 */
-(void)showThirdParty_LoginMenu{
    
    //自定义 第三方平台
    [self customDefine_ThirdParty_Platforms];
    
    [self customDefine_sharePad];
    
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self getUsrInfoForPlatform:platformType];
    }];
}
/** 根据平台信息 获取用户的 信息 */

-(void)getUsrInfoForPlatform:(UMSocialPlatformType )platformType {
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        NSLog(@"result class: %@,result: %@,platform: %ld",[result class],result,platformType);
    }];
}


/** 字定义 第三方平台的 显示面板 */
-(void)customDefine_sharePad{

    // 创建 配置对象
    UMSocialShareUIConfig  *UIConfig = [UMSocialShareUIConfig shareInstance];
    
    //顶部 设置标题
    UMSocialShareTitleViewConfig *titleConfig = UIConfig.shareTitleViewConfig;
    titleConfig.shareTitleViewTitleString = @"第三方登录";
    
    //底部 标题
    UMSocialShareCancelControlConfig *cancleConfig = UIConfig.shareCancelControlConfig;
    cancleConfig.shareCancelControlText = @"取消";
 
}

@end


