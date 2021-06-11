Pod::Spec.new do |s|
  s.name = 'Astrarium'
  s.version = '6.0'
  s.summary = 'Services management library'

  s.homepage = 'https://github.com/netcosports/Astrarium'
  s.license = { :type => "MIT" }
  s.author = { 
    'Dzmitry Duleba' => 'dmitryduleba@gmail.com'
  }
  s.source = { :git => 'https://github.com/netcosports/Astrarium.git', :tag => s.version.to_s }
  s.framework = ["UIKit", "Foundation"]

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/*.swift'

  s.weak_framework = "UserNotifications"

end
