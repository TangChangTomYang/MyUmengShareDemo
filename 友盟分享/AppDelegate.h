//
//  AppDelegate.h
//  友盟分享
//
//  Created by yangrui on 2017/5/18.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

/** 分享LinkCard（网页、音乐、视频链接分享）
 
 进行网页链接的分享是多数应用进行的推广和分享形式（包含了标题、描述和缩略图），微博的分享与微信和QQ 的分享方式不同，
 微信和qq 平台的分享显示一张card形式的消息，点开后会打开链接
 
 1、什么是linkcard
  在微博消息流内，分享一条链接，该链接将解析为包含一个对象数据的 特殊短链，且该对象数据可以在微博消息流内显示并交互，这种形态就是微博消息流 linkcard 解析。
 2、分享网页类型数据之后不显示缩略图，是什么原因，这属于微博的移动应用商务合作，移动sdk 中的linkcard和附件栏集成分享权限需要合作生情
 */



/**  第三方平台分享时支持的类型
 
 微信好友、微信朋友圈、微信收藏、QQ、QQ空间  这5个第三方
 都支持：  文字分享、图片分享、web链接分享、视频链接分享、音乐分享
 都不支持：图文分享
 
 新浪微博支持:文字分享、图片分享、图文分享、web链接分享、视频链接分享、音乐分享
 
 */
