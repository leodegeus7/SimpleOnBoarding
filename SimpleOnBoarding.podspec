Pod::Spec.new do |s|

s.name         = "SimpleOnBoarding"
s.version      = "0.0.24"
s.summary      = "This is a easy-to-use framework to create OnBoarding Views"

s.description  = <<-DESC
With this tool is possible to create super personalizable OnBoarding views in your Swift App
DESC

s.homepage     = "https://github.com/leodegeus7/SimpleOnBoarding"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Leonardo Geus" => "leoardodegeus@gmail.com" }
s.platform     = :ios, "12.0"
s.source       = { :git => "https://github.com/leodegeus7/SimpleOnBoarding.git", :tag => "#{s.version}" }
s.source_files  = "SimpleOnBoarding", "SimpleOnBoarding/**/*.{h,m,swift,xib}"
s.exclude_files = "Classes/Exclude"
s.resources = ['SimpleOnBoarding/**/*.{storyboard,jpg,png}']
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2'}
end
