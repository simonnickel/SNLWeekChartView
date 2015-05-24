//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
@property (nonatomic) IBInspectable BOOL startsOnMonday;
@property (nonatomic) IBInspectable BOOL highlightWeekdays;
@property (nonatomic) IBInspectable BOOL fillBarIfThin;

@property (nonatomic) ChartWeekPaddingWidth paddingWidth;
@property (nonatomic) IBInspectable NSInteger paddingValue;
@property (nonatomic) IBInspectable BOOL paddingAppliedOnOutside;


#pragma mark - Design

@property (nonatomic) IBInspectable UIColor *colorBackground;
@property (nonatomic) IBInspectable UIColor *colorChart;
@property (nonatomic) IBInspectable UIColor *colorValue;
@property (nonatomic) IBInspectable UIColor *colorWeekday;
@property (nonatomic) IBInspectable UIColor *colorWeekdayToday;
@property (nonatomic) IBInspectable UIColor *colorWeekdayInactive;

@property (nonatomic) UIFont *fontValue;
@property (nonatomic) UIFont *fontWeekday;
@property (nonatomic) UIFont *fontWeekdayToday;
@property (nonatomic) UIFont *fontWeekdayInactive;

@end
