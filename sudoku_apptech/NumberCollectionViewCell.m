//
//  NumberCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "NumberCollectionViewCell.h"

NSString * const NumberCollectionViewCellIdentifier = @"number_collection_view_cell_identifier";

@interface NumberCollectionViewCell ()

@end

@implementation NumberCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
