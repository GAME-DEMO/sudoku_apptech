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

@interface SudokuFootView ()

@property (nonatomic, weak) IBOutlet UICollectionView *numberCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *colorCollectionView;

@property (nonatomic, strong) NumberCollectionViewCell *currentSelectedNumberCell;
@property (nonatomic, strong) ColorCollectionViewCell *currentSelectedColorCell;

@end


@implementation SudokuFootView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
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
    
    self.numberCollectionView.allowsMultipleSelection = YES;
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
        
    } else if (collectionView == self.colorCollectionView) {
        if (self.currentSelectedColorCell == cell) {
            BOOL selected = self.currentSelectedColorCell.selected;
            self.currentSelectedColorCell.selected = !selected;
        } else {
            self.currentSelectedColorCell.selected = NO;
            self.currentSelectedColorCell = (ColorCollectionViewCell *)cell;
            cell.selected = YES;
        }
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
