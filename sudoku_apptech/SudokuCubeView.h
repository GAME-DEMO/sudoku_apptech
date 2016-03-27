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

@property (nonatomic, strong) SudokuUINumber *cubeValue;
@property (nonatomic, readonly) NSMutableArray *cubeGuessArray;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL guessMode;

- (void)setGuess:(SudokuUINumber *)guess;
- (void)removeGuessValue:(int)guessValue;

@end
