//
//  UIColor+LCRExtension.h
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LCRExtension)

+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

- (NSString *)HEXString;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end

NS_ASSUME_NONNULL_END
