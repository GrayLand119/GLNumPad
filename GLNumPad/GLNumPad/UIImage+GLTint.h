//
//  UIImage+GLTint.h
//  QTime
//
//  Created by GrayLand on 16/1/6.
//  Copyright © 2016年 Mark. All rights reserved.
//


//*******************************************************************************
// 改变Image的颜色 
//*******************************************************************************

#import <UIKit/UIKit.h>

@interface UIImage (GLTint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
