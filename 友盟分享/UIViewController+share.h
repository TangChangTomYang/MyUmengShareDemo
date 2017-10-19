//
//  UIViewController+share.h
//  友盟分享
//
//  Created by yangrui on 2017/5/18.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>

@interface UIViewController (share)


/** 微信、微博、qq 都支持 文字分享 
 text 可以预置描述内容 text 当在分享时可能被用户修改
 */
-(void)shareText:(NSString *)text  ToPlatform:(UMSocialPlatformType)platformType;

/** 微信、微博、qq 都支持 文字图片
    用户在实际分享时 可以填写分享内容
 */
-(void)shareImage:(UIImage *)image ToPlatfor:(UMSocialPlatformType)platformType;

/** 分享图文 只有新浪微博支持，微信和QQ都不支持 
    text 可以预置描述内容 text 当在分享时可能被用户修改
 */
-(void)shareImage:(UIImage *)image AndText:(NSString *)text ToPlatfor:(UMSocialPlatformType)platformType;

/** 分型网页。微信、微博、qq 全都支持,注意，微博在发送时有 图标 当时用户收到的信息不显示图标
 注意： thumbImgOrUrlStr 可以是image也可以是image对应的URLStr
 */
-(void)shareWebpageUrlStr:(NSString *)webpageUrlStr title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrUrlStr ToPlatform:(UMSocialPlatformType)platformType;

/** 分型视频。微信、微博、qq 全都支持,注意，微博在发送时有 图标 当时用户收到的信息不显示图标
 注意： thumbImgOrUrlStr 可以是image也可以是image对应的URLStr
 */
-(void)shareMovieUrlStr:(NSString *)movieUrlStr title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrImgUrlStr ToPlatform:(UMSocialPlatformType)platformType;

/** 分型音乐。微信、微博、qq 全都支持,注意，微博在发送时有 图标 当时用户收到的信息不显示图标
 注意： thumbImgOrUrlStr 可以是image也可以是image对应的URLStr
 
 musicUrlStr 必须填写，这个好像是播放方音乐的网页地址
 musicDataUrl 这个可以不填写，这个是歌曲的实际地址
 */
-(void)shareMusicUrlStr:(NSString *)musicUrlStr musicDataUrl:(NSString *)musicDataUrl title:(NSString *)title subTitle:(NSString *)subTitle thumbImg:(id)thumbImgOrImgUrlStr ToPlatform:(UMSocialPlatformType)platformType;


@end
