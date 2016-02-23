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

@interface SudokuFootView ()

@property (nonatomic, weak) IBOutlet UICollectionView *numberCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *colorCollectionView;

@end


@implementation SudokuFootView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)viewDidLoad {
    CenterFlowLayout *centerLayout = (CenterFlowLayout *)self.numberCollectionView.collectionViewLayout;
    centerLayout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
//    centerLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.numberCollectionView) {
        return CGSizeMake(64, 64);
    } else if (collectionView == self.colorCollectionView) {
        return CGSizeMake(50, 50);
    }
    return CGSizeZero;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    if (collectionView == self.numberCollectionView) {
//        
//    } else if (collectionView == self.colorCollectionView) {
//        
//    }
//    return 0.0f;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (collectionView == self.numberCollectionView) {
//        
//    } else if (collectionView == self.colorCollectionView) {
//        
//    }
//    return 0.0f;
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.numberCollectionView) {
        return 10;
    } else if (collectionView == self.colorCollectionView) {
        return 3;
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    if (collectionView == self.numberCollectionView) {
        identifier = NumberCollectionViewCellIdentifier;
    } else if (collectionView == self.colorCollectionView) {
        identifier = ColorCollectionViewCellIdentifier;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    // Configure the cell

    return cell;
}

@end
