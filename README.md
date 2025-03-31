# App Icon Generator

## Features

### iOS
- iPhone Icons
  - Notification icons (20pt @1x, @2x, @3x)
  - Settings icons (29pt @1x, @2x, @3x)
  - Spotlight icons (40pt @2x, @3x)
  - App icons (60pt @2x, @3x)
- iPad Icons
  - Notification icons (20pt @1x, @2x)
  - Settings icons (29pt @1x, @2x)
  - Spotlight icons (40pt @1x, @2x)
  - App icons (76pt @1x, @2x)
  - iPad Pro icons (83.5pt @2x)
- App Store icon (1024x1024)
- Automatic Contents.json generation

### Android
- Traditional icons (all densities)
  - mdpi (48x48)
  - hdpi (72x72)
  - xhdpi (96x96)
  - xxhdpi (144x144)
  - xxxhdpi (192x192)
- Adaptive icons (Android 8.0+)
  - Foreground layer (ic_launcher_foreground.png)
  - Background layer (ic_launcher_background.png)
  - Required XML resources
- Play Store icon (512x512)

## Directory Structure
```
lib/
├── app_icon_generator.dart  # メインのジェネレーター
├── cli.dart                 # コマンドライン処理
├── model/                   # データモデル
│   └── icon_template.dart   # アイコンテンプレートモデル
└── platform/               # プラットフォーム固有の処理
    ├── android_icon_generator.dart  # Android用ジェネレーター
    └── ios_icon_generator.dart      # iOS用ジェネレーター

bin/
└── app_icon_gen.dart       # エントリーポイント

test/
└── icon_generator_test.dart # テストコード
```

## Installation

### Prerequisites

- Dart SDK (2.17.0以上)

### Clone Repository

```bash
$ git clone https://github.com/yourusername/app_icon_gen.git
$ cd app_icon_gen
$ dart pub get
```

## Preparing Your Icon

ツールを使用する前に、ソース画像を準備する必要があります：

1. アプリアイコン用の正方形のPNG画像を作成または入手してください（推奨サイズ：1024x1024ピクセル）
2. プロジェクト内の `assets` ディレクトリに画像を配置してください

## Usage

### Basic usage

アイコンを生成するには、次のコマンドを実行します：

```bash
$ dart run bin/app_icon_gen.dart assets/your_icon.png
```

### Examples

**iOSアイコンのみ生成：**
```bash
$ dart run bin/app_icon_gen.dart -p ios assets/your_icon.png
```

**Androidアイコンのみ生成：**
```bash
$ dart run bin/app_icon_gen.dart -p android assets/your_icon.png
```

**両プラットフォーム用アイコンを生成：**
```bash
$ dart run bin/app_icon_gen.dart assets/your_icon.png
```

生成されたすべてのアイコンは、プロジェクトの `build/` ディレクトリに保存されます。

### iOS

```
build/ios/AppIcon.appiconset/
├── Contents.json
├── Icon-App-20x20@1x.png
├── Icon-App-20x20@2x.png
├── Icon-App-20x20@3x.png
├── ... (その他のサイズ)
└── Icon-App-1024x1024@1x.png
```

### Android

```
build/android/
├── mipmap-mdpi/
│   ├── ic_launcher.png
│   ├── ic_launcher_background.png
│   └── ic_launcher_foreground.png
├── mipmap-hdpi/
│   └── ... (同様のファイル)
├── ... (その他の解像度)
├── mipmap-anydpi-v26/
│   ├── ic_launcher.xml
│   └── ic_launcher_round.xml
├── values/
│   └── colors.xml
└── playstore/
    └── play_store_icon.png
```
