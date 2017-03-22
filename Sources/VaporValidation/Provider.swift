import Vapor
@_exported import Validation

public final class Provider: Vapor.Provider {
    public init() {}
    public init(config: Config) {}

    public func boot(_ drop: Droplet) throws {
        let middleware = ValidationMiddleware()
        if let _ = drop.config.middleware {
            drop.addConfigurable(middleware: middleware, name: "validation")
        } else {
            drop.middleware.append(middleware)
        }
    }

    public func beforeRun(_ drop: Droplet) throws {}
}

extension Config {
    fileprivate var middleware: [String]? {
        return self["droplet", "middleware"]?.array?.flatMap { $0.string }
    }
}
