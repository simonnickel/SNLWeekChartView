//
//  SNLViewController.h
//  SNLWeekChartView
//
//  Created by Simon Nickel on 05/17/2015.
//  Copyright (c) 2014 Simon Nickel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNLWeekChartView;

@interface SNLViewController : UIViewController

@property (weak, nonatomic) IBOutlet SNLWeekChartView *weekViewMain;
@property (weak, nonatomic) IBOutlet SNLWeekChartView *weekViewEmpty;

@end
