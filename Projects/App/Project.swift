@preconcurrency import ProjectDescription

let project = Project(
    name: "Clipster",
    targets: [
        .target(
            name: "Clipster",
            destinations: .iOS,
            product: .app,
            bundleId: "com.Clipster.Clipster",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Data", path: .relativeToRoot("Projects/Data")),
                .project(target: "Presentation", path: .relativeToRoot("Projects/Presentation")),
            ]
        ),
//        .target(
//            name: "ClipsterTests",
//            destinations: .iOS,
//            product: .unitTests,
//            bundleId: "io.tuist.ClipsterTests",
//            infoPlist: .default,
//            sources: ["Clipster/Tests/**"],
//            resources: [],
//            dependencies: [.target(name: "Clipster")]
//        ),
    ]
)
