// deploy.js
async function main() {
  // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されます。
  // getContractFactory関数は、デプロイをサポートするライブラリのアドレスとMyEpicNFTコントラクトの連携を行っています。
  // Hardhat Runtime Environment（HRE）は、Hardhatが用意したすべての機能を含むオブジェクト（＝コードの束）です。
  // hardhatで始まるターミナルコマンドを実行するたびに、HREにアクセスしているので、hreをdeploy.jsにインポートする必要はありません。
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");

  // HardhatがローカルのEthereumネットワークを、コントラクトのためだけに作成します。
  // そして、スクリプトの実行が完了した後、そのローカル・ネットワークを破棄します。
  // つまり、コントラクトを実行するたびに、毎回ローカルサーバーを更新するかのようにブロックチェーンが新しくなります。
  const nftContract = await nftContractFactory.deploy();

  // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待ちます。
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);
  // makeAnEpicNFT 関数を呼び出す。NFT が Mint される。
  let txn = await nftContract.makeAnEpicNFT();
  // Minting が仮想マイナーにより、承認されるのを待つ。
  await txn.wait();
  console.log('Minted NFT #1');
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});