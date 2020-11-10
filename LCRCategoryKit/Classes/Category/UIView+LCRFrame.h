//
//  UIView+LCRFrame.h
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LCRFrame)

/** X坐标 */
@property(nonatomic, assign)CGFloat lcr_x;

/** Y坐标 */
@property(nonatomic, assign)CGFloat lcr_y;

/** x中心点 */
@property(nonatomic, assign)CGFloat lcr_centerX;

/** y中心点 */
@property(nonatomic, assign)CGFloat lcr_centerY;

/** 坐标 */
@property(nonatomic, assign)CGPoint lcr_origin;

/** 宽度 */
@property(nonatomic, assign)CGFloat lcr_width;

/** 高度 */
@property(nonatomic, assign)CGFloat lcr_height;

/** 尺寸 */
@property(nonatomic, assign)CGSize lcr_size;

@end

NS_ASSUME_NONNULL_END
