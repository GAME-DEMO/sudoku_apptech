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

@property (nonatomic, strong) UIButton *numberButton;

@end

@implementation NumberCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.numberButton = [[UIButton alloc] init];
    self.numberButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.numberButton];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    widthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:widthConstraint];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:heightConstraint];

    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    self.numberButton.backgroundColor = [UIColor greenColor];
}

@end
