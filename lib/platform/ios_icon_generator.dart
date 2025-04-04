import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import '../model/icon_template.dart';

/// iOS向けアイコン生成クラス
class IOSIconGenerator {
  /// iPhoneとiPad用のアイコンテンプレートリスト
  static final List<IconTemplate> iosIconTemplates = _createIosIconTemplates();

  /// iOS用のアイコンを生成
  static void generateIcons(img.Image originalImage) {
    print('iOS用アイコンを生成中...');

    // 出力ディレクトリ
    final outputDir = Directory('build/ios/AppIcon.appiconset');
    outputDir.createSync(recursive: true);

    // 各サイズを生成
    final List<Map<String, dynamic>> images = [];

    for (var template in iosIconTemplates) {
      final width = (template.size * template.scale).toInt();
      final height = (template.size * template.scale).toInt();

      // 画像をリサイズ
      final resized =
          img.copyResize(originalImage, width: width, height: height);

      // ファイル名
      final filename = template.filename;
      final filePath = path.join(outputDir.path, filename);

      // PNGとして書き出し
      final pngBytes = img.encodePng(resized);
      File(filePath).writeAsBytesSync(pngBytes);

      // Contents.json用のメタデータ
      images.add(template.toContentsJsonMap());

      print('iOS用アイコン作成: $filename (${width}x$height)');
    }

    // Contents.jsonを生成
    final contents = {
      'images': images,
      'info': {'version': 1, 'author': 'app_icon_gen'}
    };

    // JSON出力
    final contentsFile = File(path.join(outputDir.path, 'Contents.json'));
    contentsFile.writeAsStringSync(jsonEncode(contents), flush: true);

    print('iOS用アイコンのContents.jsonを生成しました');
    print('iOS用アイコンの生成が完了しました。');
  }

  /// iOS用のアイコンテンプレートを作成
  static List<IconTemplate> _createIosIconTemplates() {
    return [
      // iPhone用アイコン
      IconTemplate(
          size: 20,
          scale: 1,
          idiom: 'iphone',
          filename: 'Icon-App-20x20@1x.png'),
      IconTemplate(
          size: 20,
          scale: 2,
          idiom: 'iphone',
          filename: 'Icon-App-20x20@2x.png'),
      IconTemplate(
          size: 20,
          scale: 3,
          idiom: 'iphone',
          filename: 'Icon-App-20x20@3x.png'),
      IconTemplate(
          size: 29,
          scale: 1,
          idiom: 'iphone',
          filename: 'Icon-App-29x29@1x.png'),
      IconTemplate(
          size: 29,
          scale: 2,
          idiom: 'iphone',
          filename: 'Icon-App-29x29@2x.png'),
      IconTemplate(
          size: 29,
          scale: 3,
          idiom: 'iphone',
          filename: 'Icon-App-29x29@3x.png'),
      IconTemplate(
          size: 40,
          scale: 2,
          idiom: 'iphone',
          filename: 'Icon-App-40x40@2x.png'),
      IconTemplate(
          size: 40,
          scale: 3,
          idiom: 'iphone',
          filename: 'Icon-App-40x40@3x.png'),
      IconTemplate(
          size: 60,
          scale: 2,
          idiom: 'iphone',
          filename: 'Icon-App-60x60@2x.png'),
      IconTemplate(
          size: 60,
          scale: 3,
          idiom: 'iphone',
          filename: 'Icon-App-60x60@3x.png'),

      // iPad用アイコン
      IconTemplate(
          size: 20, scale: 1, idiom: 'ipad', filename: 'Icon-App-20x20@1x.png'),
      IconTemplate(
          size: 20, scale: 2, idiom: 'ipad', filename: 'Icon-App-20x20@2x.png'),
      IconTemplate(
          size: 29, scale: 1, idiom: 'ipad', filename: 'Icon-App-29x29@1x.png'),
      IconTemplate(
          size: 29, scale: 2, idiom: 'ipad', filename: 'Icon-App-29x29@2x.png'),
      IconTemplate(
          size: 40, scale: 1, idiom: 'ipad', filename: 'Icon-App-40x40@1x.png'),
      IconTemplate(
          size: 40, scale: 2, idiom: 'ipad', filename: 'Icon-App-40x40@2x.png'),
      IconTemplate(
          size: 76, scale: 1, idiom: 'ipad', filename: 'Icon-App-76x76@1x.png'),
      IconTemplate(
          size: 76, scale: 2, idiom: 'ipad', filename: 'Icon-App-76x76@2x.png'),
      IconTemplate(
          size: 83.5,
          scale: 2,
          idiom: 'ipad',
          filename: 'Icon-App-83.5x83.5@2x.png'),

      // App Store用
      IconTemplate(
          size: 1024,
          scale: 1,
          idiom: 'ios-marketing',
          filename: 'Icon-App-1024x1024@1x.png'),
    ];
  }
}
