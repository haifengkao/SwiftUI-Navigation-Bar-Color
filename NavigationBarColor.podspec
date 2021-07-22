#
# Be sure to run `pod lib lint NavigationBarColor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NavigationBarColor'
  s.version          = '0.2.0'
  s.summary          = 'A short description of NavigationBarColor.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/${GIT_ACCOUNT_NAME}/NavigationBarColor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hai Feng Kao' => 'haifeng@cocoaspice.in' }
  s.source           = { :git => 'https://github.com/${GIT_ACCOUNT_NAME}/NavigationBarColor.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # we need ios 11.0 to fix xcodebuild error
  # https://blog.csdn.net/qq_27785797/article/details/109058663
  s.ios.deployment_target = '14.0'
  # s.osx.deployment_target = '11.0'

  s.swift_version = '5'

  s.source_files = 'NavigationBarColor/Classes/**/*'

  # s.resource_bundles = {
  #   'NavigationBarColor' => ['NavigationBarColor/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
