Pod::Spec.new do |s|
  s.name         = "MaterialMotionCoreAnimation"
  s.summary      = "Core Animation for Material Motion (Swift)"
  s.version      = "2.0.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/coreanimation-swift"
  s.source       = { :git => "https://github.com/material-motion/coreanimation-swift.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.default_subspec = "lib"

  s.subspec "lib" do |ss|
    ss.source_files = "src/*.{swift}", "src/private/*.{swift}"
  end

  s.subspec "examples" do |ss|
    ss.source_files = "examples/*.{swift}", "examples/supplemental/*.{swift}"
    ss.exclude_files = "examples/TableOfContents.swift"
    ss.resources = "examples/supplemental/*.{xcassets}"
    ss.dependency "MaterialMotionCoreAnimation/lib"

    ss.dependency "MaterialMotionRuntime"
  end

  s.subspec "tests" do |ss|
    ss.source_files = "tests/src/*.{swift}", "tests/src/private/*.{swift}"
    ss.dependency "MaterialMotionCoreAnimation/lib"
    ss.dependency "MaterialMotionRuntime/tests"
  end

  s.dependency "MaterialMotionRuntime", "~> 6.0"
end
