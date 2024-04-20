// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {

    // OpenZeppelin が tokenIds を簡単に追跡するために提供するライブラリを呼び出しています
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721 ("TanyaNFT", "TANYA") {
      console.log("This is my NFT contract.");
    }

    // ユーザーが NFT を取得するために実行する関数です。
    function makeAnEpicNFT() public {
      _tokenIds.increment();
      uint256 newItemId = _tokenIds.current();

       // msg.sender を使って NFT を送信者に Mint します。
      _safeMint(msg.sender, newItemId);

      // NFT データを設定します。
      _setTokenURI(newItemId, "https://api.npoint.io/30b263bbf79d249d6048");

      // NFTがいつ誰に作成されたかを確認します。
      console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}