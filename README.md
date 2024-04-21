# Project summary
https://github.com/unchain-tech/UNCHAIN-projects/tree/main/docs/ETH-NFT-Collection/ja/section-0

# NFT概要
eip721 https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md

opensea要約 https://zenn.dev/hayatoomori/articles/f26cc4637c7d66

NFT: コントラクト内のマッピング（address -> jsonを返すtokenUri）

## オフチェーンNFT
tokenUriにeip721準拠のjsonを返すwebURLを設定 など
## オンチェーンNFT
画像なら・・・
1. svgを作成
2. 1.をbase64エンコード
3. 2.を ```data:image/svg+xml;base64,<base64EncodedSVG>``` にする
4. 3.をimage属性として持つeip721準拠のjsonを作成
5. 4.をbase64エンコード
6. 5.を ```data:application/json;base64,<base64EncodedJSON>```の形式でtokenUriに設定

# Refs
NFTviewer https://gemcase.vercel.app/
## オフチェーンNFT
JSONデータのホスティングサービス https://www.npoint.io/

画像の無料アップロードサービス https://imgur.com/
## オンチェーンNFT
SVGviewer https://www.svgviewer.dev/

base64エンコード https://www.utilities-online.info/base64

# コントラクト再デプロイ時の注意点
1. 再デプロイ。yarn contract deploy:sepoliaを実行
2. App.jsのCONTRACT_ADDRESSを更新
3. ABIファイルpackages/client/src/utils/MyEpicNFT.json を更新