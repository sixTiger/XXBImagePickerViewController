Pod::Spec.new do |s|
  s.name         = "XXBImagePickerViewController"
  s.version      = "1.0.1"
  s.summary      = "一个很好用的照片选择框架"
  s.homepage     = "https://github.com/sixTiger/XXBImagePickerViewController"
  s.license      = "MIT"
  s.author             = { "杨小兵" => "six_tiger@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/sixTiger/XXBImagePickerViewController.git", :tag => "1.0.1" }
  s.source_files  = "XXBImagePicker/**/*.{h,m}"
  s.resources = "XXBImagePicker/XXBImagePicker.bundle"
  s.require_arc = true
end
