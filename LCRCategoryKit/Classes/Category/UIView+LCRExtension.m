//
//  UIView+LCRExtension.m
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import "UIView+LCRExtension.h"

@implementation UIView (LCRExtension)

- (void)viewDidLayout:(void (^)(void))layout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (layout != nil) {
            if (CGRectEqualToRect(self.frame, CGRectNull)) {
                NSLog(@"view did layout -> frame null");
                [self viewDidLayout:layout];
            } else if (CGRectEqualToRect(self.frame, CGRectZero)) {
                NSLog(@"view did layout -> frame zero");
                [self viewDidLayout:layout];
            } else {
                NSLog(@"view did layout -> frame (%lf, %lf, %lf, %lf))", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
                layout();
            }
        }
    });
}

- (void)addGradientLayer:(NSArray<UIColor *> *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *cgColors = [NSMutableArray array];
    [colors enumerateObjectsUsingBlock:^(UIColor *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [cgColors addObject:(__bridge id) obj.CGColor];
    }];
    gradientLayer.colors = [NSArray arrayWithArray:cgColors];
    gradientLayer.locations = locations;

    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;

    gradientLayer.frame = self.bounds;

    [self.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {

    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];

    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {

    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];

    self.layer.mask = shape;
}

/**
 圆角
 使用自动布局，需要在layoutsubviews 中使用
 @param radius 圆角尺寸
 @param corner 圆角位置
 */
- (void)radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
        self.layer.masksToBounds = YES;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)addShadowLayer:(UIColor *)color
                offset:(CGSize)offset
                radius:(CGFloat)radius
               opacity:(CGFloat)opacity{

    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}
@end
