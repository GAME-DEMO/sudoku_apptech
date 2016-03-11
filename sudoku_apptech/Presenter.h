//
//  Presenter.h
//  sudoku
//
//  Created by Peng Wang on 11/21/15.
//  Copyright © 2015 Peng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SudokuCubeView;

typedef NS_ENUM(NSUInteger, DIFFICULT_LEVEL) {
    DIFFICULT_LEVEL_NONE,
    DIFFICULT_LEVEL_EASY,           // 40 ~ 45 Empty Cells
    DIFFICULT_LEVEL_MID,            // 46 ~ 49 Empty Cells
    DIFFICULT_LEVEL_HARD,           // 50 ~ 53 Empty Cells
    DIFFICULT_LEVEL_EXTRE_HARD,     // 54 ~ 58 Empty Cells
};

typedef NS_ENUM(NSUInteger, DIMENSION_LEVEL) {
    DIMENSION_LEVEL_NINE = 9,
};

@interface Presenter : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) int eachCount;
@property (nonatomic, readonly) int dimension;
@property (nonatomic, readonly) int groupsCount;
@property (nonatomic, readonly) int cubesCountForDimension;
@property (nonatomic, readonly) int cubesCountForAll;
@property (nonatomic, readonly) NSArray<UIColor *> *contentNumberColorArray;
@property (nonatomic, readonly) NSArray<UIColor *> *footColorButtonBasementColorArray;
@property (nonatomic, readonly) NSArray<UIColor *> *footColorButtonHighlightColorArray;

@property (nonatomic, readonly) NSArray<NSNumber *> *resultArray;
@property (nonatomic, readonly) NSArray<NSNumber *> *sudokuArray;

@property (nonatomic, strong) SudokuCubeView *currentSelectedCubeView;

- (int)globalRowFromGlobalIndex:(int)globalIndex;
- (int)globalColFromGlobalIndex:(int)globalIndex;
- (int)groupIndexFromCubeGlobalIndex:(int)globalIndex;
- (int)globalIndexFromGlobalRow:(int)globalRow withGlobalCol:(int)globalCol;

- (int)localIndexFromLocalRow:(int)localRow withLocalCol:(int)localCol;

- (void)randomResultForLevel:(DIFFICULT_LEVEL)level;
- (UIColor *)randomColor;

- (BOOL)isDemensionLevelNine;

#pragma mark - UI related

+ (BOOL)isPortrait;
+ (BOOL)isLandscape;

+ (BOOL)isPortraitForSize:(CGSize)size;
+ (BOOL)isLandscapeForSize:(CGSize)size;

@end
