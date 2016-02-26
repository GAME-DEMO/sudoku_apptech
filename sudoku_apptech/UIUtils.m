//
//  UIUtils.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/26/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "UIUtils.h"

static const int NumberShadowTag = 1000;
static const int NumberTag = 1001;

@implementation UIUtils

+ (void)updateNumber:(int)number withTintColor:(UIColor *)color onView:(UIView *)view cover:(CGFloat)coverPercentage {
    UIImageView *numberShadowImageView = [view viewWithTag:NumberShadowTag];
    if (numberShadowImageView == nil) {
        numberShadowImageView = [[UIImageView alloc] init];
        numberShadowImageView.translatesAutoresizingMaskIntoConstraints = NO;
        numberShadowImageView.contentMode = UIViewContentModeScaleAspectFit;
        numberShadowImageView.tag = NumberShadowTag;
        [view addSubview:numberShadowImageView];

        [view addConstraint:[NSLayoutConstraint constraintWithItem:numberShadowImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:numberShadowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:numberShadowImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:MIN(coverPercentage, 1.0) constant:0.0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:numberShadowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:MIN(coverPercentage, 1.0) constant:0.0]];
    }

    UIImageView *numberImageView = [numberShadowImageView viewWithTag:NumberTag];
    if (numberImageView == nil) {
        numberImageView = [[UIImageView alloc] init];
        numberImageView.translatesAutoresizingMaskIntoConstraints = NO;
        numberImageView.contentMode = UIViewContentModeScaleAspectFit;
        numberImageView.tag = NumberTag;
        [numberShadowImageView addSubview:numberImageView];

        [numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : numberImageView}]];
        [numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : numberImageView}]];
    }

    NSString *numberShadowImageName = [NSString stringWithFormat:@"b%d_shadow", number];
    numberShadowImageView.image = [UIImage imageNamed:numberShadowImageName];

    NSString *numberImageName = [NSString stringWithFormat:@"b%d", number];
    numberImageView.image = [[UIImage imageNamed:numberImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    numberImageView.tintColor = color ? : [UIColor whiteColor];
}

@end
