pragma solidity ^0.4.15;


contract Owner {

  address owner;

  modifier isOwner {
    require(msg.sender == owner);
    _;
  }
}
