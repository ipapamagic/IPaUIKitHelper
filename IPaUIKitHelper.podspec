#
# Be sure to run `pod lib lint IPaUIKitHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IPaUIKitHelper'
  s.version          = '1.0'
  s.summary          = 'as Name , this is a UIKit helper, there some helper function for easily use with UIKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ipapamagic/IPaUIKitHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'IPa Chen' => 'ipapamagic@gmail.com' }
  s.source           = { :git => 'https://github.com/ipapamagic/IPaUIKitHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  
  s.dependency 'IPaLog', '~> 3.0'
  # s.resource_bundles = {
  #   'IPaUIKitHelper' => ['IPaUIKitHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.subspec 'IPaUIKitHelper' do |sp|
    s.source_files = 'IPaUIKitHelper/Classes/IPaUIKitHelper/*'
    s.dependency 'IPaImageTool', '~> 2.3'
  end
  s.subspec 'IPaImageURL' do |sp|
    sp.source_files = 'IPaUIKitHelper/Classes/IPaImageURL/*'
    s.dependency 'IPaDownloadManager', '~> 1.3'
    s.dependency 'IPaFileCache', '~> 1.0'
  end
  s.subspec 'IPaButtonStyler' do |sp|
    sp.source_files = 'IPaUIKitHelper/Classes/IPaButtonStyler/*'
  end
  s.subspec 'IPaNestedScrollView' do |sp|
    sp.source_files = 'IPaUIKitHelper/Classes/IPaNestedScrollView/*'
  end
  s.subspec 'IPaFitContent' do |sp|
    sp.source_files = 'IPaUIKitHelper/Classes/IPaFitContent/*'
  end
  s.subspec 'IPaUIKit' do |sp|
    sp.source_files = 'IPaUIKitHelper/Classes/IPaUIKit/*'
  end
end
