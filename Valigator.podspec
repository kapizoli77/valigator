Pod::Spec.new do |spec|
  spec.name         = "Valigator"
  spec.version      = "1.0.0"
  spec.summary      = "Swift library to validate single fields or a whole form."
  spec.homepage     = "https://github.com/kapizoli77/valigator"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "kapizoli77"
  spec.platform     = :ios
  spec.platform     = :ios, "11.0"
  spec.swift_versions = ['5.1']
  spec.default_subspec = "Core"
  spec.source       = { :git => "https://github.com/kapizoli77/valigator.git", :tag => "#{spec.version}" }

  spec.subspec "Core" do |ss|
    ss.source_files  = "Source/Valigator/**/*.swift"
    ss.framework  = "Foundation"
  end

  spec.subspec "RxValigator" do |ss|
    ss.source_files = "Source/RxValigator/**/*.swift"
    ss.dependency "Valigator/Core"
    ss.dependency "RxSwift", "~> 6.0"
  end
end
