Pod::Spec.new do |s|
  s.name             = 'Animations'
  s.version          = '0.0.5'
  s.summary          = 'Chaining animations && syntax sugar'
  s.homepage         = 'https://github.com/vysotskiyserhiy/Animations.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Serhiy Vysotskiy' => 'vysotskiyserhiy@gmail.com' }
  s.source           = { :git => 'https://github.com/vysotskiyserhiy/Animations.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Animations/Sources/**/*'
  s.swift_versions = '4.2'
  s.frameworks = 'UIKit'
end
