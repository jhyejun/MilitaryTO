# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MilitaryTO' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for MilitaryTO
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  # pod 'FontAwesomeKit', '~> 2.2.0'
  
  pod 'SnapKit', '~> 4.0.0'
  pod 'Then'
  pod 'NVActivityIndicatorView'
  
  
  pod 'RxSwift'
  pod 'RxCocoa'
  
  pod 'RealmSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  
  
  pod 'SwiftLint'
  pod 'ObjectMapper'
  
  
  pod 'Carte'
  pod 'iRate'
  pod 'Fabric'
  pod 'Crashlytics'
  
  post_install do |installer|
    pods_dir = File.dirname(installer.pods_project.path)
    at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
  end

  target 'MilitaryTOTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MilitaryTOUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
