# SlidingMenu


##What Does it Support ?


*	iOS: 6, and 7.
*	Devices: iPhone, iPad



##How to use SlidingMenu


Include the following two files in your project:

```
SlidingMenu.h
SlidingMenu.m
```

Create a SlidingMenu object by calling:

```
- (id)initWithView:(UIViewController*) mainView backView:(UIViewController*)backView;
``` 

The mainView will be your front view. The backView will be your Menu (generally a UITableViewController) but you can put what you want.

I recommend you to instantiate this object as your rootViewController, in the following function:

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
```


##Opening and Closing The Slider


You are able to open/close the slider yourself calling

```
- (void)openSlider
- (void)closeSlider
```


## Options


### Locked the slider

You can enable/disable as opening or closing calling this function:

```
- (void)isLocked:(BOOL)value
```

### Allow/block user to slide manually

You can disable manual open/close with:

```
- (void)isAllowManually:(BOOL)value
```

### Set Visible part of Main view


You can set the width of the visible part of the main view that will be seen when the slider will be opened

```
- (void)set_horizontal_opening:(float)value
```

### Moving Vertically the Main view


If you would also move the slider vertically, you can change it default value (0 pts) using:

```
- (void)set_vertical_opening:(float)value
```

##Developed By

* Stefan Lage