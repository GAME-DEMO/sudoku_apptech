//
//  SudokuFootView.h
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCollectionViewCell.h"
#import "ColorCollectionViewCell.h"

@protocol SudokuFootViewDelegate;

@interface SudokuFootView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)viewDidLoad;

@property (nonatomic, weak) id<SudokuFootViewDelegate> delegate;
@property (nonatomic, assign) BOOL guessMode;

@end


@protocol SudokuFootViewDelegate <NSObject>

- (void)numberCellDidSelect:(NumberCollectionViewCell *)numberCell;
- (void)numberCellDidDeselect:(NumberCollectionViewCell *)numberCell;
- (void)colorCellDidSelect:(ColorCollectionViewCell *)colorCell;
- (void)colorCellDidDeselect:(ColorCollectionViewCell *)colorCell;

@end