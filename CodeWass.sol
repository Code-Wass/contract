pragma solidity ^0.8.17;
// SPDX-License-Identifier: MIT 
/**
      ___           ___           ___           ___                    ___           ___           ___           ___     
     /  /\         /  /\         /  /\         /  /\                  /  /\         /  /\         /  /\         /  /\    
    /  /::\       /  /::\       /  /::\       /  /::\                /  /:/_       /  /::\       /  /::\       /  /::\   
   /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:/\:\              /  /:/ /\     /  /:/\:\     /__/:/\:\     /__/:/\:\  
  /  /:/  \:\   /  /:/  \:\   /  /:/  \:\   /  /::\ \:\            /  /:/ /:/_   /  /::\ \:\   _\_ \:\ \:\   _\_ \:\ \:\ 
 /__/:/ \  \:\ /__/:/ \__\:\ /__/:/ \__\:| /__/:/\:\ \:\          /__/:/ /:/ /\ /__/:/\:\_\:\ /__/\ \:\ \:\ /__/\ \:\ \:\
 \  \:\  \__\/ \  \:\ /  /:/ \  \:\ /  /:/ \  \:\ \:\_\/          \  \:\/:/ /:/ \__\/  \:\/:/ \  \:\ \:\_\/ \  \:\ \:\_\/
  \  \:\        \  \:\  /:/   \  \:\  /:/   \  \:\ \:\             \  \::/ /:/       \__\::/   \  \:\_\:\    \  \:\_\:\  
   \  \:\        \  \:\/:/     \  \:\/:/     \  \:\_\/              \  \:\/:/        /  /:/     \  \:\/:/     \  \:\/:/  
    \  \:\        \  \::/       \__\::/       \  \:\                 \  \::/        /__/:/       \  \::/       \  \::/   
     \__\/         \__\/            ~~         \__\/                  \__\/         \__\/         \__\/         \__\/    
*/

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/ERC721A.sol";

contract CodeWass is Ownable, ERC721A  {
    uint256 public constant MAX_SUPPLY = 5000;
    uint256 public constant PRICE_PER_TOKEN = .03 ether;
    uint256 public constant MAX_PUBLIC_MINT = 5;

    string public provenance;
    bool public saleIsActive = false;
    bool public reservedMinted = false;
    string private _baseTokenURI ;
    
    // withdraw addresses
    address bacon = 0xb0F0951B1e2e22B7f0a666f727E7892898117A53;
    address crab = 0xb0F0951B1e2e22B7f0a666f727E7892898117A54;
    address undead = 0xb0F0951B1e2e22B7f0a666f727E7892898117A55;
    address groot = 0xb0F0951B1e2e22B7f0a666f727E7892898117A56;

    constructor(string memory baseTokenURI) ERC721A("Code: Wass", "WASS") {
        _baseTokenURI  = baseTokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function setProvenance(string memory _provenance) public onlyOwner {
        provenance = _provenance;
    }

    function setSaleState(bool newState) public onlyOwner {
        saleIsActive = newState;
    }

    function mint(uint amount) external payable {
        require(totalSupply() <= MAX_SUPPLY, "exceeded max supply");
        require(msg.value == PRICE_PER_TOKEN * amount, "invalid offer");
        _safeMint(msg.sender, amount);
    }

    function reservedMints() public onlyOwner {
        require(reservedMinted == false, "Reserves already minted");
        reservedMinted=true;
        _safeMint(bacon, 10);
        _safeMint(crab, 10);
        _safeMint(undead, 10);
        _safeMint(groot, 10);
    } 

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}