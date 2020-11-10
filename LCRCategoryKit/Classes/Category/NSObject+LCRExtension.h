//
//  NSObject+LCRExtension.h
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LCRExtension)

/**
 修改字符串大小
 
 @param string 原始字符串
 @param targetStr 要修改的字符串
 @param font 要设置的字体
 @return 修改后的
 */
+ (NSMutableAttributedString *)changeStr:(NSString *)string targetStr:(NSString *)targetStr fon:(UIFont *)font;

///  设置删除线
/// @param string 要修改的字符串
/// @param length 长度
/// @param color 颜色
+ (NSMutableAttributedString *)changeStrDeleteLine:(NSString *)string length:(NSInteger )length color:(UIColor *)color;

/// 获取字符串的宽
/// @param string 字符串
/// @param height 最大高度
/// @param font 字体大小
+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(UIFont *)font ;

/// 获取字符串的高
/// @param string 字符串
/// @param width 最大宽度
/// @param font 字体
+ (CGFloat)calculateTextForHeight:(NSString *)string width:(NSInteger)width font:(UIFont *)font;
/**
 修改字符串颜色
 
 @param string 原始字符串
 @param targetStr 要修改的字符串
 @param color 要设置的颜色
 @return 修改后的
 */
+ (NSMutableAttributedString *)changeStrColor:(NSString *)string targetStr:(NSString *)targetStr color:(UIColor *)color;

/**
 制定圆角
 
 @param bounds 控件bounds
 @param corners 原价位置，
 @param radiu 圆角大小
 @return CAShapeLayer
 */
- (CAShapeLayer *)widgeMaskLayer:(CGRect)bounds corners:(UIRectCorner)corners radiu:(CGFloat)radiu;

@end

#pragma mark - 正则匹配
@interface NSObject (Regex)

#pragma mark - 正则匹配用户密码6-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma mark - 限制只输入数字和字母
+ (BOOL)checkInputWord:(NSString *) str;

#pragma mark - 正则匹配邮箱
+ (BOOL)checkUserEmail:(NSString*)email;

/// 字符串是否包含表情
/// @param string 验证字符串
+ (BOOL)stringContainsEmoji:(NSString *)string;

///判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string ;
///去除表情
+ (NSString *)disableEmoji:(NSString *)text ;

///是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;

+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString;//判断输入的为字母或数字；

+ (BOOL)isAvailableCN:(NSString *)string; //判断是否是中文

///判断是否是email
-(BOOL)isEmail;
//判断昵称
- (BOOL)isTureUserName;
//判断是否是纯数字
+ (BOOL)isNum:(NSString *)string;
@end

@interface NSObject (Transition)

- (NSDictionary *)dicFromObject:(NSObject *)object;//model转字典

@end

NS_ASSUME_NONNULL_END
