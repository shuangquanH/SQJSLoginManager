
Pod::Spec.new do |s|
    s.name         = "SQJSLoginManager"
    s.version      = "0.0.2"
    s.ios.deployment_target = '8.0'
    s.summary      = "jiansi login manager"
    s.homepage     = "https://github.com/shuangquanH/SQJSLoginManager.git"
    s.license              = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "shuangquanH" => "butrys@163.com" }
    s.social_media_url   = "http://flysblog.lofter.com"
    s.source       = { :git => "https://github.com/shuangquanH/SQJSLoginManager.git", :tag => s.version }
    s.requires_arc = true
    s.ios.dependency 'SQJSRequestTool'
    s.ios.dependency 'YYModel'
    s.ios.dependency 'JShare', '~> 1.5.0'  

    s.source_files = 'SQJSLoginManager/*.{h,m}'
end