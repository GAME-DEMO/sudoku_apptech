//
//  Presenter.m
//  sudoku
//
//  Created by Peng Wang on 11/21/15.
//  Copyright © 2015 Peng Wang. All rights reserved.
//

#import "Presenter.h"
#import "Algorithm.h"
#import "ColorCollectionViewCell.h"
#import "NumberCollectionViewCell.h"
#import "SudokuCubeView.h"
#import "SudokuFootView.h"
#import "SudokuUINumber.h"

const NSInteger INVALID_COLOR_CELL_INDEX = -1;

@interface Presenter ()

@property (nonatomic, strong) NSArray<UIColor *> *contentNumberColorArray;
@property (nonatomic, strong) NSArray<UIColor *> *footColorButtonBasementColorArray;
@property (nonatomic, strong) NSArray<UIColor *> *footColorButtonHighlightColorArray;

@property (nonatomic, strong) NSArray<NSNumber *> *resultArray;
@property (nonatomic, strong) NSArray<NSNumber *> *sudokuArray;

@property (nonatomic, assign) NSInteger currentSelectedColorCellIndex;

@end

@implementation Presenter

+ (instancetype)sharedInstance {
    static Presenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Presenter alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
        _footColorButtonBasementColorArray = [NSArray arrayWithObjects:
                                              RGBA(255.0f, 95.0f, 95.0f, 1.0f),
                                              RGBA(34.0f, 231.0f, 214.0f, 1.0f),
                                              RGBA(215.0f, 229.0f, 96.0f, 1.0f),
                                              RGBA(90.0f, 209.0f, 71.0f, 1.0f),
                                              RGBA(191.0f, 103.0f, 62.0f, 1.0f),
                                              nil];
        _footColorButtonHighlightColorArray = [NSArray arrayWithObjects:
                                               RGBA(255.0f, 126.0f, 126.0f, 1.0f),
                                               RGBA(109.0f, 254.0f, 255.0f, 1.0f),
                                               RGBA(240.0f, 255.0f, 109.0f, 1.0f),
                                               RGBA(109.0f, 246.0f, 87.0f, 1.0f),
                                               RGBA(246.0f, 137.0f, 87.0f, 1.0f),
                                               nil];
        _currentSelectedColorCellIndex = INVALID_COLOR_CELL_INDEX;
    }
    return self;
}

- (int)eachCount {
    return GetEachCount();
}

- (int)dimension {
    return GetDimension();
}

- (int)groupsCount {
    return GetGroupsCount();
}

- (int)cubesCountForDimension {
    return GetCubesCountForDimension();
}

- (int)cubesCountForAll {
    return GetCubesCountForAll();
}

- (int)globalRowFromGlobalIndex:(int)globalIndex {
    return globalIndex / self.dimension;
}

- (int)globalColFromGlobalIndex:(int)globalIndex {
    return globalIndex % self.dimension;
}

- (int)groupIndexFromCubeGlobalIndex:(int)globalIndex {
    int row = [self globalRowFromGlobalIndex:globalIndex];
    int col = [self globalColFromGlobalIndex:globalIndex];
    
    return (row / self.eachCount) * self.eachCount + col / self.eachCount;
}

- (int)globalIndexFromGlobalRow:(int)globalRow withGlobalCol:(int)globalCol {
    return globalRow * self.dimension + globalCol;
}

- (int)localIndexFromLocalRow:(int)localRow withLocalCol:(int)localCol {
    return localRow * self.eachCount + localCol;
}

- (void)randomResult {
    std::vector<int> cubeValues = RandomResult();
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:GetCubesCountForAll()];
    for (int i = 0; i < cubeValues.size(); ++i) {
        [results addObject:@(cubeValues[i])];
    }
    self.resultArray = [NSArray arrayWithArray:results];
}

- (void)randomResultForLevel:(DIFFICULT_LEVEL)level {
    [self randomResult];
    
    int resultsCount = 0;
    NSMutableArray *cubeValueArray = [[NSMutableArray alloc] initWithArray:self.resultArray copyItems:YES];
    std::vector<int> cubeValues;
    int emptyCellsCount = 0;
    
    do {
        cubeValues.clear();
        for (int i = 0; i < cubeValueArray.count; ++i) {
            cubeValues.push_back([[cubeValueArray objectAtIndex:i] intValue]);
        }
        
        emptyCellsCount = 40;
        
        switch (level) {
            case DIFFICULT_LEVEL_EASY: {
                emptyCellsCount += arc4random() % 6 + 0;
                break;
            }
                
            case DIFFICULT_LEVEL_MID: {
                emptyCellsCount += arc4random() % 4 + 6;
                break;
            }
                
            case DIFFICULT_LEVEL_HARD: {
                emptyCellsCount += arc4random() % 4 + 10;
                break;
            }
                
            case DIFFICULT_LEVEL_EXTRE_HARD: {
                emptyCellsCount += arc4random() % 5 + 14;
                break;
            }
                
            case DIFFICULT_LEVEL_NONE:
            default:
                break;
        }
        
        NSMutableArray *emptyCellIndexArray = [NSMutableArray arrayWithCapacity:emptyCellsCount];
        while (emptyCellsCount > 0) {
            int emptyCellIndex = arc4random() % 81;
            if ([emptyCellIndexArray indexOfObject:@(emptyCellIndex)] == NSNotFound &&
                cubeValues[emptyCellIndex] != 0) {
                [emptyCellIndexArray addObject:@(emptyCellIndex)];
                cubeValues[emptyCellIndex] = 0;
                emptyCellsCount--;
            }
        }
        
        resultsCount = ResultsCount(&cubeValues, YES);
    } while (resultsCount != 1);
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:cubeValues.size()];
    for (int i = 0; i < cubeValues.size(); ++i) {
        [results addObject:(@(cubeValues[i]))];
    }
    self.sudokuArray = [NSArray arrayWithArray:results];
}

#pragma mark - Helper functions

- (UIColor *)randomColor {
    static const CGFloat alphaBase = 10;
    CGFloat alpha = arc4random() % (int)alphaBase;
    return RGBA(arc4random() % 255, arc4random() % 255, arc4random() % 255, alpha / alphaBase);
}

- (BOOL)isDemensionLevelNine {
    return self.dimension == DIMENSION_LEVEL_NINE;
}

- (BOOL)isInDemension:(int)number {
    return 0 < number && number <= self.dimension;
}

#pragma mark - UI related

+ (UIInterfaceOrientation) appOrientation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

+ (BOOL)isPortrait {
    UIInterfaceOrientation orientation = [self appOrientation];
    return orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown;
}

+ (BOOL)isLandscape {
    UIInterfaceOrientation orientation = [self appOrientation];
    return orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight;
}

+ (BOOL)isPortraitForSize:(CGSize)size {
    return size.width <= size.height;
}

+ (BOOL)isLandscapeForSize:(CGSize)size {
    return size.width > size.height;
}

- (void)setCurrentSelectedCubeView:(SudokuCubeView *)currentSelectedCubeView {
    _currentSelectedCubeView = currentSelectedCubeView;
    [self.footView.numberCollectionView reloadData];
}

- (void)colorCollectionCellDidClick:(ColorCollectionViewCell *)colorCell {
    if (self.currentSelectedColorCellIndex == colorCell.colorIndex) {
        BOOL selected = !colorCell.selected;
        colorCell.selected = selected;
        if (!selected) {
            self.currentSelectedColorCellIndex = INVALID_COLOR_CELL_INDEX;
        }
    } else {
        if (self.currentSelectedColorCellIndex != INVALID_COLOR_CELL_INDEX) {
            for (ColorCollectionViewCell *cell in self.footView.colorCollectionView.visibleCells) {
                if (cell.colorIndex == self.currentSelectedColorCellIndex) {
                    cell.selected = NO;
                    break;
                }
            }
        }

        self.currentSelectedColorCellIndex = colorCell.colorIndex;
        colorCell.selected = YES;
    }
    [self.footView.numberCollectionView reloadData];
}

- (void)numberCollectionCellDidClick:(NumberCollectionViewCell *)numberCell {
    if (numberCell.isAltKey) {
        numberCell.selected = !numberCell.selected;
        self.currentSelectedCubeView.guessMode = numberCell.selected;
        [self.footView.numberCollectionView reloadData];
    } else {
        numberCell.selected = !numberCell.selected;
        if (!self.currentSelectedCubeView.guessMode) {
            if (numberCell.selected) {
                self.currentSelectedCubeView.cubeValue = [SudokuUINumber numberWithNumber:numberCell.number];
            } else {
                self.currentSelectedCubeView.cubeValue = nil;
            }
        } else {
            if (numberCell.selected) {
                [self.currentSelectedCubeView setGuess:[SudokuUINumber numberWithNumber:numberCell.number]];
            } else {
                [self.currentSelectedCubeView removeGuessValue:numberCell.number];
            }
        }
        [self.footView.numberCollectionView reloadData];
    }
}

- (UIColor *)currentSelectedColor {
    return self.currentSelectedColorCellIndex != INVALID_COLOR_CELL_INDEX ?
    self.footColorButtonBasementColorArray[self.currentSelectedColorCellIndex] :
    [ColorCollectionViewCell defaultSelectedColor];
}

@end
