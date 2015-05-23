//
//  SNLWeekChartView.h
//  Pods
//
//  Created by Simon Nickel on 17.05.15.
//
//

#import <UIKit/UIKit.h>
#import "JBBarChartView.h"

typedef NS_ENUM(NSUInteger, ChartWeekPaddingWidth) {
    ChartWeekPaddingWidthDefault,
    ChartWeekPaddingWidthFromValue,
    ChartWeekPaddingWidthSmall,
    ChartWeekPaddingWidthMedium,
    ChartWeekPaddingWidthBig,
    ChartWeekPaddingWidthThin
};

IB_DESIGNABLE

@interface SNLWeekChartView : UIView <JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (nonatomic) JBBarChartView *barChartView;
@property (nonatomic) NSArray *values;


#pragma mark - Layout

@property (nonatomic) IBInspectable BOOL showValues;
@property (nonatomic) IBInspectable BOOL percentageMode;
@property (nonatomic) IBInspectable BOOL showWeekdays;
@property (nonatomic) IBInspectable BOOL fillBarIfThin;

@property (nonatomic) ChartWeekPaddingWidth paddingWidth;
@property (nonatomic) IBInspectable NSInteger paddingValue;
@property (nonatomic) IBInspectable BOOL paddingAppliedOnOutside;


#pragma mark - Design

@property (nonatomic) IBInspectable UIColor *colorBackground;
@property (nonatomic) IBInspectable UIColor *colorChart;
@property (nonatomic) IBInspectable UIColor *colorValue;
@property (nonatomic) IBInspectable UIColor *colorWeekday;

@property (nonatomic) UIFont *fontValue;
@property (nonatomic) UIFont *fontWeekday;

@end
