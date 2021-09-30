# Welcome to Engage Digital Messaging sample apps

Here you can find 2 examples of iOS integration with [Engage Digital Messaging](http://mobile-messaging.dimelo.com).

- [An iOS integration relying on CocoaPods](https://github.com/ringcentral-tutorials/engage-digital-messaging-ios-demo/tree/master/CocoaPods%20Install)
- [An iOS integration relying on manual install](https://github.com/ringcentral-tutorials/engage-digital-messaging--ios-demo/tree/master/Manual%20Install)

<br>

ℹ️ The `RcConfigSource.json` file should be edited in order to connect this application to your Engage Digital Messaging channel.

Here is the file structure:
```json
[
  {
    "name": "CHANGE_HERE",
    "description": "CHANGE_HERE",
    "domainName": "CHANGE_HERE",
    "apiSecret": "CHANGE_HERE",
    "hostname": "CHANGE_HERE"
  }
]
```

| Parameter     | Description                                                                                           | Mandatory                                               |
| ------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `name`        | Informative text                                                                                      | NO                                                      |
| `description` | Informative text                                                                                      | NO                                                      |
| `domainName`  | Your Engage Digital domain name                                                                       | **YES**                                                 |
| `apiSecret`   | Your Engage Digital Messaging channel API secret                                                      | **YES**                                                 |
| `hostname`    | Engage Digital Messaging hostname including the leading `.` (ask your Engage Digital project manager) | NO (defaults to `.messaging.dimelo.com` if not present) |

<br>

Please refer to [home documentation](http://mobile-messaging.dimelo.com) for details
