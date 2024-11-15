//
//  Project.swift
//  Packages
//
//  Created by 유현진 on 11/15/24.
//

@preconcurrency import ProjectDescription

let project = Project(
    name: "Presentation",
    targets: [
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.Clipster.Presentation",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
            ]
        ),
    ]
)
