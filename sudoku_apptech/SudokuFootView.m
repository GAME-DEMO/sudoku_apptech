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
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([Presenter sharedInstance].isDemensionLevelNine) {
        if (collectionView == self.numberCollectionView) {
            CenterFlowLayout *layout = (CenterFlowLayout *)collectionView.collectionViewLayout;
            CGFloat itemWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right - 4 * layout.minimumInteritemSpacing - 1.0f) / 5.0f;
            CGFloat itemHeight = (collectionView.frame.size.height - layout.sectionInset.top - layout.sectionInset.bottom - 1 * layout.minimumLineSpacing - 1.0f) / 2.0f;
            return CGSizeMake(itemWidth, itemHeight);
        } else if (collectionView == self.colorCollectionView) {
            CenterFlowLayout *layout = (CenterFlowLayout *)collectionView.collectionViewLayout;
            CGFloat itemWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right - 3.0f * layout.minimumInteritemSpacing - 1.0f) / 5.0f;
            CGFloat itemHeight = (collectionView.frame.size.height - layout.sectionInset.top - layout.sectionInset.bottom - 1.0f);
            return CGSizeMake(itemWidth, itemHeight);
        }
    }

    return CGSizeZero;
}

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
    UICollectionViewCell *cell = nil;
    if (collectionView == self.numberCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NumberCollectionViewCellIdentifier forIndexPath:indexPath];
        NumberCollectionViewCell* numCell = (NumberCollectionViewCell *)cell;
        numCell.number = (int)indexPath.item + 1;
        
    } else if (collectionView == self.colorCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ColorCollectionViewCellIdentifier forIndexPath:indexPath];
    }


    return cell;
}

@end
