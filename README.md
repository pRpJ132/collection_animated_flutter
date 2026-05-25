# collection_animated

A Flutter package for smooth "add to cart" style fly animations. An item launches from any widget and flies in an arc to a target widget (cart, favorites, etc).

<img width="450" height="700" alt="Image" src="https://github.com/user-attachments/assets/3385ffdb-4dee-4d6c-b8f9-19d39161fcdd" />

## Features

- **Launch angle** — control the exact direction the item flies out (0–360°)
- **Back offset** — how far the item travels before heading to the target
- **Side offset** — lateral drift during the launch phase
- **Arc height** — how high the item arcs on its way to the target
- **Launch duration** — control the speed of the initial launch phase
- **Fly duration** — control the speed of the flight phase to the target
- **Scale animation** — optional shrink effect during flight
- **Scale range (launch)** — customize start and end scale during the launch phase
- **Scale range (fly)** — customize start and end scale during the fly phase
- **Opacity animation** — optional opacity effect during flight
- **Opacity range (launch)** — customize start and end opacity during the launch phase
- **Opacity range (fly)** — customize start and end opacity during the fly phase
- **onCompleted callback** — get notified when the animation finishes
- **GlobalKey-based** — no widget wrapping needed, just attach keys

## Getting started

Your State must use `TickerProviderStateMixin`:

```dart
class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
```

## Usage

**1. Create keys for the button and target:**

```dart
final GlobalKey cartKey   = GlobalKey();
final GlobalKey buttonKey = GlobalKey();
```

**2. Attach keys to your widgets:**

```dart
// Target (e.g. cart icon in AppBar)
Icon(Icons.shopping_cart, key: cartKey)

// Button (e.g. "Add" button)
ElevatedButton(key: buttonKey, ...)
```

**3. Create a `CollectionAnimated` instance:**

```dart
late final CollectionAnimated _anim;

@override
void initState() {
  super.initState();
  _anim = CollectionAnimated(
    vsync: this,
    buttonKey: buttonKey,
    targetKey: cartKey,
    flyWidget: const Icon(Icons.favorite, color: Colors.red, size: 40),
  );
}
```

**4. Call `startAnimation()` on tap:**

```dart
onPressed: () => _anim.startAnimation(),
```

### Full example

```dart
class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  final GlobalKey cartKey   = GlobalKey();
  final GlobalKey buttonKey = GlobalKey();

  late final CollectionAnimated _anim;

  @override
  void initState() {
    super.initState();
    _anim = CollectionAnimated(
      vsync: this,
      buttonKey: buttonKey,
      targetKey: cartKey,
      flyWidget: const Icon(Icons.favorite, color: Colors.red, size: 40),
      launchAngle: 270,   // fly upward
      backOffset: 80,     // travel 80px in launch direction
      sideOffset: 60,     // drift 60px sideways
      arcHeight: 180,     // arc height during flight
      scaleAnimated: true,
      onCompleted: () => print('Animation done!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.shopping_cart, key: cartKey, size: 32),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          key: buttonKey,
          onPressed: () => _anim.startAnimation(),
          child: const Text('Add to cart'),
        ),
      ),
    );
  }
}
```

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `vsync` | `TickerProvider` | required | Pass `this` from your State |
| `buttonKey` | `GlobalKey` | required | Key on the source widget |
| `targetKey` | `GlobalKey` | required | Key on the destination widget |
| `flyWidget` | `Widget` | required | The widget that flies |
| `launchAngle` | `double` | `270` | Launch direction in degrees (0=right, 90=down, 180=left, 270=up) |
| `backOffset` | `double` | `80` | Distance traveled in launch direction before flying to target |
| `sideOffset` | `double` | `60` | Lateral drift perpendicular to launch direction |
| `arcHeight` | `double` | `180` | Height of the arc during flight to target |
| `launchDuration` | `Duration` | `350ms` | Duration of the launch phase |
| `flyDuration` | `Duration` | `600ms` | Duration of the flight phase |
| `scaleAnimated` | `bool` | `false` | Whether the item shrinks during flight |
| `opacityAnimated` | `bool` | `false` | Changes transparency during the flight |
| `opacityValueStart1` | `double` | `0.1` | Opacity at the start of the launch phase |
| `opacityValueEnd1` | `double` | `1.0` | Opacity at the end of the launch phase |
| `opacityValueStart2` | `double` | `1.0` | Opacity at the start of the fly phase |
| `opacityValueEnd2` | `double` | `0.3` | Opacity at the end of the fly phase |
| `scaleValueStart1` | `double` | `0.1` | Scale at the start of the launch phase |
| `scaleValueEnd1` | `double` | `1.0` | Scale at the end of the launch phase |
| `scaleValueStart2` | `double` | `1.0` | Scale at the start of the fly phase |
| `scaleValueEnd2` | `double` | `0.5` | Scale at the end of the fly phase |
| `onCompleted` | `VoidCallback?` | `null` | Called when the animation completes |

## Additional information

- **Issues & feature requests** — open an issue on [GitHub](https://github.com/pRpJ132/collection_animated_flutter)
- **Contributions** — PRs are welcome! Please open an issue first to discuss what you'd like to change
- **License** — MIT
