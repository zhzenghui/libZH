Pod::Spec.new do |s|
  s.name         = "libZH"
  s.version      = "1.0.0"
  s.summary      = "libZH"
  s.homepage     = "https://github.com/zhzenghui/libZH"
  s.license      = 'MIT'
  s.author       = { "zeng" => "" }
  s.source       = { :git => "git@github.com:zhzenghui/libZH.git" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true
end
