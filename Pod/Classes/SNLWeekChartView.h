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

/**
 * Enables value labels in bar. Labels are automatically hidden if bar is too short or thin.
 *
 * @default YES
 */
@property (nonatomic) IBInspectable BOOL showValues;

/**
 * Shows values as percentage.
 *
 * @default NO
 */
@property (nonatomic) IBInspectable BOOL percentageMode;

/**
 * Enables weekday labels with text determined by the device language. Size depends on bar width and is hidden if too thin.
 *
 * @default YES
 */
@property (nonatomic) IBInspectable BOOL showWeekdays;

/**
 * Week can start on Monday or Sunday.
 *
 * @default YES
 */
@property (nonatomic) IBInspectable BOOL startsOnMonday;

/**
 * Use different color and font for current day, past days and days in the future.
 *
 * @default YES
 */
@property (nonatomic) IBInspectable BOOL highlightWeekdays;

/**
 * Weekday labels are hidden if bar is too thin; Set to fill whole view with bar.
 *
 * @default YES
 */
@property (nonatomic) IBInspectable BOOL fillBarIfThin;

/**
 * Set a padding class for your bars. Padding classes generate dynamic padding depending on the size of the view.
 *
 * @default ChartWeekPaddingWidthDefault
 */
@property (nonatomic) ChartWeekPaddingWidth paddingWidth; // set a padding class (ChartWeekPaddingWidth...)

/**
 * Set to use a fixed padding.
 * Do not set paddingWith or set paddingWidth = ChartWeekPaddingWidthFromValue.
 *
 * @default -1 (not used)
 */
@property (nonatomic) IBInspectable NSInteger paddingValue;

/**
 * Apply the same padding from bars on the outside of the view.
 *
 * @default NO
 */
@property (nonatomic) IBInspectable BOOL paddingAppliedOnOutside;


#pragma mark - Appearance

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
