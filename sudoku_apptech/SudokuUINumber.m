//
//  SudokuUINumber.m
//  sudoku_apptech
//
//  Created by Peng Wang on 3/27/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuUINumber.h"
#import "Presenter.h"

@implementation SudokuUINumber

+ (instancetype)numberWithNumber:(int)number withColor:(UIColor *)color {
    return [[SudokuUINumber alloc] initWithNumber:number withColor:color];
}

+ (instancetype)numberWithNumber:(int)number {
    return [[SudokuUINumber alloc] initWithNumber:number];
}

- (instancetype)initWithNumber:(int)number withColor:(UIColor *)color {
    if (self = [super init]) {
        self.number = number;
        self.color = color;
    }
    return self;
}

- (instancetype)initWithNumber:(int)number {
    if (self = [super init]) {
        self.number = number;
        self.color = [Presenter sharedInstance].currentSelectedColor;
    }
    return self;
}

@end
