//
//  UINavigationBar+Extension.m
//  LTNavigationBar
//
//  Created by 四维图新 on 16/3/25.
//  Copyright © 2016年 ltebean. All rights reserved.
//

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Extension)
static char overlayKey;

- (void)setBarBackgroundColor:(UIColor *)color starusBarIncluded:(BOOL)included
{
    if (included)
    {
        self.barTintColor = color;
    }
    else
    {
        [self setBackgroundImage:[self imageWithColor:color]
                  forBarPosition:0 barMetrics:UIBarMetricsCompactPrompt];
        
        self.backgroundColor = color;
    }
}

- (void)setBarBackgroundColorIsClearColor
{
    UIImage *bgImage = [self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    [self setBackgroundImage:bgImage
              forBarPosition:UIBarPositionAny
                  barMetrics:UIBarMetricsDefault];
    
    [self setShadowImage:[UIImage new]];
}

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBarOverlayBackgroundColor:(UIColor *)color
{
    if (!self.overlay)
    {
        self.overlay = [[UIView alloc] init];
        
        self.overlay.frame = CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20);
        
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self insertSubview:self.overlay atIndex:0];
        
        [self setBackgroundImage:[UIImage new]
                  forBarPosition:0 barMetrics:0];
        
        [self setShadowImage:[UIImage new]];
    }
    
    self.overlay.backgroundColor = color;
}

- (void)revertNavBar
{
    [self setBackgroundImage:nil forBarPosition:0 barMetrics:0];
    
    [self setShadowImage:nil];
    
    [self.overlay removeFromSuperview];
    
    self.overlay = nil;
}

- (void)setNavBarTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setNavBarElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop)
     {
         view.alpha = alpha;
     }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop)
     {
         view.alpha = alpha;
     }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    
    titleView.alpha = alpha;
    
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")])
         {
             obj.alpha = alpha;
             
             *stop = YES;
         }
     }];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
