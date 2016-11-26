workspace 'MaterialMotionCoreAnimation.xcworkspace'
use_frameworks!

pod 'MaterialMotionRuntime', :git => 'https://github.com/material-motion/runtime-objc.git', :branch => 'develop'

target "Catalog" do
  pod 'CatalogByConvention'
  pod 'MaterialMotionCoreAnimation/examples', :path => './'
  project 'examples/apps/Catalog/Catalog.xcodeproj'
end

target "UnitTests" do
  project 'examples/apps/Catalog/Catalog.xcodeproj'
  pod 'MaterialMotionCoreAnimation/tests', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "3.0"
      if target.name.start_with?("Material")
        configuration.build_settings['WARNING_CFLAGS'] ="$(inherited) -Wall -Wcast-align -Wconversion -Werror -Wextra -Wimplicit-atomic-properties -Wmissing-prototypes -Wno-sign-conversion -Wno-unused-parameter -Woverlength-strings -Wshadow -Wstrict-selector-match -Wundeclared-selector -Wunreachable-code"
      end
    end
  end
end
