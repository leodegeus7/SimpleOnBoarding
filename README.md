# Simple OnBoarding
> Create simple and super customizable OnBoarding Views


![](https://i.imgur.com/EnxDqZt.jpg)


With this tool you can create OnBoarding Views to show informations before the user actually see your app.


## Installation

POD Installation:

```sh
pod 'SimpleOnBoarding', :git => 'https://github.com/leodegeus7/SimpleOnBoarding.git'
```

![](https://media.giphy.com/media/3ohjUTRbJ5vyXecxdS/giphy.gif)

## Usage example

To use this tool you need to follow few steps:

1) In your AppDelegate import the framework SimpleOnBoarding;
2) Create a Json File with your information, upload it to a server or put it in your bundle. The structure of JSON file can be founded [here](https://github.com/leodegeus7/SimpleOnBoarding/blob/master/DemoApp/OnBoardingData.json);
3) Create an object of type OnBoarding in your didFinishLaunchingWithOptions. <br />
     - Passing the working mode:  *.online*  or  *.offline*<br />
     - Passing a config Json URL, this can be an *URL(string: "http://")* or a *Bundle.main.url(forResource: "file", withExtension: "json")*<br />
     - Passing a UIViewController to be the next controller in OnBoarding Flow <br />
  
```sh
SimpleOnBoarding(mode: WorkingMode, configJsonURL: URL, whereNextViewControllerIs: UIViewController)
```

4) If you use a Online JsonFile is required to use a LoadController, but if you use a offline data the Load screen is optional. If you want you can force the activatation and customize with the follow code:

```sh
onBoarding.showLoadingScreenWhenOffline(Bool, during: Int)
onBoarding.updateLoadingScreenView(image: UIImage, progressBarColor: UIColor,progressBarBackLoadingColor: UIColor)
```
5) Just start the onBoarding Views with the function *show()*.

```sh
onBoarding.show()
```

## Customization

Simple OnBoarding enables you to create a customizable layout. You can use our default layout and personalize with your colors and fonts or create your from a xib file.

### Default Layout Customization
```sh
let layout = OnBoardingLayout()
layout.titleColor = UIColor()
layout.descriptionFont = UIFont()
layout.buttonBackgroundColor = UIColor()
layout.backgroundColor = UIColor()
let onBoarding = SimpleOnBoarding(mode: WorkingMode, configJsonURL: URL, layout: layout, whereNextViewControllerIs: nextController)
onBoarding.show()
```

### Custom Layout From Xib
Download xib template file from [here](https://github.com/leodegeus7/SimpleOnBoarding/blob/master/DemoApp/OnBoardingView2.xib), and customize with your style, take care to don't delete any component. 
```sh
let layout = OnBoardingLayout(customNibName: "OnBoardingView", bundle: Bundle(for: AppDelegate.self))
let onBoarding = SimpleOnBoarding(mode: WorkingMode, configJsonURL: URL, layout: layout, whereNextViewControllerIs: nextController)
onBoarding.show()
```

### Multi Customization of Layout
You can create one layout to screen of OnBoarding. Just create the layouts and pass with an array to OnBoarding object:
```sh
let layout1 = OnBoardingLayout()
let layout2 = OnBoardingLayout()
let layout3 = OnBoardingLayout(customNibName: "OnBoardingView", bundle: Bundle(for: AppDelegate.self))
let onBoarding = SimpleOnBoarding(mode: WorkingMode, configJsonURL: URL, layout: [layout1,layout2,layout3], whereNextViewControllerIs: nextController)
onBoarding.show()
```

## Release History

* 0.0.1
    * First Commit
    
* 0.0.24
    * Updated to Swift 4.2

* 0.0.25
    * Fixed problems of communcation between controllers
    
## Meta

Leonardo Alexandre de Geus – [@leodegeus7](https://www.linkedin.com/in/leodegeus7/) – leonardodegeus@gmail.com

See ``LICENSE`` for more information.

[https://github.com/leodegeus7](https://github.com/leodegeus7)
