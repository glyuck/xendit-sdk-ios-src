Pod::Spec.new do |s|
  s.name             = 'Xendit'
  s.version          = '3.8.1'
  s.license          = 'MIT'
  s.homepage         = 'https://www.xendit.co'
  s.author           = { 'Juan Gonzalez’' => 'juan@xendit.co' }
  s.social_media_url = 'https://www.facebook.com/xendit'
  s.summary          = 'Xendit is an API for accepting payments online'
  s.source           = { :git => 'https://github.com/xendit/xendit-sdk-ios-src.git', :tag => s.version }
  s.swift_versions   = ['4', '5']

  s.platform              = :ios, '9.0'
  s.ios.deployment_target = '9.0'

  s.default_subspec = 'Default'
  # Default subspec that includes the most commonly-used components
  s.subspec 'Default' do |default|
    default.dependency 'Xendit/XenditObjC'
    default.dependency 'Sentry'
    default.source_files = 'Sources/Xendit/**/*.swift'
  end

  # The XenditObjC subspec, containing the Objective-C library needed
  s.subspec 'XenditObjC' do |xenditobjc|
    xenditobjc.source_files = 'Sources/XenditObjC/**/*.{h,m}',
        'Sources/XenditObjC/include/Xendit.h'
  end

  s.subspec 'Sentry' do |sentry|
    sentry.vendored_frameworks = "Sentry.xcframework"
  end

  s.pod_target_xcconfig  = { 'ONLY_ACTIVE_ARCH' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.user_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
