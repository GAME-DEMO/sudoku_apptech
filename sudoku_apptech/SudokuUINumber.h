//
//  SudokuUINumber.h
//  sudoku_apptech
//
//  Created by Peng Wang on 3/27/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuUINumber : NSObject

+ (instancetype)numberWithNumber:(int)number withColor:(UIColor *)color;
+ (instancetype)numberWithNumber:(int)number;

@property (nonatomic, assign) int number;
@property (nonatomic, strong) UIColor *color;

@end
