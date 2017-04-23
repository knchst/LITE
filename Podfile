# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LITE' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LITE
  pod 'GlidingCollection'
  pod 'APIKit'
  pod 'RealmSwift'
  pod 'ObjectMapper'
  pod 'SwiftyJSON'
  pod 'IoniconsKit'
  pod 'NVActivityIndicatorView'
  pod 'Kingfisher'

  target 'LITETests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LITEUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end
end
