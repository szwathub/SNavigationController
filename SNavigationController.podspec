#
# Be sure to run `pod lib lint SNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNavigationController'
  s.version          = '1.2.1'
  s.summary          = 'A simple library for replacement UINavigationController.'

  s.description      = <<-DESC
A simple library for replacement UINavigationController, you can self-define navigationController.
                       DESC

  s.homepage         = 'https://github.com/Cyrex/SNavigationController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cyrex' => 'szwathub@gmail.com' }
  s.source           = { :git => 'https://github.com/Cyrex/SNavigationController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'SNavigationController/*{h,m}'
end
