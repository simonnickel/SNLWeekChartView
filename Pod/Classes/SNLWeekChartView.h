//
//  SNLWeekChartView.h
//  Pods
//
//  Created by Simon Nickel on 17.05.15.
//
//

#import <UIKit/UIKit.h>
#import "JBBarChartView.h"

typedef NS_ENUM(NSUInteger, ChartWeekMode) {
    ChartWeekModeDefault,
    ChartWeekModePercentage
};

typedef NS_ENUM(NSUInteger, ChartWeekPaddingType) {
    ChartWeekPaddingTypeDefault,
    ChartWeekPaddingTypeWithValue,
    ChartWeekPaddingTypeSmall,
    ChartWeekPaddingTypeMedium,
    ChartWeekPaddingTypeBig,
    ChartWeekPaddingTypeThin
};

IB_DESIGNABLE

@interface SNLWeekChartView : UIView <JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (nonatomic) JBBarChartView *barChartView;

@property (nonatomic) IBInspectable UIColor *colorBackground;
@property (nonatomic) IBInspectable UIColor *colorChart;
@property (nonatomic) IBInspectable UIColor *colorValue;
@property (nonatomic) IBInspectable UIColor *colorWeekday;

@property (nonatomic) IBInspectable BOOL showWeekdays;
@property (nonatomic) IBInspectable BOOL fillBarIfThin;
@property (nonatomic) IBInspectable BOOL showValues;

@property (nonatomic) UIFont *fontValue;
@property (nonatomic) UIFont *fontWeekday;

@property (nonatomic) IBInspectable NSArray *values;
@property (nonatomic) ChartWeekMode mode;
@property (nonatomic) ChartWeekPaddingType paddingType;
@property (nonatomic) IBInspectable NSInteger paddingValue;

@end
