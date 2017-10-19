//
//  UIImage+Color.m
//  LETTIN
//
//  Created by cuijing on 11/6/15.
//  Copyright © 2015 infosys. All rights reserved.
//

#import "UIImage+Color.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Color)

/** 创建1*1 大小的纯色图像 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    /**
     CGSize size,
     BOOL opaque,
     CGFloat scale
     */
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius
{
    CGRect rect = (CGRect){CGPointZero, size};
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale); //当前屏幕的缩放比例 @2x  @3x
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:rect
                                                      cornerRadius:cornerRadius];
    
    CGContextAddPath(context, bezier.CGPath);
    
    CGContextClosePath(context);
    
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)accelerateBlurWithBoxSize:(int)boxSize;
{
//    NSInteger boxSize = (NSInteger)(10 * 5);
    boxSize = boxSize - (boxSize % 2) + 1;  // 保证是奇数
    UIImage *retImage = nil;
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;
    
    void *pixelBuffer, *convertBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    assert(inBitmapData);
    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    if (convertBuffer && pixelBuffer)
    {
        rgbOutBuffer.width = CGImageGetWidth(img);
        rgbOutBuffer.height = CGImageGetHeight(img);
        rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
        rgbOutBuffer.data = convertBuffer;
        
        inBuffer.width = CGImageGetWidth(img);
        inBuffer.height = CGImageGetHeight(img);
        inBuffer.rowBytes = CGImageGetBytesPerRow(img);
        inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

        outBuffer.data = pixelBuffer;
        outBuffer.width = CGImageGetWidth(img);
        outBuffer.height = CGImageGetHeight(img);
        outBuffer.rowBytes = CGImageGetBytesPerRow(img);
        
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        if (error) {
//            NSLog(@"error from convolution %ld", error);
        }
        const uint8_t mask[] = {2, 1, 0, 3};
        
        vImagePermuteChannels_ARGB8888(&outBuffer, &rgbOutBuffer, mask, kvImageNoFlags);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data,
                                                 rgbOutBuffer.width,
                                                 rgbOutBuffer.height,
                                                 8,
                                                 rgbOutBuffer.rowBytes,
                                                 colorSpace,
                                                 (kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast));
        CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
        retImage = [UIImage imageWithCGImage:imageRef];
        
        //clean up
        CGImageRelease(imageRef);
        CGContextRelease(ctx);
        CGColorSpaceRelease(colorSpace);
    }
    free(pixelBuffer);
    free(convertBuffer);
    CFRelease(inBitmapData);
    
    
    return (retImage);
}

  /**
   2017-06-06 14:02:59.355 LETTIN[3205:112609] -[UIImage(Color) tailorImageAtRect:scale:]
   tailorRect: {{0, 0}, {750, 128}}
   
   2017-06-06 14:03:00.158 LETTIN[3205:112609] -[UIImage(Color) tailorImageAtRect:scale:]
   imageSize: {375, 667}
   
   */


-(UIImage *)tailorImageAtRect:(CGRect)rect scale:(CGFloat)scale{
    
    UIImage *newImage = nil;
    CGRect tailorRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    

    if (tailorRect.size.width <= self.size.width && tailorRect.size.height <= self.size.height) {
        
        CGImageRef sourceImageRef = [self CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, tailorRect);
        newImage = [UIImage imageWithCGImage:newImageRef];
    }
    
    return  newImage;
    
    
}


-(UIImage *)tailorImageTopAtPoint:(CGFloat)point{
    UIImage *newImage = nil;
    if (point > 0 && point <self.size.height) {
        CGFloat scale = [UIScreen mainScreen].scale;
        CGRect rect = CGRectMake(0, 0, self.size.width * scale , point *scale);
        CGImageRef sourceImageRef = [self CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        newImage = [UIImage imageWithCGImage:newImageRef];
    }
    
    return newImage;
}


-(UIImage *)tailorImageBottomAtPoint:(CGFloat)point{
    UIImage *newImage = nil;
    if (point > 0 && point <self.size.height) {
        
        CGFloat scale = [UIScreen mainScreen].scale;
        CGRect rect = CGRectMake(0, point *scale , self.size.width * scale , (self.size.height - point) * scale);
        CGImageRef sourceImageRef = [self CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        newImage = [UIImage imageWithCGImage:newImageRef];
    }
    
    return newImage;
}





+(UIImage *)createQRCodeImageByString:(NSString *)inputStr imageSize:(CGFloat)imageSize {
    
    //2. 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];//@"CIQRCodeGenerator"  是过滤器的名字固定这么写
    //3.恢复默认设置
    [filter setDefaults];
    
    //4. 给过滤器添加数据
    NSString *dataStr = inputStr;
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"]; //表示输入的信息
    
    //5. 获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 6.显示二维码
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageSize];
}


/**
 *  根据CIImage生成指定大小的UIImage
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
