# Lepaya-Coordinator

Useful pod to implement the Coordinator design pattern with ease. If your app is a tabbed one, you can start with this few lines:

```
self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let appCoordinator = TabCoordinator(window: self.window!)
        appCoordinator.setup(tabNames: ["first", "second"],
                             tabImages: ["tab_image_01", "tab_image_02"]) { () -> ([NCCoordinator]) in
                                
                                let firstTab = NCCoordinator(rootController: RedController())
                                
                                let secondTab = NCCoordinator(rootController: GreenController())
                                
                                return [firstTab, secondTab]
                                
        }
        appCoordinator.firstTabToLoad = 1 // select which tab will be visible at launch
        appCoordinator.start()
```

If you prefer simple navigation:

```
let appCoordinator = NCCoordinator(rootController: RedController())
        appCoordinator.start(window: self.window!)
```

To push a new Controller:

```
self.getNavigationController { (navigation) in
            
            let green = GreenController()
            let coordinator = VCCoordinator(push: green, presenter: navigation)
            green.coordinator = coordinator
            coordinator.start()
        }
```

To present a new one modally:

```
self.getNavigationController { (navigation) in
            
            let green = GreenController()
            green.loadButtonBack()
            let coordinator = VCCoordinator(presentModally: green, navigation: navigation, presenter: self)
            green.coordinator = coordinator
            coordinator.start()
        }
```

Stop wondering if you have to dismiss or pop a controller to go back, use the extension method of EUIViewController:

```
self.goBack()
```

**NOTE**: CoordinatorPackage uses a subclass of UIViewController named `ExtendedViewController` that expands the class with some basic functionality:

* `isModal` to immediately know if the controller you are working on is presented modally or not.
* `coordinator` the `VCCoordinator`, used to go back to the previous controller.
*  `setTabBarControllerDelegate()` to set the controller as `UITabBarControllerDelegate` to be able to load and re-load (only if it is visible) the rootViewcontroller of each tab.

The whole app will be managed by `CoordinatorSession.shared`, that holds a reference to `TabCoordinator` or `NCCoordinator`. To perform custom action on tab selection you can use `TabCoordinatorDelegate`:

```
CoordinatorSession.shared.tabCoordinator?.delegate = self
```

and then implement the method:

```
func reloadRootController(_ controller: EUIViewController, atIndex index: Int)
```

To install using cocoapods:
```
pod 'Lepaya-Coordinator'
```
Or just download/clone the repo and drag to your project the content of the 'Sources' folder.
