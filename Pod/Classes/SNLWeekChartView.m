//
//  SNLWeekChartView.m
//  Pods
//
//  Created by Simon Nickel on 17.05.15.
//
//

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
    self.mode = ChartWeekModeDefault;
    self.paddingValue = -1;
    self.showValues = YES;
    self.showWeekdays = YES;
    self.fillBarIfThin = YES;
    
    self.colorBackground = [UIColor whiteColor];
    self.colorChart = [UIColor blackColor];
    self.colorValue = [UIColor redColor];
    self.colorWeekday = [UIColor greenColor];
    
    self.fontValue = [UIFont boldSystemFontOfSize:10];
    self.fontWeekday = [UIFont boldSystemFontOfSize:10];
}

- (void)setupView
{
    [self.barChartView removeFromSuperview];
    self.barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGFloat padding = self.paddingAppliedOnOutside ? [self barPaddingForBarChartView:self.barChartView] : 0;
    self.barChartView.frame = CGRectMake(padding, 0, self.frame.size.width - (padding * 2), self.frame.size.height - (self.showFullBar ? 0 : HEIGHT_WEEKDAY));
    self.barChartView.delegate = self;
    self.barChartView.dataSource = self;
    self.barChartView.clipsToBounds = NO;
    self.barChartView.showsVerticalSelection = NO;
    self.barChartView.minimumValue = 0;
    [self addSubview:self.barChartView];
    
    [_barChartView reloadData];
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
    return self.mode == ChartWeekModePercentage;
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
    _values = values;
    
    self.valueMax = [values valueForKeyPath:@"@max.self"];
    
    self.valueTotal = [values valueForKeyPath: @"@sum.self"];
    NSInteger total = 0;
    for (NSNumber *value in self.values) {
        total += [value integerValue];
    }
}

- (CGFloat)valueAtIndex:(NSUInteger)index
{
    return [[self.values objectAtIndex:index] floatValue];
}

- (NSNumber *)valueMax
{
    return (self.isModePercentage ? @(_valueMax.floatValue * 100 / self.values.count) : _valueMax);
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
    
    if (self.isModePercentage) {
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
        
        if (self.isModePercentage) {
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
        
        NSString *weekday = [self weekdaySymbolForIndex:index startOnMonday:YES veryShort:[self isThin]];
        labelWeekday.text = [[weekday stringByReplacingOccurrencesOfString:@"." withString:@""] uppercaseString];
        
        CGSize labelWeekdaySize = [labelWeekday.text sizeWithAttributes:@{NSFontAttributeName:labelWeekday.font}];
        [self placeView:labelWeekday atBottomOfView:barView bottom:HEIGHT_WEEKDAY - PADDING_LABEL height:labelWeekdaySize.height];
    }
    
    return barView;
}


#pragma mark - Helper

- (NSString *)weekdaySymbolForIndex:(NSInteger)index startOnMonday:(BOOL)weekStartsOnMonday veryShort:(BOOL)veryShort
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSArray *weekdaySymbols = (veryShort ? [formatter veryShortWeekdaySymbols] : [formatter shortWeekdaySymbols]);
    
    if (weekStartsOnMonday) {
        return weekdaySymbols[index == 6 ? 0 : index + 1];
    } else {
        return weekdaySymbols[index];
    }
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
