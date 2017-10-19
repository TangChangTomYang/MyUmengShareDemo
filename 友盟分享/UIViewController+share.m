//
//  UIViewController+share.m
//  友盟分享
//
//  Created by yangrui on 2017/5/18.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import "UIViewController+share.h"
@implementation UIViewController (share)


/** 微信、微博、qq 都支持 文字分享 */
-(void)shareText:(NSString *)text  ToPlatform:(UMSocialPlatformType)platformType{

    //创建分享消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    
    //设置分享的文字
    msgObj.text = text;
    
    //调用分享接口
     [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
         
         
         if (error != nil) {
             NSLog(@"  just 文字分享失败:%@",error);
         }
         else{
             NSLog(@"  just 文字分享成功：%@ ",result);
         }
     }];
    
}

/** 微信、微博、qq 都支持 文字图片 */
-(void)shareImage:(UIImage *)image ToPlatfor:(UMSocialPlatformType)platformType{

    //创建分享消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareImgObj = [[UMShareImageObject alloc]init];
    //如果有缩略图则设置缩略图
    shareImgObj.shareImage = image ; //这个是分享的图片
    //给分享消息的对象，设置消息内容对象
    msgObj.shareObject = shareImgObj;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
        if (error != nil) {
            NSLog(@"just 分享图片失败");
        }
        else{
            NSLog(@"just 分享图片成功 :%@",result);
        }
    }];
    
}

/** 分享图文 只有新浪微博支持，微信和QQ都不支持 */
-(void)shareImage:(UIImage *)image AndText:(NSString *)text ToPlatfor:(UMSocialPlatformType)platformType{

    //创建消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    //设置分享文字
    msgObj.text = text;
    
    // 创建图文分享 图片分享对象
    UMShareImageObject *shareImgObj = [[UMShareImageObject alloc]init];
    shareImgObj.shareImage =image; // 经过测试， 这里只能使用图片，而且要注意 是否有图片
    msgObj.shareObject = shareImgObj;
    
    // 调用分享接口分享数据
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
        if (error != nil) {
            NSLog(@"分享 图文 失败");
        }
        else{
        NSLog(@"分享 图文 成功 ： %@",result);
        }
    }];

}

/** 分型网页。微信、微博、qq 全都支持 
 注意： thumbImgOrUrlStr 可以是image也可以是image对应的URLStr
 */
-(void)shareWebpageUrlStr:(NSString *)webpageUrlStr title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrUrlStr ToPlatform:(UMSocialPlatformType)platformType{
    
    //创建分享的消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
     //msgObj.text = @"你二大爷  ";  //经过测试这个 文字在新浪中 传不传都会被过滤掉，所以不传
    
    //创建网页的内容对象
    UMShareWebpageObject *webpageObj = [UMShareWebpageObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImgOrUrlStr];
    webpageObj.webpageUrl = webpageUrlStr;// 必须要有网页url地址
    
    //设置分享消息对象的 内容对象
    msgObj.shareObject = webpageObj;
    
    //调用分享接口分享数据
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
        if (error != nil) {
            NSLog(@"分享 网页 失败");
        }
        else{
            NSLog(@"分享网页成功： %@",result);
        }
    }];
    


}


/** 分享 视频 微信、微博、QQ 都支持 */
-(void)shareMovieUrlStr:(NSString *)movieUrlStr title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrImgUrlStr ToPlatform:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    //创建分型 n视频对象
    UMShareVideoObject *shareVideoObj = [UMShareVideoObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImgOrImgUrlStr];
    //视频地址
    shareVideoObj.videoUrl = movieUrlStr;
    //设置分享消息对像的 视频内容对象
    msgObj.shareObject = shareVideoObj;

    //调用 分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
        if (error != nil) {
            NSLog(@"分型视频失败");
        }
        else{
            NSLog(@"分享视频成功：%@",result);
        }
    }];

}


/** 分享 yinyue  微信、微博、QQ 都支持 */
-(void)shareMusicUrlStr:(NSString *)musicUrlStr musicDataUrl:(NSString *)musicDataUrl title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrImgUrlStr ToPlatform:(UMSocialPlatformType)platformType{

    //创建分享消息对象
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    
    //创建分型音乐对象
    UMShareMusicObject *shareMusicObj = [UMShareMusicObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImgOrImgUrlStr];
    //音乐地址
    shareMusicObj.musicUrl = musicUrlStr;
    shareMusicObj.musicDataUrl = musicDataUrl;
    
    //设置分享消息对像的 音乐内容对象
    msgObj.shareObject = shareMusicObj;
    
    //调用 分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:msgObj currentViewController:self completion:^(id result, NSError *error) {
        if (error != nil) {
            NSLog(@"分型音乐失败");
        }
        else{
            NSLog(@"分享音乐成功：%@",result);
        }
    }];
    
}



@end

































