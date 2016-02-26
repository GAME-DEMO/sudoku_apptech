//
//  SudokuCubeView.h
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuCubeView : UIView

@property (nonatomic, assign) BOOL showGuess;

@property (nonatomic, assign) int cubeValue;
@property (nonatomic, readonly) NSMutableArray *cubeGuessArray;

@end
