Pod::Spec.new do |s|
  s.name = 'Astrarium'
  s.version = '5.1.1'
  s.summary = 'Services management library'

  s.homepage = 'https://github.com/netcosports/Astrarium'
  s.license = { :type => "MIT" }
  s.author = { 
    'Dzmitry Duleba' => 'dmitryduleba@gmail.com'
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
  #   sub.dependency 'Sources/Core'
  #   sub.framework = "CloudKit"
  # end

  s.subspec 'UserNotifications' do |sub|
    sub.dependency 'Astrarium/Core'
    sub.source_files = 'Sources/UserNotifications/UserNotificationsService.swift'
    sub.source_files = 'Sources/UserNotifications/*.swift'
    sub.weak_framework = "UserNotifications"
  end

  # s.subspec 'Intents' do |sub|
  #   sub.source_files = 'Sources/Intents/*.swift'
  #   sub.dependency 'Sources/Core'
  #   sub.framework = "Intents"
  # end

end
