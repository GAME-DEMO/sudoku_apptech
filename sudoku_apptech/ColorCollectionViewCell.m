//
//  ColorCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "ColorCollectionViewCell.h"
#import "Presenter.h"

NSString * const ColorCollectionViewCellIdentifier = @"color_collection_view_cell_identifier";
NSString * const ColorCollectionViewCellSelectionChanged = @"ColorCollectionViewCellSelectionChanged";
NSString * const ColorCollectionViewCellSelectionChangedKeyCell = @"ColorCollectionViewCellSelectionChangedKeyCell";

@interface ColorCollectionViewCell ()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *colorBackgroundImageView;
@property (nonatomic, strong) UIImageView *colorContentImageView;

@end

@implementation ColorCollectionViewCell

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
    self.colorView = [[UIView alloc] init];
    self.colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.colorView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    widthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:widthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:heightConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    [self.colorView addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.colorView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    self.colorView.backgroundColor = [UIColor clearColor];
    self.colorBackgroundImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"color_button_template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    self.colorBackgroundImageView.tintColor = [Presenter sharedInstance].randomColor;
    self.colorBackgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.colorView addSubview:self.colorBackgroundImageView];

    [self.colorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[colorBackgroundImageView]-0-|" options:0 metrics:nil views:@{@"colorBackgroundImageView" : self.colorBackgroundImageView}]];
    [self.colorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[colorBackgroundImageView]-0-|" options:0 metrics:nil views:@{@"colorBackgroundImageView" : self.colorBackgroundImageView}]];

    self.colorContentImageView = [[UIImageView alloc] init];
    self.colorContentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.colorBackgroundImageView addSubview:self.colorContentImageView];
    self.colorContentImageView.backgroundColor = self.colorContentColor;
    [self.colorBackgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0,==2@750)-[colorContentImageView]-(>=0,==2@750)-|" options:0 metrics:nil views:@{@"colorContentImageView" : self.colorContentImageView}]];
    [self.colorBackgroundImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0,==2@750)-[colorContentImageView]-(>=0,==2@750)-|" options:0 metrics:nil views:@{@"colorContentImageView" : self.colorContentImageView}]];
}

- (void)setColorBackgroundColor:(UIColor *)colorBackgroundColor {
    _colorBackgroundColor = colorBackgroundColor;
    self.colorBackgroundImageView.tintColor = colorBackgroundColor;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.colorContentImageView.backgroundColor = selected ? self.colorContentHighlightColor : self.colorContentColor;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ColorCollectionViewCellSelectionChanged object:self userInfo:@{ColorCollectionViewCellSelectionChangedKeyCell : self}];
}


@end
