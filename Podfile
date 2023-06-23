# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SujungVillage-User' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SujungVillage-User

  # Alamofire
  pod 'Alamofire', '~> 5.2'

  # DropDown
  pod 'DropDown'

  # Encryption
  pod 'CryptoSwift'

  # Calendar
  pod 'FSCalendar'

  # Menu bar
  pod 'Tabman', '~> 2.13'

  # Floating Button
  pod 'DTZFloatingActionButton'

  # Lottie
  pod 'lottie-ios'

  # Add the Firebase pod for Google Analytics
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Messaging'

  # intstall Simulator
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
               end
          end
   end
end


end
