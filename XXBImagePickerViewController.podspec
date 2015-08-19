Pod::Spec.new do |s|
  s.name         = "XXBImagePickerViewController"
  s.version      = "1.0.0"
  s.summary      = "A short description of XXBImagePickerViewController."
  s.homepage     = "https://github.com/sixTiger/XXBImagePickerViewController"
  s.license      = "MIT"
  s.author             = { '杨小兵' => 'six_tiger@163.com' }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/sixTiger/XXBImagePickerViewController", :tag => s.version }
  s.source_files = "XXBImagePicker/*.{h,m}"
  s.resource     = "XXBImagePicker/XXBImagePicker.bundle"
  s.require_arc  = true
end
