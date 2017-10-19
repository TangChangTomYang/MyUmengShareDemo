//
//  UIImage+Color.h
//  LETTIN
//
//  Created by cuijing on 11/6/15.
//  Copyright © 2015 infosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
/** 创建1*1 大小的纯色图像 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)accelerateBlurWithBoxSize:(int)boxSize;



  /** 图片裁剪*/
-(UIImage *)tailorImageAtRect:(CGRect)rect scale:(CGFloat)scale;
-(UIImage *)tailorImageTopAtPoint:(CGFloat)point;
-(UIImage *)tailorImageBottomAtPoint:(CGFloat)point;

  /** 生成二维码*/
+(UIImage *)createQRCodeImageByString:(NSString *)inputStr imageSize:(CGFloat)imageSize ;
@end
