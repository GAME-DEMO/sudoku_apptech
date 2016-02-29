//
//  UISudokuDataManager.h
//  sudoku_apptech
//
//  Created by Peng Wang on 2/29/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICubeData : NSObject

@property (nonatomic, assign) int value;
@property (nonatomic, strong) NSArray *guessArray;
@property (nonatomic, assign) BOOL showGuess;

@property (nonatomic, strong) NSArray *valueColorArray;
@property (nonatomic, strong) NSArray *guessColorArray;

@end


@interface UISudokuDataManager : NSObject

+ (instancetype)sharedInstance;

@end
