// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {

    // OpenZeppelin が tokenIds を簡単に追跡するために提供するライブラリを呼び出しています
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // 単語を画像化するためのSVG
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // 各文字列配列から単語を選択して組み合わせるために使用
    string[] firstWords = ["Epic", "Fantastic", "Crude", "Crazy", "Hysterical", "Grand"];
    string[] secondWords = ["Meta", "Live", "Pop", "Cute", "Sweet", "Hot"];
    string[] thirdWords = ["Kitten", "Puppy", "Monkey", "Bird", "Panda", "Elephant"];

    // フロント側でtokenIdを取得できるようなeventを作成
    event NewEpicNFTMinted(address sender, uint256 tokenId);

    // NFT トークンの名前とそのシンボルを渡します。
    constructor() ERC721 ("SquareNFT", "SQUARE") {
      console.log("This is my NFT contract.");
    }

    // シードを生成する関数を作成します。
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // 1個目の単語を選ぶ関数
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {

        // pickRandomFirstWord 関数のシードとなる rand を作成します。
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));

        // seedを出力
        console.log("rand seed: ", rand);

        // 選択する単語のインデックスを取得
        rand = rand % firstWords.length;

        // firstWords配列から何番目の単語が選ばれるかターミナルに出力する。
        console.log("rand first word: ", rand);
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    // ユーザーが NFT を取得するために実行する関数です。
    function makeAnEpicNFT() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        // 3つの配列からそれぞれ1つの単語をランダムに取り出します。
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        string memory combinedWord = string(abi.encodePacked(first, second, third));

        // 3つの単語を連結して、<text>タグと<svg>タグで閉じます。
        string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

	      // NFTに出力されるテキストをターミナルに出力します。
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        // JSONファイルを所定の位置に取得し、base64としてエンコードします。
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // データの先頭に data:application/json;base64 を追加します。
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n----- Token URI ----");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        // msg.sender を使って NFT を送信者に Mint します。
        _safeMint(msg.sender, newItemId);

        // tokenURIを設定
        _setTokenURI(newItemId, finalTokenUri);

        // NFTがいつ誰に作成されたかを確認します。
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}