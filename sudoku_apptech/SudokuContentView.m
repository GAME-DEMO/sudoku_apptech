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
#import "NumberCollectionViewCell.h"
#import "ColorCollectionViewCell.h"

@interface SudokuContentView ()

@property (nonatomic, strong) NSMutableArray<SudokuCubeView *> *cubeViewArray;
@property (nonatomic, strong) SudokuCubeView *currentSelectedCubeView;

@end


@implementation SudokuContentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _cubeViewArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].cubesCountForAll];
        [[NSNotificationCenter defaultCenter] addObserverForName:NumberCollectionViewCellSelectionChanged object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            NumberCollectionViewCell *numberCell = [note.userInfo objectForKey:NumberCollectionViewCellSelectionChangedKeyCell];
            if (numberCell.selected) {
                self.currentSelectedCubeView.cubeValue = numberCell.number;
            } else {
                self.currentSelectedCubeView.cubeValue = 0;
            }
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:ColorCollectionViewCellSelectionChanged object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            ColorCollectionViewCell *colorCell = [note.userInfo objectForKey:ColorCollectionViewCellSelectionChangedKeyCell];
            if (colorCell.selected) {
                
            } else {
                
            }
            
        }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            [self addSubview:cubeView];
            [self.cubeViewArray addObject:cubeView];
            cubeView.selected = NO;
            cubeView.index = i;
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
    
    self.userInteractionEnabled = YES;
}

- (void)setCubeValue:(int)value atIndex:(int)index {
    if (index >= 0 && index < self.cubeViewArray.count) {
        [self.cubeViewArray objectAtIndex:index].cubeValue = value;
    }
}

- (void)setCubeValue:(int)value atIndex:(int)index withValueColor:(UIColor *)color {
    if (index >= 0 && index < self.cubeViewArray.count) {
        [[self.cubeViewArray objectAtIndex:index] setCubeValue:value withValueColor:color];
    }
}

- (void)loadSudokuValues {
    for (int i = 0; i < [Presenter sharedInstance].sudokuArray.count; ++i) {
        [self setCubeValue:[[Presenter sharedInstance].sudokuArray objectAtIndex:i].intValue atIndex:i withValueColor:RGBA(150.0, 150.0, 150.0, 1.0)];
    }
    
    for (int row = [Presenter sharedInstance].dimension - 1; row >= 0; --row) {
        for (int col = 0; col < [Presenter sharedInstance].dimension; ++col) {
            int globalIndex = [[Presenter sharedInstance] globalIndexFromGlobalRow:row withGlobalCol:col];
            if ([[Presenter sharedInstance].sudokuArray objectAtIndex:globalIndex].intValue == 0) {
                [self selectCubeView:[self.cubeViewArray objectAtIndex:globalIndex]];
                return;
            }
        }
    }
}

// 一维上点到线段的距离，线段用一个数组表示，[0]表示左点坐标，[1]表示右点坐标
- (CGFloat)distanceFromDot:(CGFloat)dot toLine:(NSArray *)line {
    if (dot < [line[0] floatValue]) {
        return [line[0] floatValue] - dot;
    } else if (dot > [line[1] floatValue]) {
        return dot - [line[1] floatValue];
    } else {
        return 0;
    }
}

// 这里使用曼哈顿距离而不是用欧几里得距离，是为了减轻计算量。
- (CGFloat)distanceToCubeView:(SudokuCubeView *)cubeView fromPoint:(CGPoint)point {
    CGRect frame = cubeView.frame;
    
    CGFloat xDistance = [self distanceFromDot:point.x toLine:@[@(frame.origin.x), @(frame.origin.x + frame.size.width)]];
    CGFloat yDistance = [self distanceFromDot:point.y toLine:@[@(frame.origin.y), @(frame.origin.y + frame.size.height)]];
    
    return xDistance + yDistance;
}

- (SudokuCubeView *)nearestCubeViewFromPoint:(CGPoint)point {
    SudokuCubeView *nearestCubeView = nil;
    CGFloat nearestDistance = CGFLOAT_MAX;
    for (SudokuCubeView *cubeView in self.cubeViewArray) {
        CGFloat distance = [self distanceToCubeView:cubeView fromPoint:point];
        if (distance < nearestDistance) {
            nearestDistance = distance;
            nearestCubeView = cubeView;
        }
    }
    return nearestCubeView;
}

- (void)updateCurrentSelectedCubeViewAtPoint:(CGPoint)point {
    SudokuCubeView *nearestCubeView = [self nearestCubeViewFromPoint:point];
    if ([[Presenter sharedInstance].sudokuArray objectAtIndex:nearestCubeView.index].intValue == 0) {
        [self selectCubeView:nearestCubeView];
    }
}

- (void)selectCubeView:(SudokuCubeView *)cubeView {
    if (cubeView != self.currentSelectedCubeView) {
        self.currentSelectedCubeView.selected = NO;
        self.currentSelectedCubeView = cubeView;
        self.currentSelectedCubeView.selected = YES;
        [self bringSubviewToFront:self.currentSelectedCubeView];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self updateCurrentSelectedCubeViewAtPoint:touchPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self updateCurrentSelectedCubeViewAtPoint:touchPoint];
}

@end
