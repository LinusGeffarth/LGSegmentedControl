#
# Be sure to run `pod lib lint LGSegmentedControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LGSegmentedControl'
  s.version          = '1.1'
  s.summary          = 'A prettier and highly customizable UISegmentedControl'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LGSegmentedControl is a highly customizable and therefor prettier version of UISegmentedControl.
                       DESC

  s.homepage         = 'https://github.com/linusgeffarth/LGSegmentedControl'
  s.screenshots      = 'https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss4.jpeg', 'https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss1.png', 'https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss2.png', 'https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss3.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linusgeffarth' => 'linus@geffarth.com' }
  s.source           = { :git => 'https://github.com/linusgeffarth/LGSegmentedControl.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/linusgeffarth'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LGSegmentedControl/Classes/**/*'
  
  s.frameworks = 'UIKit'
  
end
