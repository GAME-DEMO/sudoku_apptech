//
//  SudokuCubeView.h
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SudokuUINumber;

@interface SudokuCubeView : UIView

@property (nonatomic, assign) BOOL showGuess;

@property (nonatomic, assign) int cubeValue;
@property (nonatomic, readonly) NSMutableArray *cubeGuessArray;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL guessMode;

- (void)setCubeValue:(int)cubeValue withValueColor:(UIColor *)valueColor;

@end
