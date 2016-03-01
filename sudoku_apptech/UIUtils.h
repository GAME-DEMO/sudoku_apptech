//
//  UIUtils.h
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/26/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

+ (void)updateCubeValue:(int)number withTintColor:(UIColor *)color onCubeValueView:(UIView *)cubeValueView;
+ (void)removeCubeValueOnCubeValueView:(UIView *)cubeValueView;

@end
