#
# Be sure to run `pod lib lint SNLWeekChartView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SNLWeekChartView"
  s.version          = "1.1.1"
  s.summary          = "SNLWeekChartView is a wrapper to easily create a [JBChartView](https://github.com/Jawbone/JBChartView) representing a week."
  s.description      = <<-DESC
                       Using IB_DESIGNABLE you can add a SNLWeekChartView to your storyboard to configure and preview it right there. This view configures and handles a JBChartView.
                       DESC
  s.homepage         = "https://github.com/simonnickel/SNLWeekChartView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Simon Nickel" => "simonnickel@googlemail.com" }
  s.source           = { :git => "https://github.com/simonnickel/SNLWeekChartView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/simonnickel'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SNLWeekChartView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JBChartView', '~> 2.8'
end
