# Htp

A tiny and simple HTTP client for RESTful APIs, written in Swift.

## Features

- Build on top of Swift Codable (No more JSON encoding/decoding headhack).
- Really clean syntax / few lines of code thanks to Swift 5 Result type.
- Customizable with default headers and default HTTP session.
- cURL like logs in the console for debugging purpose.
- HTTP Headers and Media types libraries.
- No dependency !

## Setup

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
struct API {

    struc User {
        static func all() -> Endpoint<Void, [User]> {
            return Endpoint(
                method: .get,
                path: "/users"
            )
        }
        
        static func one(id: Int) -> Endpoint<Void, User> {
            return Endpoint(
                method: .get,
                path: "/users/\(id)",
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

Client.shared.fetch(API.User.all()) { (result) in
    switch result {
    case .success(let users, let response):
        print(users)
        break
    case .failure(let error):
        print(error)
    }
}

Client.shared.fetch(API.User.create(name: "John", age: 32)) { (result) in
   switch result {
   case .success(let user, let response):
       print(user)
       break
   case .failure(let error):
       print(error)
   }
}

```

## History

- 0.9.0: Initial Release

## Contribution

Please, feel free to give feedback by opening an issue, or even better by forking and submitting a PR ! ;)
