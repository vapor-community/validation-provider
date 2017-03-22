import PackageDescription

let package = Package(
    name: "VaporValidation",
    dependencies: [
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 0),
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),
    ]
)
