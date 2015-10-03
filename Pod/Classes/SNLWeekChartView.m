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

#import "SNLWeekChartView.h"

#define HEIGHT_WEEKDAY 16
#define PADDING_LABEL 2

@interface SNLWeekChartView ()

@property (nonatomic) NSNumber *valueMax;
@property (nonatomic) NSNumber *valueTotal;

@end


@implementation SNLWeekChartView


#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeDefaults];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeDefaults];
    }
    return self;
}

- (void)initializeDefaults
{
    self.values = @[@(1),@(5),@(2),@(3),@(4),@(5),@(6)];
    self.paddingValue = -1;
    self.showValues = YES;
    self.showWeekdays = YES;
    self.startsOnMonday = YES;
    self.highlightWeekdays = YES;
    self.fillBarIfThin = YES;
    
    self.colorBackground = [UIColor whiteColor];
    self.colorChart = [UIColor blackColor];
    self.colorValue = [UIColor redColor];
    self.colorWeekday = [UIColor greenColor];
    self.colorWeekdayToday = [UIColor blackColor];
    self.colorWeekdayInactive = [UIColor grayColor];
    
    self.fontValue = [UIFont boldSystemFontOfSize:10];
    self.fontWeekday = [UIFont systemFontOfSize:10];
    self.fontWeekdayToday = [UIFont boldSystemFontOfSize:10];
    self.fontWeekdayInactive = [UIFont boldSystemFontOfSize:10];
}

- (void)setupView
{
    [self.barChartView removeFromSuperview];
    
    self.barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGFloat padding = self.paddingAppliedOnOutside ? [self barPaddingForBarChartView:self.barChartView] : 0;
    self.barChartView.frame = CGRectMake(padding, padding, self.frame.size.width - (padding * 2), self.frame.size.height - (self.showFullBar ? 0 : HEIGHT_WEEKDAY) - 2 * padding);
    
    self.barChartView.delegate = self;
    self.barChartView.dataSource = self;
    self.barChartView.clipsToBounds = NO;
    self.barChartView.showsVerticalSelection = NO;
    self.barChartView.minimumValue = 0;
    [self addSubview:self.barChartView];
    
    [_barChartView reloadData];
}

- (void)dealloc
{
    JBBarChartView *barChartView = self.barChartView;
    barChartView.delegate = nil;
    barChartView.dataSource = nil;
}


#pragma mark - Lifecycle

- (void)layoutSubviews
{
    self.backgroundColor = self.colorBackground;
    
    [self setupView];
}

- (void)prepareForInterfaceBuilder
{
    self.values = @[@(1),@(2),@(3),@(4),@(3),@(5),@(6)];
    
    [self setupView];
}


#pragma mark - Getter and Setter

- (BOOL)isModePercentage
{
    return self.percentageMode;
}

- (BOOL)isThin
{
    return self.barChartView.frame.size.width < 200;
}

- (BOOL)isVeryThin
{
    return self.barChartView.frame.size.width < 100;
}

- (void)setValues:(NSArray *)values
{
    NSMutableArray *values7 = [[NSMutableArray alloc] initWithCapacity:7];

    int i = 0;
    while (i < 7) {
        values7[i] = (values.count > i ? values[i] : @(0));
        i++;
    }
    
    _values = values7;
    self.valueMax = [values7 valueForKeyPath:@"@max.self"];
    self.valueTotal = [values7 valueForKeyPath: @"@sum.self"];
}

- (CGFloat)valueAtIndex:(NSUInteger)index
{
    return [[self.values objectAtIndex:index] floatValue];
}

- (NSNumber *)valueMax
{
    return (self.isModePercentage ? @(_valueMax.floatValue * 100 / [self.valueTotal floatValue]) : _valueMax);
}

- (CGFloat)barWidth
{
    NSInteger count = [self numberOfBarsInBarChartView:self.barChartView];
    CGFloat padding = [self barPaddingForBarChartView:self.barChartView];
    
    return (self.barChartView.frame.size.width - (padding * (count - 1))) / count;
}

- (BOOL)showWeekdays
{
    return _showWeekdays && !self.isVeryThin;
}

- (BOOL)showFullBar
{
    return !self.showWeekdays && self.fillBarIfThin;
}

- (BOOL)showValueLabel:(UILabel *)label atIndex:(NSUInteger)index
{
    CGFloat barValue = [self barChartView:self.barChartView heightForBarViewAtIndex:index];
    CGFloat barHeight = self.barChartView.frame.size.height / (self.valueMax.floatValue / barValue);
    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    
    return _showValues && labelSize.height < barHeight - PADDING_LABEL && labelSize.width < self.barWidth - 4 - (2 * PADDING_LABEL);
}


#pragma mark - JBBarChartViewDelegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    CGFloat value = [self valueAtIndex:index];
    
    if (self.percentageMode) {
        return (self.valueTotal.floatValue > 0.0f ? (value * 100 / self.valueTotal.floatValue) : 0.0f);
    } else {
        return value;
    }
}

- (CGFloat)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
    CGFloat width = barChartView.frame.size.width;
    NSUInteger bars = [self numberOfBarsInBarChartView:barChartView];
    CGFloat barWidth = width / bars;
    
    switch (self.paddingWidth) {
        case ChartWeekPaddingWidthSmall:
            return barWidth / 15;
            
        case ChartWeekPaddingWidthMedium:
            return barWidth / 7;
            
        case ChartWeekPaddingWidthBig:
            return barWidth / 3;
            
        case ChartWeekPaddingWidthThin:
            return 1;
            
        case ChartWeekPaddingWidthDefault:
        case ChartWeekPaddingWidthFromValue:
        default:
            return self.paddingValue >= 0 ? self.paddingValue : barWidth / 7;
    }
}


#pragma mark - JBBarChartViewDataSource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return 7;
}

- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
    UIView *barView = [UIView new];
    barView.backgroundColor = self.colorChart;
    barView.clipsToBounds = NO;
    
    if (self.showValues) {
        UILabel *labelValue = [UILabel new];
        labelValue.textColor = self.colorValue;
        labelValue.font = self.fontValue;
        labelValue.textAlignment = NSTextAlignmentCenter;
        labelValue.translatesAutoresizingMaskIntoConstraints = NO;
        
        if (self.percentageMode) {
            labelValue.text = [NSString stringWithFormat:@"%.f %%", [self barChartView:barChartView heightForBarViewAtIndex:index]];
        } else {
            labelValue.text = [NSString stringWithFormat:@"%.f", [self barChartView:barChartView heightForBarViewAtIndex:index]];
        }
        
        if ([self showValueLabel:labelValue atIndex:index]) {
            CGSize labelValueSize = [labelValue.text sizeWithAttributes:@{NSFontAttributeName:labelValue.font}];
            [self placeView:labelValue atBottomOfView:barView bottom:-PADDING_LABEL height:labelValueSize.height];
        }
    }
    
    if (self.showWeekdays) {
        UILabel *labelWeekday = [UILabel new];
        labelWeekday.textColor = self.colorWeekday;
        labelWeekday.font = self.fontWeekday;
        labelWeekday.textAlignment = NSTextAlignmentCenter;
        labelWeekday.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSString *weekdayText = [self weekdaySymbolForIndex:index startOnMonday:self.startsOnMonday veryShort:[self isThin]];
        labelWeekday.text = [[weekdayText stringByReplacingOccurrencesOfString:@"." withString:@""] uppercaseString];
        
        CGSize labelWeekdaySize = [labelWeekday.text sizeWithAttributes:@{NSFontAttributeName:labelWeekday.font}];
        [self placeView:labelWeekday atBottomOfView:barView bottom:HEIGHT_WEEKDAY - PADDING_LABEL height:labelWeekdaySize.height];
        
        if (self.highlightWeekdays) {
            NSInteger indexWeekday = [self weekdayForIndex:index];
            NSInteger dateIndexToday = [self indexForWeekdayFromDate:[NSDate date]];
            if (indexWeekday == dateIndexToday) {
                labelWeekday.font = self.fontWeekdayToday ? : self.fontWeekday;
                labelWeekday.textColor = self.colorWeekdayToday ? : self.colorWeekday;
            } else if (indexWeekday > dateIndexToday) {
                labelWeekday.font = self.fontWeekdayInactive ? : self.fontWeekday;
                labelWeekday.textColor = self.colorWeekdayInactive ? : self.colorWeekday;
            }
        }
    }
    
    return barView;
}


#pragma mark - Helper

- (NSInteger)indexForWeekdayFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = components.weekday;
    
    if (self.startsOnMonday) {
        return (weekday == 1 ? 6 : weekday - 1);
    } else {
        return weekday - 1;
    }
}

- (NSInteger)weekdayForIndex:(NSInteger)index
{
    if (self.startsOnMonday) {
        return (index == 6 ? 0 : index + 1);
    } else {
        return index;
    }
}

- (NSString *)weekdaySymbolForIndex:(NSInteger)index startOnMonday:(BOOL)weekStartsOnMonday veryShort:(BOOL)veryShort
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSArray *weekdaySymbols = (veryShort ? [formatter veryShortWeekdaySymbols] : [formatter shortWeekdaySymbols]);
    
    return weekdaySymbols[[self weekdayForIndex:index]];
}

- (void)placeView:(UIView *)view atBottomOfView:(UIView *)atView bottom:(NSInteger)bottom height:(NSUInteger)height
{
    [atView addSubview:view];
    
    NSLayoutConstraint *heightC = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
    NSLayoutConstraint *bottomC = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:atView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:bottom];
    NSLayoutConstraint *leftC = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:atView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    NSLayoutConstraint *rightC = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:atView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    
    [atView addConstraints:@[heightC, bottomC, leftC, rightC]];

}

@end
