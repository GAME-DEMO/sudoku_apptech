//
//  ViewController.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/19/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "ViewController.h"
#import "SudokuContentView.h"
#import "SudokuFootView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet SudokuContentView *contentView;
@property (nonatomic, weak) IBOutlet SudokuFootView *footView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView viewDidLoad];
    [self.footView viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
