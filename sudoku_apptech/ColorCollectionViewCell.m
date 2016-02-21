//
//  ColorCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "ColorCollectionViewCell.h"

NSString * const ColorCollectionViewCellIdentifier = @"color_collection_view_cell_identifier";

@interface ColorCollectionViewCell ()

@end

@implementation ColorCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

@end
