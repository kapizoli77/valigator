// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "Valigator",
                      platforms: [.iOS(.v11)],
                      products: [.library(name: "Valigator",
                                          targets: ["Valigator"])],
                      targets: [.target(name: "Valigator",
                                        path: "Source")],
                      swiftLanguageVersions: [.v5])
