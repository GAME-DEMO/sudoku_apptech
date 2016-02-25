//
//  SudokuCubeView.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuCubeView.h"

@interface SudokuCubeView ()

@end


@implementation SudokuCubeView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

@end
