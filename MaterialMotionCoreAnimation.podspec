Pod::Spec.new do |s|
  s.name         = "MaterialMotionCoreAnimation"
  s.summary      = "Core Animation for Material Motion (Swift)"
  s.version      = "1.1.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/coreanimation-swift"
  s.source       = { :git => "https://github.com/material-motion/coreanimation-swift.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "src/*.{swift}", "src/private/*.{swift}"

  s.dependency "MaterialMotionRuntime", ">= 4.0", "< 6.0"
end
