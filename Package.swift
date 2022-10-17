// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IPaUIKitHelper",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "IPaUIKitHelper",
            targets: ["IPaUIKitHelper"]),
        .library(
            name: "IPaImageURL",
            targets: ["IPaImageURL"]),
        .library(
            name: "IPaButtonStyler",
            targets: ["IPaButtonStyler"]),
        .library(
            name: "IPaFitContent",
            targets: ["IPaFitContent"]),
        .library(
            name: "IPaUIKit",
            targets: ["IPaUIKit"]),
        .library(
            name: "IPaNestedScrollView",
            targets: ["IPaNestedScrollView"]),
        .library(
            name: "IPaStoryboard",
            targets: ["IPaStoryboard"]),
        .library(
            name: "IPaPickerUI",
            targets: ["IPaPickerUI"]),
        .library(
            name: "IPaIndicator",
            targets: ["IPaIndicator"]),
        .library(
            name: "IPaProgressIndicator",
            targets: ["IPaProgressIndicator"]),
        .library(
            name: "IPaDataPager",
            targets: ["IPaDataPager"]),
        .library(
            name: "IPaToast",
            targets: ["IPaToast"]),
        .library(
            name: "IPaNetworkState",
            targets: ["IPaNetworkState"]),
        .library(
            name: "IPaTokenView",
            targets: ["IPaTokenView"])
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/ipapamagic/IPaLog.git", from: "3.1.0"),
        .package(url: "https://github.com/ipapamagic/IPaImageTool.git", from: "2.6.0"),
        .package(url: "https://github.com/ipapamagic/IPaFileCache.git", from: "1.2.0"),
        .package(url: "https://github.com/ipapamagic/IPaDownloadManager.git", from: "1.4.0"),
        .package(url: "https://github.com/ipapamagic/IPaURLResourceUI.git", from: "5.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IPaUIKitHelper",
            dependencies: [.product(name: "IPaImageTool", package: "IPaImageTool"),
                           .product(name: "IPaLog", package: "IPaLog")],
            path:"Sources/IPaUIKitHelper"
        ),
        .target(
            name: "IPaImageURL",
            dependencies: [.product(name: "IPaDownloadManager", package: "IPaDownloadManager"),
                                                .product(name: "IPaFileCache", package: "IPaFileCache"),
                                                .product(name: "IPaLog", package: "IPaLog")],
            path:"Sources/IPaImageURL"
        ),
        .target(
            name: "IPaButtonStyler",
            dependencies: [],
            path:"Sources/IPaButtonStyler"
        ),
        .target(
            name: "IPaFitContent",
            dependencies: ["IPaUIKitHelper"],
            path:"Sources/IPaFitContent"
        ),
        .target(
            name: "IPaUIKit",
            dependencies: [],
            path:"Sources/IPaUIKit"
        ),
        .target(
            name: "IPaNestedScrollView",
            dependencies: ["IPaFitContent"],
            path:"Sources/IPaNestedScrollView"
        ),
        .target(
            name: "IPaStoryboard",
            dependencies: ["IPaUIKitHelper"],
            path:"Sources/IPaStoryboard"
        ),
        .target(
            name: "IPaPickerUI",
            dependencies: [],
            path:"Sources/IPaPickerUI"
        ),
        .target(
            name: "IPaIndicator",
            dependencies: [],
            path:"Sources/IPaIndicator"
        ),
        .target(
            name: "IPaProgressIndicator",
            dependencies: ["IPaIndicator",.product(name: "IPaDownloadManager", package: "IPaDownloadManager"),
                           .product(name: "IPaURLResourceUI", package: "IPaURLResourceUI"),],
            path:"Sources/IPaProgressIndicator"
        ),
        .target(
            name: "IPaDataPager",
            dependencies: [],
            path:"Sources/IPaDataPager"
        ),
        .target(
            name: "IPaToast",
            dependencies: ["IPaUIKit","IPaUIKitHelper"],
            path:"Sources/IPaToast"
        ),
        .target(
            name: "IPaNetworkState",
            dependencies: [],
            path:"Sources/IPaNetworkState"
        ),
        .target(
            name: "IPaTokenView",
            dependencies: [],
            path:"Sources/IPaTokenView"
        ),
        .testTarget(
            name: "IPaUIKitHelperTests",
            dependencies: ["IPaUIKitHelper"])
    ]
)
