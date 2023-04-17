#
#  Be sure to run `pod spec lint ZHBaseKit_Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = 'ZHBaseKit_Swift'

  spec.version      = '2.3.3'

  spec.summary      = 'ZHBaseKit_Swift'

  spec.requires_arc = true

  spec.license      = 'MIT'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                    A framework for data-driven UI and rapid development -- Swift
                   DESC

  spec.homepage     = 'https://github.com/devpzh/ZHBaseKit_Swift.git'
  

  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { 'devpzh' => 'devpzh@163.com' }
  # Or just: spec.author    = "panzhenghui"
  # spec.authors            = { "panzhenghui" => "panzhenghui@nami.com" }
  # spec.social_media_url   = "https://twitter.com/panzhenghui"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source    = { :git => 'https://github.com/devpzh/ZHBaseKit_Swift.git', :tag => spec.version}

  spec.dependency 'SnapKit'

  spec.ios.deployment_target = '10.0'

  spec.source_files  = 'ZHBaseKit_Swift/Source/*.swift'
 
  spec.frameworks = 'UIKit'

  spec.swift_version = '5.0'
   
  

end
