//
//  Project.swift
//  Packages
//
//  Created by 유현진 on 11/15/24.
//


@preconcurrency import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.Clipster.domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
            ]
        ),
    ]
)
