//
//  GLNumPadView.h
//  GLNumPad
//
//  Created by GrayLand on 16/1/7.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, GLNumPadEvent) {
    GLNumPadEventOnNum, // 点击数字
    GLNumPadEventOnDone, // 点击完成
    GLNumPadEventOnFinish, // 点击空白处和收起键盘按钮
    GLNumPadEventOnBackspace // 点击删除
};

typedef void (^GLNumPadOnEventBlock)(GLNumPadEvent event, NSString *inputString);

@interface GLNumPadView : UIView

@property (nonatomic, assign) CGSize numPadSize;

@property (nonatomic, copy) GLNumPadOnEventBlock eventBlock;

/**
 *  根据颜色创建Image
 *
 *  @param color
 *  @param size
 *
 *  @return
 */
+ (UIImage *)pureColoredImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  初始化
 *
 *  @param eventBlock block代替delegate
 *
 *  @return
 */
- (instancetype)initWithEventBlock:(GLNumPadOnEventBlock)eventBlock;

@end
