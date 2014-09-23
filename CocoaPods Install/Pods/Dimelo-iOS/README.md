Dimelo-iOS
==========

Dimelo provides a library that allows users of your app to easily communicate 
with your customer support agents.

Dimelo component supports text messages, image attachments, push notifications and automatic server-provided replies.

The component integrates nicely in any iPhone or iPad app, allows presenting the chat in tab, modal, popover or even customly designed containers and has rich customization options to fit perfectly in your application.

Getting started
---------------

**To install with CocoaPods:**

1. Simply add "Dimelo-iOS" in your Podfile like so: 

        pod 'Dimelo-iOS', :git => 'https://github.com/dimelo/Dimelo-iOS.git'

2. Run `pod install` to update your project.
3. Include header in your app delegate: `#include "Dimelo.h"`
4. Follow API reference to configure and use Dimelo instance.

**To install manually:**

1. Download contents from Github [Dimelo-iOS project](https://github.com/dimelo/Dimelo-iOS)
2. Drop `Dimelo` subfolder in your project.
3. Make sure `Dimelo.bundle`, `Dimelo-iOS.a` and `Dimelo*.xib` files are included in your target.
4. Link your target with these frameworks:
	1. Accelerate.framework
	2. MobileCoreServices.framework
	3. SystemConfiguration.framework
5. Include header in your app delegate: `#include "Dimelo.h"`
6. Follow API reference to configure and use Dimelo instance.


API Reference
-------------

You will find API documentation in `./Reference` folder. Alternatively, you may consult `Dimelo/Dimelo.h` file.


Files and folders
-----------------

Dimelo package contains the following files and folders:


##### ./Dimelo

A folder with necessary headers and resources to be installed in your app. If you don't use CocoaPods, you can simply drag and drop this folder into your Xcode project (don't forget to link extra system frameworks too, see above).

##### ./Dimelo/Dimelo.bundle

A bundle with Dimelo default images. This should be copied as-is into your app during build process.

##### ./Dimelo/Dimelo.h

Primary header file. You should import it to use Dimelo API.

##### ./Dimelo/Dimelo*.h

Private header files to make XIB files work correctly.

##### ./Dimelo/*.xib

Required user interface XIB files. These are not supposed to be edited.

##### ./Dimelo/libDimelo-iOS.a

A static lib to be linked with your app. It is build for multiple platforms, including iOS simulators.

##### ./Dimelo-iOS.podspec

A CocoaPods specification.

##### ./LICENSE

A license file.

##### ./README.md

You are reading this. 

##### ./Reference

An appledoc-style API reference generated from `Dimelo.h`.
