@preconcurrency import ProjectDescription

let project = Project(
    name: "Clipper",
    targets: [
        .target(
            name: "Clipper",
            destinations: .iOS,
            product: .app,
            bundleId: "com.clipper.app",
            deploymentTargets: .iOS("16.0"),
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
                .project(target: "ShareExtension", path: .relativeToRoot("Projects/ShareExtension")),
                .external(name: "FirebaseFirestore"),
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
