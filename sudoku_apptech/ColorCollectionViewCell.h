//
//  ColorCollectionViewCell.h
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ColorCollectionViewCellIdentifier;

@interface ColorCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *colorBackgroundColor;
@property (nonatomic, strong) UIColor *colorContentColor;
@property (nonatomic, strong) UIColor *colorContentHighlightColor;

@end
