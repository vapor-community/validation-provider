import PackageDescription

let package = Package(
    name: "ValidationProvider",
    dependencies: [
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
