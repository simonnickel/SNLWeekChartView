//
//  SNLViewController.m
//  SNLWeekChartView
//
//  Created by Simon Nickel on 05/17/2015.
//  Copyright (c) 2014 Simon Nickel. All rights reserved.
//

#import "SNLViewController.h"
#import "SNLWeekChartView.h"

@interface SNLViewController ()

@end

@implementation SNLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.weekViewMain.values = @[@(1), @(2), @(0), @(1), @(1), @(1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
