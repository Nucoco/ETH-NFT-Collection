const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { ethers } = require('hardhat');
const { expect } = require('chai');

describe('MyEpicNFT', function () {
  // 各テストの前に呼び出す関数
  // テストで使用する変数やコントラクトのデプロイを行う
  async function deployMyEpicNFTFixture() {
    // テストアカウントの用意
    const [owner] = await ethers.getSigners();

    // コントラクト内で使用する単語の配列
    const firstWords = ['Epic', 'Fantastic', 'Crude', 'Crazy', 'Hysterical','Grand'];
    const secondWords = ['Meta', 'Live', 'Pop', 'Cute', 'Sweet', 'Hot'];
    const thirdWords = ['Kitten', 'Puppy', 'Monkey', 'Bird', 'Panda', 'Elephant'];

    // コントラクトのインスタンスを生成し、デプロイを行います。
    const MyEpicNFTFactory = await ethers.getContractFactory('MyEpicNFT');
    const MyEpicNFT = await MyEpicNFTFactory.deploy();

    return { MyEpicNFT, owner, firstWords, secondWords, thirdWords };
  }

  describe('pickRandomFirstWord', function () {
    it('should get strings in firstWords', async function () {
      // テストの準備
      const { MyEpicNFT, firstWords } = await loadFixture(deployMyEpicNFTFixture);
      // テスト
      expect(firstWords).to.include(await MyEpicNFT.pickRandomFirstWord(0));
    });
  });

  describe('pickRandomSecondWord', function () {
    it('should get strings in secondWords', async function () {
      const { MyEpicNFT, secondWords } = await loadFixture(deployMyEpicNFTFixture);
      expect(secondWords).to.include(await MyEpicNFT.pickRandomSecondWord(0));
    });
  });

  describe('pickRandomThirdWord', function () {
    it('should get strings in thirdWords', async function () {
      const { MyEpicNFT, thirdWords } = await loadFixture(deployMyEpicNFTFixture);
      expect(thirdWords).to.include(await MyEpicNFT.pickRandomThirdWord(0));
    });
  });

  describe('makeAnEpicNFT', function () {
    it('emit a NewEpicNFTMinted event', async function () {
      const { MyEpicNFT, owner } = await loadFixture(deployMyEpicNFTFixture);

      await expect(MyEpicNFT.makeAnEpicNFT())
        .to.emit(MyEpicNFT, 'NewEpicNFTMinted')
        .withArgs(owner.address, 1);
    });
  });
});