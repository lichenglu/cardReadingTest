# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'CRCardsReader' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CRCardsReader

  # Textfields for displaying card info
  pod 'Caishen', :git => 'https://github.com/prolificinteractive/Caishen.git', :branch => 'swift-3.0'
  
  # Card Reading by Paypal
  pod 'CardIO'

  # Auto Layout
  pod 'SnapKit', '~> 3.0.2'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end 
  
end
