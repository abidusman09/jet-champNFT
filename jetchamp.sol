// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Jetchamps is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    uint256 public constant MIN_TRANSFER_AMOUNT = 1 ether;
    uint256 public constant MAX_SUPPLY = 1000;
    uint256 public constant PRICE = 1 ether;

    constructor() ERC721("Jetchamps", "JETCH") {}
    
    function mint() public payable {
        require(_tokenIds.current() < MAX_SUPPLY, "All Jetchamps have been minted");
        require(msg.value >= PRICE, "Ether sent is not enough");
        require(balanceOf(msg.sender) == 0, "You have already minted a Jetchamp");
        
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
    }
    
    function transferJetchamp(address to, uint256 tokenId) public payable {
        require(msg.sender == ownerOf(tokenId), "You are not the owner of this Jetchamp");
        require(msg.value >= MIN_TRANSFER_AMOUNT, "Ether sent is not enough");
        
        transferFrom(msg.sender, to, tokenId);
    }
}
