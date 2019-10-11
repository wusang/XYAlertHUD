Pod::Spec.new do |s|
  s.name         = "XYAlertHUD"
  s.version      = "1.0.3"
  s.summary      = "提示框,进度条"

  # 项目主页地址
  s.homepage     = "https://github.com/wusang/XYAlertHUD.git"
 
  # 许可证
  s.license      = "MIT"
 
  # 作者
  s.author             = { "wusang" => "1149779588@qq.com" }
 

  # 支持平台
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  # 项目的地址
  s.source       = { 
            :git => "https://github.com/wusang/XYAlertHUD.git", 
            :tag => s.version 
  }

 # 需要包含的源文件
  s.source_files = "XYAlertHUD/*.{h,m}","XYAlertHUD/Lancoo/*.{h,m}"
  
  s.subspec "AlertView" do |ss|
    ss.source_files =  "XYAlertHUD/AlertView/*.{h,m}"
end

   # 资源文件
  s.resources = "XYAlertHUD/XYAlertHUD.bundle"

  # 是否支持ARC 
  s.requires_arc = true

  s.dependency 'Masonry'
  s.dependency 'XYExtensions'
  
end
