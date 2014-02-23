#Static Lib Installation

Static Lib is alterative installation method.

1. Download latest version of GamesAnalytics iOS Wrapper binaries.
    The archive should contain these files:

    *`GameAnalytics.h`: The required header file containing methods for Games Analytics.*

    *`libGameAnalytics.a`: The required static library for Games Analytics.*

    Alternatively, you can use source code and build it yourself.
    In case you already have the older version of the binaries, remove them from your project.

2. Click on your project's Frameworks > Add Files to "Your project name".

    ![Add Files to](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/addfiles.png)

    Find and select the folder that contains the file named `libGameAnalytics.a`.
    The checkbox "Copy items into destination folder (if needed)" must be checked.
    Choose "Create groups for any added folders" and click Add.

    ![Select folder](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/selectfolder.png)

    The files `GameAnalytics.h` and `libGameAnalytics.a` should now be in your project.

    ![Files added](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/filesadded.png)

3. Select your project, target and choose "Build Phases" tab.
    Expand the "Link Binary With Libraries" group and check if it contains `libGameAnalytic.a` library.

    ![Link Binary With Libraries](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/linkbinary.png)

    In case it is not present there, drag and drop the library from your Project Navigator to the "Link Binary With Libraries" group.

4. In the "Link Binary With Libraries" group click the "+" to add new framework.
    Find the `SystemConfiguration.framework` in the list and click Add.

    ![Add framework](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/addframework.png)

    `SystemConfiguration.framework` now should be listed under the "Link Binary With Libraries" group.

    ![SystemConfiguration.framework](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/systemconfig.png)

    This is required for Reachability to manage network operations efficiently.

    Find the `AdSupport.framework` in the list and click Add.

    `AdSupport.framework` also should be listed under the "Link Binary With Libraries" group.

    This is required to get advertising Identifier on iOS6+.

5. Select your project, target and choose "Build Settings" tab.
    Under "Linking" group click on "Other Linker Flags" and add `-ObjC` flag.

    ![ObjC flag](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/objc.png)

6. In your project's build settings, find "Header Search Paths" and add $(SRCROOT) and check the box indicating a recurisve search.
    If the path to your project contains spaces, you must put $(SRCROOT) (as other custom search paths) in quotes.

    ![SRCROOT](https://github.com/GameAnalytics/GA-iOS-SDK/raw/master/Screenshots/srcroot.png)
