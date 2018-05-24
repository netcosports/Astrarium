Pod::Spec.new do |s|
  s.name = 'Astrarium'
  s.version = '0.0.1'
  s.summary = 'Services management library'

  s.homepage = 'https://github.com/netcosports/Astrarium'
  s.license = { :type => "MIT" }
  s.author = { 
    'Dmitry Duleba' => 'dmitry.duleba@netcosports.com'
  }
  s.source = { :git => 'https://github.com/netcosports/Astrarium.git', :tag => s.version.to_s }

  s.framework = "UIKit"
  s.framework = "Foundation"
  s.framework = "UserNotifications"

  s.ios.deployment_target = '9.0'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |sub|
    sub.source_files = 'Sources/Core/*.swift'
  end
end
