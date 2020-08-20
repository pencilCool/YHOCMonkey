#
# Be sure to run `pod lib lint YHOCMonkey.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YHOCMonkey'
  s.version          = '0.1.1'
  s.summary          = 'iOS Random Monkey Test'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: iOS Random Test, steal the ideal from SwiftMonkey
                       DESC

  s.homepage         = 'https://github.com/pencilCool/YHOCMonkey'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pencilCool' => 'yhtangcoder@gmail.com' }
  s.source           = { :git => 'https://github.com/pencilCool/YHOCMonkey.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.subspec 'Paws' do |ss|
    ss.source_files = 'YHOCMonkey/Classes/Paws/*'
    ss.public_header_files = 'YHOCMonkey/Classes/Paws/*.h'
  end

  s.subspec 'Test' do |ss|
    ss.source_files = 'YHOCMonkey/Classes/Test/*'
    ss.public_header_files = 'YHOCMonkey/Classes/Test/*.h'
    ss.frameworks = 'XCTest'
  end
end
