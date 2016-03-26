//
//  UINavigationBar+Extension.h
//  LTNavigationBar
//
//  Created by 四维图新 on 16/3/25.
//  Copyright © 2016年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extension)

/**
 *  设置导航条的背景颜色
 *
 *  @param color    目标颜色
 *  @param included 是否包含状态栏
 */
- (void)setBarBackgroundColor:(UIColor *)color starusBarIncluded:(BOOL)included;

/**
 *  设置导航条的背景色为透明色
 */
- (void)setBarBackgroundColorIsClearColor;

/**
 *  给导航条添加一个overlay，然后设置overlay的背景颜色
 */
- (void)setBarOverlayBackgroundColor:(UIColor *)color;

/**
 *  还原导航条的默认设置
 */
- (void)revertNavBar;


- (void)setNavBarTranslationY:(CGFloat)translationY;

- (void)setNavBarElementsAlpha:(CGFloat)alpha;

@end


