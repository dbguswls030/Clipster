//
//  Project.swift
//  Packages
//
//  Created by 유현진 on 11/16/24.
//

@preconcurrency import ProjectDescription

let project = Project(
    name: "ShareExtension",
    targets: [
        .target(
            name: "ShareExtension",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "com.clipper.ShareExtension",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "NSExtension": [
                    "NSExtensionAttributes": [
                        "NSExtensionActivationRule": [
                            "NSExtensionActivationSupportsImageWithMaxCount": 1,
                            "NSExtensionActivationSupportsWebURLWithMaxCount": 1
                        ]
                    ],
                    "NSExtensionMainStoryboard": "MainInterface",
                    "NSExtensionPointIdentifier": "com.apple.share-services"
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: "ShareExtension.entitlements",
            dependencies: [
                
            ]
        )
    ]
)
