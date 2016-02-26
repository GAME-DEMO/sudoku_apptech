//
//  SudokuContentView.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuContentView.h"
#import "Presenter.h"
#import "SudokuCubeView.h"

@interface SudokuContentView ()

@property (nonatomic, strong) NSMutableArray<SudokuCubeView *> *cubeViewArray;

@end


@implementation SudokuContentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _cubeViewArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].cubesCountForAll];
    }
    return self;
}

- (void)viewDidLoad {
    if ([Presenter sharedInstance].isDemensionLevelNine) {
        UIView *lastLineView = nil;
        UIView *lastPlaceHolderView = nil;
        for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
            UIView *placeHolderView = [[UIView alloc] init];
            placeHolderView.translatesAutoresizingMaskIntoConstraints = NO;
            placeHolderView.backgroundColor = [UIColor clearColor];
            [self addSubview:placeHolderView];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView)]];
            
            UIView *lineView = nil;
            if (i != [Presenter sharedInstance].dimension - 1) {
                lineView = [[UIView alloc] init];
                lineView.translatesAutoresizingMaskIntoConstraints = NO;
                lineView.backgroundColor = RGBA(22.0, 27.0, 36.0, 1.0);
                [self addSubview:lineView];
                
                CGFloat lineWidth = i % 3 == 2 ? 2 * LINE_WIDTH : LINE_WIDTH;
                [lineView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lineWidth]];
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[lineView]-0-|" options:0 metrics:nil views:@{@"lineView" : lineView}]];
            }
            
            if (lastLineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView, lineView)]];
            } else if (lineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastLineView]-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView)]];
            } else {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastLineView]-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView, lineView)]];
            }
            
            if (lastPlaceHolderView != nil) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:placeHolderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lastPlaceHolderView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
            }
            
            lastLineView = lineView;
            lastPlaceHolderView = placeHolderView;
        }
        
        lastLineView = nil;
        lastPlaceHolderView = nil;
        for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
            UIView *placeHolderView = [[UIView alloc] init];
            placeHolderView.translatesAutoresizingMaskIntoConstraints = NO;
            placeHolderView.backgroundColor = [UIColor clearColor];
            [self addSubview:placeHolderView];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView)]];
            
            UIView *lineView = nil;
            if (i != [Presenter sharedInstance].dimension - 1) {
                lineView = [[UIView alloc] init];
                lineView.translatesAutoresizingMaskIntoConstraints = NO;
                lineView.backgroundColor = RGBA(22.0, 27.0, 36.0, 1.0);
                [self addSubview:lineView];
                
                CGFloat lineWidth = i % 3 == 2 ? 2 * LINE_WIDTH : LINE_WIDTH;
                [lineView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lineWidth]];
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView]-0-|" options:0 metrics:nil views:@{@"lineView" : lineView}]];
            }
            
            if (lastLineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView, lineView)]];
            } else if (lineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLineView]-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView)]];
            } else {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLineView]-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView, lineView)]];
            }
            
            if (lastPlaceHolderView != nil) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:placeHolderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:lastPlaceHolderView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
            }
            
            lastLineView = lineView;
            lastPlaceHolderView = placeHolderView;
        }
        
        for (int i = 0; i < [Presenter sharedInstance].cubesCountForAll; ++i) {
            SudokuCubeView *cubeView = [[SudokuCubeView alloc] init];
            cubeView.translatesAutoresizingMaskIntoConstraints = NO;
            cubeView.backgroundColor = [UIColor clearColor];
            [self addSubview:cubeView];
            [self.cubeViewArray addObject:cubeView];
        }
        
        for (int row = 0; row < [Presenter sharedInstance].dimension; ++row) {
            for (int col = 0; col < [Presenter sharedInstance].dimension; ++col) {
                SudokuCubeView *curCubeView = [self.cubeViewArray objectAtIndex:[[Presenter sharedInstance] globalIndexFromGlobalRow:row withGlobalCol:col]];
                
                // Leading
                if (col == 0) {
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
                } else {
                    SudokuCubeView *leadingCubeView = [self.cubeViewArray objectAtIndex:[[Presenter sharedInstance] globalIndexFromGlobalRow:row withGlobalCol:col - 1]];
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:leadingCubeView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
                }
                
                // Trailing
                if (col == [Presenter sharedInstance].dimension - 1) {
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
                }
                
                // Width
                if (col > 0) {
                    SudokuCubeView *previousCubeView = [self.cubeViewArray objectAtIndex:[[Presenter sharedInstance] globalIndexFromGlobalRow:row withGlobalCol:col - 1]];
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:previousCubeView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
                }
                
                // Bottom
                if (row == 0) {
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
                } else {
                    SudokuCubeView *bottomCubeView = [self.cubeViewArray objectAtIndex:[[Presenter sharedInstance] globalIndexFromGlobalRow:row - 1 withGlobalCol:col]];
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomCubeView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
                }
                
                // Top
                if (row == [Presenter sharedInstance].dimension - 1) {
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
                }
                
                // Height
                if (row > 0) {
                    SudokuCubeView *previousCubeView = [self.cubeViewArray objectAtIndex:[[Presenter sharedInstance] globalIndexFromGlobalRow:row - 1 withGlobalCol:col]];
                    [self addConstraint:[NSLayoutConstraint constraintWithItem:curCubeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:previousCubeView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
                }
            }
        }
    }
}



@end
