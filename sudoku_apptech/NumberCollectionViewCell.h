//
//  NumberCollectionViewCell.h
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const NumberCollectionViewCellIdentifier;
extern NSString * const NumberCollectionViewCellSelectionChanged;
extern NSString * const NumberCollectionViewCellSelectionChangedKeyCell;

@interface NumberCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) int number;
@property (nonatomic, strong) UIColor *numberColor;
@property (nonatomic, readonly) BOOL isAltKey;

- (void)setSelected:(BOOL)selected manual:(BOOL)manual;

@end
