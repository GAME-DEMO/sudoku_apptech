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

@property (nonatomic, weak, readonly) UICollectionView *numberCollectionView;
@property (nonatomic, weak, readonly) UICollectionView *colorCollectionView;

- (void)viewDidLoad;

@end
