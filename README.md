# NavigationBarColor

[![Version](https://img.shields.io/cocoapods/v/NavigationBarColor.svg?style=flat)](https://cocoapods.org/pods/NavigationBarColor)
[![License](https://img.shields.io/cocoapods/l/NavigationBarColor.svg?style=flat)](https://cocoapods.org/pods/NavigationBarColor)
[![Platform](https://img.shields.io/cocoapods/p/NavigationBarColor.svg?style=flat)](https://cocoapods.org/pods/NavigationBarColor)

Change SwiftUI NavigationBar background color per screen.

![NavigationColorBar](https://github.com/haifengkao/SwiftUI-Navigation-Bar-Color/raw/main/screens/screen1.gif)
## Usage

For `NavigationBarColor` to work, you have to set the NavigationBar's background to be transparent.
If you want to change the tint color, you have to set the color here as well.
```
import NavigationBarColor
...

NavigationView {
    VStack {
        Text("Hello, world!").padding()
    }
}.navigationTransparentBar(tintColor: .white) // mandatory
```

After that, we can set the NavigationBar's background for each screen.
```
VStack {
    Text("Hello, Red!").padding()
}.navigationBarBackground {
    Color.red.shadow(radius: 1) // don't forget the shadow under the opaque navigation bar
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
`ios 14`

## Installation

NavigationBarColor is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NavigationBarColor'
```

## Author

Hai Feng Kao, haifeng@cocoaspice.in

## License

NavigationBarColor is available under the MIT license. See the LICENSE file for more info.
