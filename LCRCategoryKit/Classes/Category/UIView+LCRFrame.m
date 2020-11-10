//
//  UIView+LCRFrame.m
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

#import "UIView+LCRFrame.h"

@implementation UIView (LCRFrame)

- (void)setLcr_x:(CGFloat)lcr_x{
    
    CGRect frame = self.frame;
    
    frame.origin.x = lcr_x;
    
    self.frame = frame;
}

- (CGFloat)lcr_x {
    
    return self.frame.origin.x;
}


- (void)setLcr_y:(CGFloat)lcr_y {
    
    CGRect frame = self.frame;
    
    frame.origin.y = lcr_y;
    
    self.frame = frame;
}

- (CGFloat)lcr_y {
    
    return self.frame.origin.y;
}


- (void)setLcr_centerX:(CGFloat)lcr_centerX {
    
    CGPoint center = self.center;
    
    center.x = lcr_centerX;
    
    self.center = center;
}

- (CGFloat)lcr_centerX {
    
    return self.center.x;
}


- (void)setLcr_centerY:(CGFloat)lcr_centerY {
    
    CGPoint center = self.center;
    
    center.y = lcr_centerY;
    
    self.center = center;
}

- (CGFloat)lcr_centerY {
    
    return self.center.y;
}


- (void)setLcr_origin:(CGPoint)lcr_origin {
    
    CGRect frame = self.frame;
    
    frame.origin = lcr_origin;
    
    self.frame = frame;
}

- (CGPoint)lcr_origin {
    
    return self.frame.origin;
}


- (void)setLcr_size:(CGSize)lcr_size{
    
    CGRect frame = self.frame;
    
    frame.size = lcr_size;
    
    self.frame = frame;
}

- (CGSize)lcr_size {
    
    return self.frame.size;
}


- (void)setLcr_width:(CGFloat)lcr_width {
    
    CGRect frame = self.frame;
    
    frame.size.width = lcr_width;
    
    self.frame = frame;
}

- (CGFloat)lcr_width {
    
    return self.frame.size.width;
}


- (void)setLcr_height:(CGFloat)lcr_height {
    
    CGRect frame = self.frame;
    
    frame.size.height = lcr_height;
    
    self.frame = frame;
}

- (CGFloat)lcr_height {
    
    return self.frame.size.height;
}
@end
