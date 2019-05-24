# SwiftEcho
A Swift wrapper for Laravel Echo (WIP)

## TODO
 - [x] Socket.IO implementation
 - [ ] Pusher implementation
 - [ ] RxSwift support
 - [ ] Crossplatform support
 - [ ] Tests
## Installation
### Carthage
Add the following to your cartfile

```
github "onlinesalon/SwiftEcho" ~> 1.1.0
```
Run carthage update

```
carthage update SwiftEcho --platform ios
```
:orange_book: After installation, add the following packages to your project from Carthage/Build/Ios

- SwiftEcho
- Starscream
- SocketIO

## Usage
Import the package
```
import SwiftEcho
```

### Initialize Echo instance

```
class ViewController: UIViewController {
    
    private var echoClient: EchoClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Authentication details
        let authToken = "auth_token"
        let auth = ["headers": ["Authorization": "Bearer \(authToken)"]]
        
        // Init the client with configuration
        self.echoClient = EchoClient(config: [
            .broadcaster(.socketIO),
            .host("https://api-host.com"),
            .auth(auth)])
        
    }
}
```

## Available options
|     Name        |    Default value    | Information                                                                       |
|:---------------:|:-------------------:|-----------------------------------------------------------------------------------|
| `.broadcaster`  | nil                 | Broadcaster instance. (Currently only socket.io is supported)                     |
| `.auth`         | []                  | Authentication values. Use this for passing authentication headers. (See example) |
| `.authEndpoint` | "broadcasting/auth" | The default laravel echo server endpoint                                          |
| `.host`         | ""                  | Address for the server hosting the socket                                         |
| `.key`          | ""                  | Pusher key (WIP)                                                                  |
| `.namespace`    | "App.Events"        | Default laravel echo server namespace                                             |

### Channel connection
#### SocketIO
```
echoClient.connect { (data, ack) in
    // Do something after the connection is established
    ...
}
```
:orange_book: Joining and listening to a channel must be done after a successfull connection.

### Listen to a channel
```
echoClient.join(channel: "chat.\(chatId)")
    .listen("comment.created", { (data, ack) in
        ...
    })
```

### Listen to a private channel
```
echoClient.join(privateChannel: "private_chat.\(chatId)")
    .listen("comment.created", { (data, ack) in
        ...
    })
```

### Joining a presence channel
```
echoClient.join(presenceChannel: "users.\(chatId)")
    .here({ (data, ack) in
        ...
    })
    .joining({ (data, ack) in
        ...
    })
    .leaving({ (data, ack) in
        ...
    })
```
