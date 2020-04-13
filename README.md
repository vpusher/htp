# Htp

A tiny and simple HTTP client for RESTful APIs, written in Swift.

## Features

- Build on top of Swift Codable (No more JSON encoding/decoding headhack).
- Really clean syntax / few lines of code thanks to Swift 5 Result type.
- Customizable with default headers and default HTTP session.
- cURL like logs in the console for debugging purpose.
- HTTP Headers and Media types libraries.
- Crossplatform (Linux, macOS, iOS, tvOS, watchOS)
- No dependency !

## Setup

Add the Swift package `https://github.com/vpusher/htp` as a new dependency:

- From another package, edit your `Package.swift` file,

```swift
dependencies: [
    ...
    .package(
        url: "https://github.com/vpusher/htp",
        from: "0.9.2"
    )
]
```

- From an XCode project, select **File** > **Swift Packages** > **Add Package Dependency** and enter its repository URL.

That's it.

### Define a model/entity

```swift

struct User: Encodable, Decodable {
   let id: Int? = nil
   let name: String
   let age: Int
}

```

### Define an endpoint

```swift
import Htp

struct API {

    struct Users {
        static func all() -> Endpoint<Void, [User]> {
            return Endpoint(
                method: .get,
                path: "/users"
            )
        }
        
        static func one(id: Int) -> Endpoint<Void, User> {
            return Endpoint(
                method: .get,
                path: "/users/\(id)"
            )
        }
        
        static func create(name: String, age: Int) -> Endpoint<User, User> {
            return Endpoint(
                method: .post,
                path: "/users",
                body: User(name: name, age: age)
            )
        }
    }

}
```

### Use

```swift
import Htp

Client.shared.fetch(API.Users.all()) { (result) in
    switch result {
    case .success(let users, let response):
        print(users)
        break
    case .failure(let error):
        print(error)
    }
}

Client.shared.fetch(API.Users.create(name: "John", age: 32)) { (result) in
   switch result {
   case .success(let user, let response):
       print(user)
       break
   case .failure(let error):
       print(error)
   }
}

```

## Advanced

Here is a more advanced example with common use cases encountered while performing requests against an API.

```swift
import Foundation
import Htp

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]                               // Handling of nested complex types.
    
    struct Ability: Decodable {
        let isHidden: Bool
        let slot: Int
        let ability: Detail
        
        struct Detail: Decodable {
            let name: String
            let url: URL
        }
        
        enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"                    // Handling of custom property names while encoding/decoding
            case slot
            case ability
        }
    }
}

struct API {
        
    static func get(id: Int) -> Endpoint<Void, Pokemon> {
        return Endpoint(
            method: .get,
            path: "/pokemon/\(id)"
        )
    }
}

let client = Client(
    baseURL: URL(string: "https://pokeapi.co/api/v2")!,   // Set custom base URL.
    baseHeaders: ["X-API-Key": "xxxxx"]                   // Set custom default headers like API keys.
)

client.fetch(API.get(id: 1)) { (result) in
   switch result {
   case .success(let pokemon, let response):              // Catch decoded model and full response object.
       print(pokemon)
       break
   case .failure(let error):
       print(error)
   }
}

```

## Contribution

Please, feel free to give feedback by opening an issue, or even better by forking and submitting a PR ! ;)
