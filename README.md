# SNLWeekChartView

[![CI Status](http://img.shields.io/travis/Simon Nickel/SNLWeekChartView.svg?style=flat)](https://travis-ci.org/Simon Nickel/SNLWeekChartView)
[![Version](https://img.shields.io/cocoapods/v/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)
[![License](https://img.shields.io/cocoapods/l/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)
[![Platform](https://img.shields.io/cocoapods/p/SNLWeekChartView.svg?style=flat)](http://cocoapods.org/pods/SNLWeekChartView)

SNLWeekChartView is a wrapper to easily create a [JBChartView](https://github.com/Jawbone/JBChartView) representing a week. Using IB_DESIGNABLE you can add a SNLWeekChartView to your storyboard to configure and preview it right there. 

![Example](https://raw.githubusercontent.com/simonnickel/SNLWeekChartView/master/Pod/Assets/SNLWeekChartView.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

SNLWeekChartView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```objective-c
pod "SNLWeekChartView", "~> 1.0.0"
```


## Usage

To use it in your project: 

1. Install with CocoaPods.
2. Add a UIView in your storyboard and change it's class to SNLWeekChartView.
3. Connect your view to your ViewController and set values.

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.weekView.values = @[@(1), @(2), @(0), @(1), @(1), @(1)];
}
```


## Configuration

...


## Author

Simon Nickel, simon@googlemail.com, [@simonnickel](https://twitter.com/simonnickel)

## License

SNLWeekChartView is available under the MIT license. See the LICENSE file for more info.
