import PackageDescription

let package = Package(
    name: "VaporValidation",
    dependencies: [
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
