# … LeaderView

![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-blue)

`LeaderView` is a configurable typographical element that renders a baseline "leader line" from one view to the next, as found in a book index:

```
Chapter One: The Dottening ……………………………… 1
Chapter Two: The Dots Return ………………………… 12
Chapter Three: These Things Again?! ……… 18
...
Chapter Twenty-Six: Where
the Hell Are They All
Coming From?!             ………………………………… 206
```

## Features

You can configure:

* Inter-view spacing
* Inter-dot spacing
* Dot diameter
* Dot color
* Layout Priority (leading / trailing views)
* Vertical alignment (default/best is last-baseline)


### Example

To create a simple leader:

```swift
import LeaderView

Leader {
  Text("Chapter One: The Dottening")
    .font(.title2)
} trailingView: {
  Text("1")
    .font(.title3)
    .monospaced()
    }
```

To get all fancy with it:

```swift
import LeaderView

Leader(
  dotDiameter: dotDiameter,
  viewSpacing: viewSpacing,
  dotSpacing: dotSpacing,
  minLeaderWidth: minLeaderWidth
) {
  Text("Introduction")
    .font(.title2)
} trailingView: {
  Text("ii")
    .font(.title3)
    .monospaced()
    .italic()
}
```

### Contributing
Contributions are welcome! If you'd like to contribute to LeaderView, please fork the repository and submit a pull request.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
