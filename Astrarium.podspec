Pod::Spec.new do |s|
  s.name = 'Astrarium'
  s.version = '0.0.2'
  s.summary = 'Services management library'

  s.homepage = 'https://github.com/netcosports/Astrarium'
  s.license = { :type => "MIT" }
  s.author = { 
    'Dmitry Duleba' => 'dmitry.duleba@netcosports.com'
  }
  s.source = { :git => 'https://github.com/netcosports/Astrarium.git', :tag => s.version.to_s }

  s.framework = ["UIKit", "Foundation"]

  s.ios.deployment_target = '9.0'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |sub|
    sub.source_files = 'Sources/Core/*.swift'
  end

  # s.subspec 'CloudKit' do |sub|
  #   sub.source_files = 'Sources/CloudKit/*.swift'
  #   sub.dependency 'Astrarium/Core'
  #   sub.framework = "CloudKit"
  # end

  # s.subspec 'UserNotifications' do |sub|
  #   sub.source_files = 'Sources/UserNotifications/*.swift'
  #   sub.dependency 'Astrarium/Core'
  #   sub.framework = "UserNotifications"
  # end

  # s.subspec 'Intents' do |sub|
  #   sub.source_files = 'Sources/Intents/*.swift'
  #   sub.dependency 'Astrarium/Core'
  #   sub.framework = "Intents"
  # end

end
