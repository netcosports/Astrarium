# Astrarium

Global dispatchers library

[![Version](https://img.shields.io/cocoapods/v/Astrarium.svg?style=flat)](https://cocoapods.org/pods/Astrarium)
[![License](https://img.shields.io/cocoapods/l/Astrarium.svg?style=flat)](https://cocoapods.org/pods/Astrarium)
[![Platform](https://img.shields.io/cocoapods/p/Astrarium.svg?style=flat)](https://cocoapods.org/pods/Astrarium)

## Installation

```ruby
pod 'Astrarium', '~> 1.0'
```

## Main concept

The main idea behind this library is to solve the following problems:
- Make `AppDelegate` implementation is more clean;
- Stop providing interface over managers/handlers as singleton object;

The main concept of Astrarium is `Service`. Service is statefull object in most of the cases. 
It has the same lifetime with application.
Access to these services is done by `ServiceIdentifier` using `Dispatcher`.

## Initialization

To integrate Astrarium into your app, you need to inherite your `AppDelegate` from Astrarium.AppDelegate:

```swift
public class AppDelegate: Astrarium.AppDelegate
```
 
Then you need to override services variable and return list of services ids:

```swift
  public override var services: [ServiceIds?] { return [
    .fabric,
    .firebase,
    .ui
    ]
  }
```

## Service implementation

Service itself has access to any `AppDelegate` callbacks to perform any action your service needs.
Here is simple example of UI service:

```swift
extension ServiceIds {
  static let ui = ServiceIdentifier<UICoordinator>()
}

final class UICoordinator: AppService {
  func someFancyMethod() {}
  func setup(with launchOptions: LaunchOptions) {}
}
```

Then you can access instance of service:

```swift
Services[.ui]?.someFancyMethod()
```
