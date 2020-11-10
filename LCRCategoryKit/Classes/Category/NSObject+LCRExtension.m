//
//  NSObject+LCRExtension.m
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import "NSObject+LCRExtension.h"
#import <objc/runtime.h>
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"//数字和字母
#define NUM @"0123456789"//只输入数字
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"//只输入字母

@implementation NSObject (LCRExtension)

#pragma mark - private
/**
 修改字符串大小
 
 @param string 原始字符串
 @param targetStr 要修改的字符串
 @param font 要设置的字体
 @return 修改后的
 */
+ (NSMutableAttributedString *)changeStr:(NSString *)string targetStr:(NSString *)targetStr fon:(UIFont *)font{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //找出特定字符在整个字符串中的位置
    NSRange range = NSMakeRange([[attrString string] rangeOfString:targetStr].location, [[attrString string] rangeOfString:targetStr].length);
    
    //NSMakeRange(0, 3)从0开始的3个字符
    [attrString addAttributes:@{NSFontAttributeName:font} range:range];
    return attrString;
}

+ (NSMutableAttributedString *)changeStrDeleteLine:(NSString *)string length:(NSInteger )length color:(UIColor *)color
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, length)];
 
    return attri;
}
+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

+ (CGFloat)calculateTextForHeight:(NSString *)string width:(NSInteger)width font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
+ (NSMutableAttributedString *)changeStrColor:(NSString *)string targetStr:(NSString *)targetStr color:(UIColor *)color
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //找出特定字符在整个字符串中的位置
    NSRange range = NSMakeRange([[attrString string] rangeOfString:targetStr].location, [[attrString string] rangeOfString:targetStr].length);
    
    //NSMakeRange(0, 3)从0开始的3个字符
    [attrString addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    return attrString;
}


#pragma mark - private
/**
 制定圆角

 @param bounds 控件bounds
 @param corners 原价位置，
 @param radiu 圆角大小
 @return CAShapeLayer
 */
- (CAShapeLayer *)widgeMaskLayer:(CGRect)bounds corners:(UIRectCorner)corners radiu:(CGFloat)radiu {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radiu, radiu)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
@end


@implementation NSObject (Regex)

#pragma mark - 正则匹配用户密码6-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
#pragma mark - 限制只输入数字和字母
+ (BOOL)checkInputWord:(NSString *) str
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [str isEqualToString:filtered];
}
#pragma mark - 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString*) idCard{
    BOOL flag;
    if(idCard.length<=0) {
        flag =NO;
        return flag;
    }
    NSString *regex2 =@"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate*identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return[identityCardPredicate evaluateWithObject:idCard];
    
}
#pragma mark - 正则匹配邮箱
+ (BOOL)checkUserEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return[emailTest evaluateWithObject:email];
}

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
               returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
      }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
       if(!([other rangeOfString:string].location != NSNotFound))
          return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString
{
    if (inputString.length == 0) {
        return NO;
    }else{
        NSString *regex =@"[a-zA-Z0-9]*";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [pred evaluateWithObject:inputString];
    }
}
//是否是中文
+ (BOOL)isAvailableCN:(NSString *)string
{
    NSString *regEx = @".*[\u4e00-\u9fa5].*";
    NSRange range = [string rangeOfString:regEx options:NSRegularExpressionSearch];
    return range.length;
}

//判断邮箱
-(BOOL)isEmail {
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:self];
    
}

//判断昵称
- (BOOL)isTureUserName {
    NSString *regex = @"^[\u4E00-\u9FA5\uf900-\ufa2dA-Z0-9a-z]{1,10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
+ (BOOL)isNum:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}
@end

@implementation NSObject (Transition)

- (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
 
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
 
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
 
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
 
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
 
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
 
    return [dic copy];
}

//将可能存在model数组转化为普通数组
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
 
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
 
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
 
        return [array copy];
 
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
           //字典
           NSDictionary *originDic = (NSDictionary *)origin;
           NSMutableDictionary *dic = [NSMutableDictionary dictionary];
           for (NSString *key in originDic.allKeys) {
               id object = [originDic objectForKey:key];
    
               if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                   //string , bool, int ,NSinteger
                   [dic setObject:object forKey:key];
    
               } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                   //数组或字典
                   [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
    
               } else {
                   //model
                   [dic setObject:[self dicFromObject:object] forKey:key];
               }
           }
    
           return [dic copy];
       }
    
       return [NSNull null];
}

@end

