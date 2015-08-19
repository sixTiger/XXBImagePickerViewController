Pod::Spec.new do |s|
  s.name         = "XXBImagePickerViewController"
  s.version      = "1.0.1"
  s.summary      = "一个很好用的照片选择框架"
  s.homepage     = "https://github.com/sixTiger/XXBImagePickerViewController"
  s.license      = "MIT"
  s.author             = { "杨小兵" => "six_tiger@163.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/sixTiger/XXBImagePickerViewController.git", :tag => s.version }
  s.source_files = "XXBImagePicker/*.{h,m}"
  s.resource     = "XXBImagePicker/XXBImagePicker.bundle"
  s.requires_arc  = true
end
