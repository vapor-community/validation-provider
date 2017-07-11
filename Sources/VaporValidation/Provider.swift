import Vapor
@_exported import Validation

@available(*, deprecated, message: "Please import ValidationProvider instead of VaporValidation.")
public final class Provider: Vapor.Provider {
    public static let repositoryName = "validation-provider"
    
    public init() {}
    public init(config: Config) {}

    public func boot(_ config: Config) throws {
        config.addConfigurable(
            middleware: ValidationMiddleware.init,
            name: "validation"
        )
    }
    
    public func boot(_ drop: Droplet) throws {}

    public func beforeRun(_ drop: Droplet) throws {}
}
