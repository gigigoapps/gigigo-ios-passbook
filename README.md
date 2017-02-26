# GIGPassbook iOS

----
![Language](https://img.shields.io/badge/Language-Swift-orange.svg)
![Version](https://img.shields.io/badge/version-3.0-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Wrapper framework for download a passbook from an URL


## How to add it to my project?

Through Carthage

```
github "gigigoapps/gigigo-ios-passbook" ~> 3.0
```

## Usage Exampple

You only need to specify an url string:
```swift
Passbook().addPassbookFromUrl("http://host.com/path/passbook") { result in
  switch result {
  case .success:
    print("Passbook: downloaded successfully")
    
  case .unsupportedVersionError(_):
    print("Passbook: Unsupported version")

  case .error(let error):
    print(error)
	}
}
