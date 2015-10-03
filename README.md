# SNLWeekChartView

[![CI Status](http://img.shields.io/travis/Simon Nickel/SNLWeekChartView.svg?style=flat)](https://travis-ci.org/Simon Nickel/SNLWeekChartView)
[![Version](https://img.shields.io/cocoapods/v/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)
[![License](https://img.shields.io/cocoapods/l/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)
[![Platform](https://img.shields.io/cocoapods/p/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)

SNLWeekChartView is a wrapper to easily create a [JBChartView](https://github.com/Jawbone/JBChartView) representing a week. Just layout your SNLWeekChartView in your storyboard and style it using IB_DESIGNABLE. Set your values in your ViewController and you are done.

## Features

 * Configure and Preview view in storyboard.
 * Supports week start on monday or sunday.
 * Weekday and value labels.
 * Custom padding.
 * ...

![Example](https://raw.githubusercontent.com/simonnickel/SNLWeekChartView/master/Pod/Assets/SNLWeekChartView.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

SNLWeekChartView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```objective-c
pod "SNLWeekChartView", "~> 1.1.0"
```


## Usage

To use it in your project: 

1. Install with CocoaPods.
2. Add a UIView in your storyboard and change it's class to SNLWeekChartView.
3. Connect the view to your ViewController and set its values.

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.weekView.values = @[@(1), @(2), @(0), @(1), @(3), @(1)];
}
```


## Customization

### Colors & Fonts
You can set the colors (background, chart, value label, weekday label [past, current, future]) and fonts (value label, weekday label [past, current, future]) in storyboard or by settings their properties in your ViewController.
    
### Layout
You can set the padding between bars with dynamic padding classes (weekView.paddingWidth = ChartWeekPaddingWidthDefault, not supported in storyboard) or a fixed value (weekView.paddingValue). Padding can be applied on the outside of the view (paddingAppliedOnOutside). 

### Informations
You can ...
 * Disable value and week labels (weekView.showValues, weekView.showWeekdays).
 * Switch to show values as percentages (weekView.percentageMode). 
 * Highlight past, current and future weekdays (highlightWeekdays).
 * Set the weekdays to start on Sunday (startsOnMonday).



## Changelog

### v1.1.0
 * Added options to show empty values as "0" or "-", with custom color.
 * Improved example.

### v1.0.4
* Fix weekday label highlighting default font for future days.

### v1.0.3
 * Fix weekday label highlighting for week start on monday.

### v1.0.2
 * Improve example project.
 * Fix weekday label highlighting for week start on monday.

### v1.0.1
 * Add Dokumentation
 * Fix outside padding: also applied on top and bottom to make use of background color.


## Author

Simon Nickel, simon@googlemail.com, [@simonnickel](https://twitter.com/simonnickel)

## License

SNLWeekChartView is available under the MIT license. See the LICENSE file for more info.
