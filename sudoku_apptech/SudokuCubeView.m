//
//  SudokuCubeView.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuCubeView.h"

@interface SudokuCubeView ()

@property (nonatomic, strong) UIImageView *valueImageView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *guessImageViewArray;

@end


@implementation SudokuCubeView

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
    self.valueImageView = [[UIImageView alloc] init];
    self.valueImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.valueImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[valueImageView]-0-|" options:0 metrics:nil views:@{@"valueImageView":self.valueImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[valueImageView]-0-|" options:0 metrics:nil views:@{@"valueImageView":self.valueImageView}]];
}

@end
