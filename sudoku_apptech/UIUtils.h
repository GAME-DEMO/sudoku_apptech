//
//  UIUtils.h
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/26/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SudokuUINumber;

@interface UIUtils : NSObject

+ (void)updateValue:(SudokuUINumber *)value onValueView:(UIView *)valueView;
+ (void)removeValueOnValueView:(UIView *)valueView;

@end
