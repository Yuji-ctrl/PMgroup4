# PM4 - プロジェクションマッピング作品

## 概要
Processingで制作したインタラクティブなプロジェクションマッピング作品です。
6つのスクリーンに対して映像を投影し、キー操作で画面の切り替えや視覚効果の変更ができます。
Keystoneライブラリを使用した台形補正機能により、実際の投影面に合わせた映像調整が可能です。

## 主な機能
- **6画面マルチ投影**: 6つの独立したスクリーンへ同時投影
- **画像切り替え**: 各スクリーンに2種類の画像を切り替え表示
- **サウンド再生**: BGMと効果音の再生機能
- **Keystone補正**: 投影面に合わせた台形補正機能
- **3つの表示モード**: 画像表示、単色背景、カラーグリッド表示

## 必要な環境
### ソフトウェア
- Processing 3.x 以降
- Java 8 以降

### 必要なライブラリ
- **Keystone** (deadpixel.keystone.*) - プロジェクションマッピング補正用
- **Minim** (ddf.minim.*) - オーディオ再生用

ライブラリのインストール方法:
1. Processingを起動
2. メニューから `Sketch` → `Import Library` → `Add Library...`
3. 検索窓で "Keystone" と "Minim" を検索してインストール

## ファイル構成
```
PM4/
└── sketch_251121aSound_/
    ├── sketch_251121aSound_.pde  # メインプログラム
    ├── SurfaceBase.pde           # サーフェス描画クラス
    ├── keystone.xml              # Keystone設定ファイル
    └── data/
        ├── mario_bgm.mp3         # BGM音源
        ├── marioDokan.mp3        # 効果音
        ├── screen1-1.jpg         # スクリーン1用画像1
        ├── screen1-2.jpg         # スクリーン1用画像2
        ├── screen2-1.jpg         # スクリーン2用画像1
        ├── screen2-2.jpg         # スクリーン2用画像2
        ├── screen3-1.jpg         # スクリーン3用画像1
        ├── screen3-2.jpg         # スクリーン3用画像2
        ├── screen4-1.jpg         # スクリーン4用画像1
        ├── screen4-2.jpg         # スクリーン4用画像2
        ├── screen5-1.jpg         # スクリーン5用画像1
        ├── screen5-2.jpg         # スクリーン5用画像2
        ├── screen6-1.jpg         # スクリーン6用画像1
        └── screen6-2.jpg         # スクリーン6用画像2
```

## 使い方
### 1. セットアップ
1. リポジトリをクローンまたはダウンロード
```bash
git clone https://github.com/natsukik06/PM4.git
```
2. Processingで `sketch_251121aSound_.pde` を開く
3. 必要なライブラリがインストールされていることを確認

### 2. 画像と音声ファイルの準備
- `data/` フォルダに画像ファイル（screen1-1.jpg ～ screen6-2.jpg）を配置
- BGM（mario_bgm.mp3）と効果音（marioDokan.mp3）を配置
- ファイル名を変更する場合は、コード内の設定を編集してください

### 3. 実行
1. Processingで実行ボタンをクリック
2. フルスクリーンで起動します

## キー操作
| キー | 機能 |
|------|------|
| `c` | Keystoneキャリブレーションモードの切り替え |
| `l` | Keystone設定の読み込み |
| `s` | Keystone設定の保存 |
| `t` | ランダムな画面の画像を切り替え（効果音再生） |
| `0` | 画像表示モード |
| `1` | 単色背景表示モード |
| `2` | カラーグリッド表示モード |

### Keystoneキャリブレーション方法
1. `c` キーを押してキャリブレーションモードを有効化
2. 各スクリーンの四隅のポイントをドラッグして位置調整
3. 投影面に合わせて台形補正を実施
4. `s` キーで設定を保存
5. `c` キーでキャリブレーションモードを終了

## プログラムの構造
### メインプログラム（sketch_251121aSound_.pde）
- 6つのSurfaceBaseインスタンスを管理
- キー入力処理
- 音声再生制御
- ランダムな画面選択ロジック

### SurfaceBaseクラス（SurfaceBase.pde）
- 各スクリーンの描画処理
- 画像の切り替え機能
- 3つの表示モード（画像/単色/グリッド）の実装
- Keystoneサーフェスの管理

## カスタマイズ
### 画像ファイルの変更
コード内の `fileList` 配列を編集：
```processing
String[][] fileList = {
  { "your_image1-1.jpg", "your_image1-2.jpg" },
  // ...
};
```

### 音声ファイルの変更
```processing
String bgmFileName = "your_bgm.mp3";
String seFileName = "your_se.mp3";
```

### スクリーン数の変更
```processing
int n_img = 6;  // スクリーン数を変更
```
対応する画像ファイルと `fileList` の配列サイズも調整してください。

## 技術仕様
- **解像度**: 各スクリーン 300x300px
- **フレームレート**: 30 fps
- **レンダラー**: P3D（Processing 3D）
- **カラーモード**: RGB 256階調

## トラブルシューティング
### 画像が表示されない
- `data/` フォルダに画像ファイルが正しく配置されているか確認
- ファイル名がコード内の設定と一致しているか確認
- 画像ファイルが破損していないか確認

### 音が再生されない
- Minimライブラリが正しくインストールされているか確認
- 音声ファイルが `data/` フォルダに存在するか確認
- 音声ファイルのフォーマットがサポートされているか確認（MP3推奨）

### Keystoneの設定が保存されない
- スケッチフォルダへの書き込み権限があるか確認
- `s` キーで設定を保存した後、プログラムを終了してください

## 制作情報
- **制作**: natsukik06, zhunpingsongben-cmyk， Yuji-ctrl
- **最終更新**: 2026年1月

## ライセンス
このプロジェクトは教育・研究目的で作成されました。

## 免責
本プロジェクトは任天堂とは一切関係ありません。
ゲーム画像・キャラクター等の著作権は任天堂に帰属します。
著作権データを含んでいたため除外してコードのみアップロードしたため、コミット履歴がありません

## 参考
- [Processing](https://processing.org/)
- [Keystone Library](https://github.com/davidbouchard/keystone)
- [Minim Library](https://code.compartmental.net/tools/minim/)
