SwiftEcho
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
github "onlinesalon/SwiftEcho" ~> 1.0.1
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

### Initialize Echo instance with options

```
class ViewController: UIViewController {
    
    private var echoClient: EchoClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options: [String: Any] = [
            "host": "https://host.address.com",
            "auth": [
                "headers": [
                    "Authorization": "Bearer " + "token"
                ]
            ]
        ]
        
        self.echoClient = EchoClient(options: options)
    }
}
```

## Available options
|     Name     |    Default value    | Information                                                                       |
|:------------:|:-------------------:|-----------------------------------------------------------------------------------|
| auth         | "headers": []       | Authentication values. Use this for passing authentication headers. (See example) |
| authEndpoint | "broadcasting/auth" | The default laravel echo server endpoint                                          |
| broadcaster  | "socket.io"         | Broadcaster instance. (Currently only socket.io is supported)                     |
| host         | ""                  | Address for the server hosting the socket                                         |
| key          | ""                  | Pusher key (WIP)                                                                  |
| namespace    | "App.Events"        | Default laravel echo server namespace                                             |

### Channel connection
```
echoClient.connected { (data, ack) in
    ...
}
```
:orange_book: Joining and listening to a channel must be done after a successfull connection.

### Listen to a channel
```
echoClient.join(channel: "chat.\(chatId)")
    .listen(event: "comment.created", callback: { (data, ack) in
        ...
    })
```
### Joining a presence channel
```
echoClient.join(presenceChannel: "users.\(chatId)")
    .here(callback: { (data, ack) in
        ...
    })
    .joining(callback: { (data, ack) in
        ...
    })
    .leaving(callback: { (data, ack) in
        ...
    })
```
