//
//  SudokuFootView.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuFootView.h"
#import "NumberCollectionViewCell.h"
#import "ColorCollectionViewCell.h"
#import "CenterFlowLayout.h"
#import "Presenter.h"
#import "SudokuCubeView.h"

@interface SudokuFootView ()

@property (nonatomic, weak) IBOutlet UICollectionView *numberCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *colorCollectionView;

@property (nonatomic, strong) NumberCollectionViewCell *currentSelectedNumberCell; // Use for sudoku cube view is not in guess mode.

@end


@implementation SudokuFootView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [Presenter sharedInstance].footView = self;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:CurrentSelectedCubeViewChangedNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self.numberCollectionView reloadData];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:CurrentSelectedCubeViewGuessModeChangedNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self.numberCollectionView reloadData];
        }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    CenterFlowLayout *centerLayout = (CenterFlowLayout *)self.numberCollectionView.collectionViewLayout;
    centerLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    centerLayout.minimumLineSpacing = 8.0f;
    centerLayout.minimumInteritemSpacing = 8.0f;

    centerLayout = (CenterFlowLayout *)self.colorCollectionView.collectionViewLayout;
    centerLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    centerLayout.minimumLineSpacing = 8.0f;
    centerLayout.minimumInteritemSpacing = 8.0f;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([Presenter sharedInstance].isDemensionLevelNine) {
        if (collectionView == self.numberCollectionView) {
            CenterFlowLayout *layout = (CenterFlowLayout *)collectionView.collectionViewLayout;
            CGFloat itemWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right - 4.0f * layout.minimumInteritemSpacing - 1.0f) / 5.0f;
            CGFloat itemHeight = (collectionView.frame.size.height - layout.sectionInset.top - layout.sectionInset.bottom - 1.0f * layout.minimumLineSpacing - 1.0f) / 2.0f;
            return CGSizeMake(itemWidth, itemHeight);
        } else if (collectionView == self.colorCollectionView) {
            CenterFlowLayout *layout = (CenterFlowLayout *)collectionView.collectionViewLayout;
            CGFloat itemWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right - 4.0f * layout.minimumInteritemSpacing - 1.0f) / 5.0f;
            CGFloat itemHeight = (collectionView.frame.size.height - layout.sectionInset.top - layout.sectionInset.bottom - 1.0f);
            return CGSizeMake(itemWidth, itemHeight);
        }
    }

    return CGSizeZero;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (collectionView == self.numberCollectionView) {
        NumberCollectionViewCell *numberCell = (NumberCollectionViewCell *)cell;
        if (numberCell.isAltKey) {
            [numberCell setSelected:![Presenter sharedInstance].currentSelectedCubeView.guessMode manual:YES];
        } else {
            
        }
        return NO;
    } else if (collectionView == self.colorCollectionView) {
        ColorCollectionViewCell *colorCell = (ColorCollectionViewCell *)cell;
        [[Presenter sharedInstance] colorCollectionCellDidClick:colorCell];
        return NO;
    }
    
    return YES;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.numberCollectionView) {
        return 10;
    } else if (collectionView == self.colorCollectionView) {
        return 5;
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (collectionView == self.numberCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NumberCollectionViewCellIdentifier forIndexPath:indexPath];
        NumberCollectionViewCell* numCell = (NumberCollectionViewCell *)cell;
        numCell.number = (int)indexPath.item + 1;
        numCell.numberColor = [Presenter sharedInstance].currentSelectedColorCell != nil ? [Presenter sharedInstance].currentSelectedColorCell.colorContentColor : [ColorCollectionViewCell defaultSelectedColor];
        [numCell reload];
    } else if (collectionView == self.colorCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ColorCollectionViewCellIdentifier forIndexPath:indexPath];
        ColorCollectionViewCell *colorCell = (ColorCollectionViewCell *)cell;
        colorCell.colorBackgroundColor = [Presenter sharedInstance].footColorButtonBasementColorArray[indexPath.item];
        colorCell.colorContentColor = colorCell.colorBackgroundColor;
        colorCell.colorContentHighlightColor = [Presenter sharedInstance].footColorButtonHighlightColorArray[indexPath.item];
    }

    return cell;
}

@end
