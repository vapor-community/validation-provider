import Vapor // not @testable to ensure Middleware classes are public
import XCTest
import HTTP
import VaporValidation
import Validation

extension String: Swift.Error {}

class MiddlewareTests: XCTestCase {
    static let allTests = [
        ("testValidationMiddleware", testValidationMiddleware),
    ]

    func testValidationMiddleware() throws {
        var config = Config([:])
        try config.set("droplet.middleware", ["error", "validation"])
        try config.addProvider(VaporValidation.Provider.self)
        
        let drop = try Droplet(config)
        
        drop.get("*") { req in
            let path = req.uri.path
            try path.validated(by: Count.max(10))
            return path
        }

        // only added validation, abort won't be caught.
        drop.get("uncaught") { _ in throw Abort.notFound }

        let request = try Request(method: .get, uri: "http://0.0.0.0/thisPathIsWayTooLong")
        let response = try drop.respond(to: request)
        let json = response.json
        XCTAssertEqual(json?["error"]?.bool, true)
        XCTAssertEqual(json?["message"]?.string, "Validation failed with the following errors: \'Validator Error: Count<String> failed validation: /thisPathIsWayTooLong count 21 is greater than maximum 10\n\nIdentifier: Validation.ValidatorError.failure\'")
        let fail = try Request(method: .get, uri: "http://0.0.0.0/uncaught")
        let failResponse = try drop.respond(to: fail)
        XCTAssertEqual(failResponse.status, .notFound)
    }
}

class FooMiddleware: Middleware {
    init() {}
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        request.headers["foo"] = "bar"
        let response = try next.respond(to: request)
        response.headers["bar"] = "baz"
        return response
    }
}
