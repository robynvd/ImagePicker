# Shared-iOS

Repository for GSShared CocoaPod, a shared library for GRIDSTONE iOS apps.

## Installation

GSShared is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GSShared', :git => 'https://github.com/Gridstone/Shared-iOS.git'
```

If you would like to develop the shared library while working on a project that depends on it,
you can reference the pod with a relative path. Cocoapods will then import the pod as a "development"
pod and use symlinks to refer to the class files rather than taking copies, allowing you to make changes
to the library from within your app.

```ruby
pod 'GSShared', :path => '../../Shared-iOS/GSShared.podspec'
```

You can also import subspecs if you don't want to pull in all the code and dependent libraries.
The following subspecs exist:
* Core - Core classes used by other subspecs
* AutoLayout - AutoLayout utilities and abstract classes for tables/collection views
* Forms - Forms related classes with dependency on ZXingObjC
* Location - Location related classes
* Model - Data model related classes with dependency on MagicalRecord and Mantle
* Network - Network related classes with dependency on AFNetworking
* Tasks - Asynchronous task handling classes with Promise style API
* UI - UI related classes and utilities
* Utils - Static utility methods

Examples importing individual subspecs.

```ruby
pod 'GSShared/Core', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/AutoLayout', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Forms', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Location', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Model', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Network', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Tasks', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/UI', :git => 'https://github.com/Gridstone/Shared-iOS.git'
pod 'GSShared/Utils', :git => 'https://github.com/Gridstone/Shared-iOS.git'
```

## Author

Trent Fitzgibbon, trentf@gridstone.com.au

## License

This library is for internal GRIDSTONE use only.
