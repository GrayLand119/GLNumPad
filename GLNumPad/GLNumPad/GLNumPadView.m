//
//  GLNumPadView.m
//  GLNumPad
//
//  Created by GrayLand on 16/1/7.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLNumPadView.h"
#import "UIImage+GLTint.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height


@interface GLNumPadView()

@end


@implementation GLNumPadView

- (instancetype)initWithEventBlock:(GLNumPadOnEventBlock)eventBlock
{
    if (self = [super init]) {
        
        _numPadSize = CGSizeMake(kScreenWidth, 170);
        
        _eventBlock = eventBlock;
        
        [self initializeView];
    }
    return self;
}

- (void)setNumPadSize:(CGSize)numPadSize
{
    _numPadSize = numPadSize;
    
    [self resetFrame];
}

- (void)initializeView
{
    [self resetFrame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
}

- (void)resetFrame
{
    self.frame = CGRectMake(0, kScreenHeight - _numPadSize.height, _numPadSize.width, _numPadSize.height);
    
    float boardWidth    = 0.5;
    UIColor *boardColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    // create number button
    float numBtnWidth  = _numPadSize.width / 4;
    float numBtnHeight = _numPadSize.height / 4;
    for (int i = 1; i <= 12; i++) {
        
        int iRow = ceil(i / 3.0);
        int iColumn = i % 3 == 0 ? 3 : i % 3;
        
        CGRect frame = CGRectMake((iColumn - 1) * numBtnWidth,
                                  (iRow - 1) * numBtnHeight,
                                  numBtnWidth,
                                  numBtnHeight);
        
        UIButton *numBtn = [[UIButton alloc] initWithFrame:frame];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        numBtn.layer.borderWidth = boardWidth;
        numBtn.layer.borderColor = boardColor.CGColor;
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn setTitleColor:[UIColor colorWithWhite:0.800 alpha:1.000] forState:UIControlStateHighlighted];
        
        numBtn.tag = i;
        if (i >=1 && i<=9) { // 1 ~ 9
            [numBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [numBtn addTarget:self action:@selector(onTapNum0To9:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 10){ // dot
            [numBtn setTitle:@"." forState:UIControlStateNormal];
            [numBtn addTarget:self action:@selector(onTapNum0To9:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 11){ // 0
            [numBtn setTitle:@"0" forState:UIControlStateNormal];
            [numBtn addTarget:self action:@selector(onTapNum0To9:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 12){ // Finish
            numBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [numBtn setImage:[UIImage imageNamed:@"expand_arrow"] forState:UIControlStateNormal];
            [numBtn setImage:[[UIImage imageNamed:@"expand_arrow"] imageWithTintColor:[UIColor colorWithWhite:0.702 alpha:1.000]]
                    forState:UIControlStateHighlighted];
            [numBtn addTarget:self action:@selector(onTapFinish:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:numBtn];
    }
    
    
    // create backspcace button
    {
        CGRect frame = CGRectMake(numBtnWidth * 3,
                                  0,
                                  numBtnWidth,
                                  numBtnHeight * 2);
        
        UIButton *numBtn = [[UIButton alloc] initWithFrame:frame];
        numBtn.tag                   = 13;
        numBtn.titleLabel.font       = [UIFont systemFontOfSize:22];
        numBtn.layer.borderWidth     = boardWidth;
        numBtn.layer.borderColor     = boardColor.CGColor;
        numBtn.imageEdgeInsets       = UIEdgeInsetsMake(25, 0, 25, 0);
        numBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [numBtn setImage:[UIImage imageNamed:@"delete_shield"] forState:UIControlStateNormal];
        [numBtn setImage:[[UIImage imageNamed:@"delete_shield"] imageWithTintColor:[UIColor colorWithWhite:0.702 alpha:1.000]]
                forState:UIControlStateHighlighted];
        [numBtn addTarget:self action:@selector(onTapBackspace:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
    
    // create done button
    {
        CGRect frame = CGRectMake(numBtnWidth * 3,
                                  numBtnHeight * 2,
                                  numBtnWidth,
                                  numBtnHeight * 2);
        
        UIButton *numBtn = [[UIButton alloc] initWithFrame:frame];
        numBtn.tag               = 14;
        numBtn.titleLabel.font   = [UIFont systemFontOfSize:22];
        numBtn.layer.borderWidth = 0.5;
        numBtn.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
        [numBtn setTitle:@"确定" forState:UIControlStateNormal];
        [numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [numBtn setTitleColor:[UIColor colorWithWhite:0.902 alpha:1.000] forState:UIControlStateHighlighted];
        [numBtn setBackgroundColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]];
        [numBtn addTarget:self action:@selector(onTapDone:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
}

- (void)onTapNum0To9:(UIButton *)button
{
    if (_eventBlock) {
        _eventBlock(GLNumPadEventOnNum, button.currentTitle);
    }
}

- (void)onTapDone:(UIButton *)button
{
    if (_eventBlock) {
        _eventBlock(GLNumPadEventOnDone, @"");
    }
}

- (void)onTapBackspace:(UIButton *)button
{
    if (_eventBlock) {
        _eventBlock(GLNumPadEventOnBackspace, @"");
    }
}

- (void)onTapFinish:(UIButton *)button
{
    if (_eventBlock) {
        _eventBlock(GLNumPadEventOnFinish, @"");
    }
}


#pragma mark -
#pragma mark other
+ (UIImage *)pureColoredImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}










@end
