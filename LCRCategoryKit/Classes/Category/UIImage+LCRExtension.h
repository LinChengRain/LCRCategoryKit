//
//  UIImage+LCRExtension.h
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LCRExtension)

/**
 * 压缩图片使图片文件小于指定大小
 * @param maxLength  压缩最大长度
 */
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength ;

///   将某个view 转换成图像
+(UIImage *)getImageFromView:(UIView *)view ;


- (UIImage *)createQRCodeWithUrl:(NSString *)url logo:(UIImage *)logo;

+ (UIImage *)logolOrQRImage:(NSString *)QRTargetString logolImage:(UIImage *)logolImage;


@end

NS_ASSUME_NONNULL_END
