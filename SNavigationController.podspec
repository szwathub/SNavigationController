#
# Be sure to run `pod lib lint SNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNavigationController'
  s.version          = '2.0.1'
  s.summary          = 'A simple library for replacement UINavigationController.'
  s.description      = <<-DESC
A simple library for replacement UINavigationController, you can self-define navigationController.
                       DESC

  s.homepage         = 'https://github.com/szwathub/SNavigationController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'szwathub' => 'szwathub@gmail.com' }
  s.source           = { :git => 'https://github.com/szwathub/SNavigationController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version         = '5.0'
  s.source_files = 'SNavigationController/*{swift}'
end
