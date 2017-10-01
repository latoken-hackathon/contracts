pragma solidity ^0.4.15;


contract Track is Owner, IInformation {

  address owner;
  string public hash;
  string public name;
  string public authorName;
  uint ownershipPrice;
  uint rentPrice;

  // account => 1 - in future add different prices for renters and place here Struct
  mapping(address => uint) renters;

  function Track(
  string _owner,
  string _hash,
  string _name,
  string _authorName,
  uint _ownershipPrice,
  uint _rentPrice
  ) {
    owner = _owner;
    hash = _hash;
    name = _name;
    authorName = _authorName;
    ownershipPrice = _ownershipPrice;
    rentPrice = _rentPrice;
  }

  function buy() payable returns (bool ok) {
    require(msg.value >= ownershipPrice);

    uint restValue = msg.value - ownershipPrice * 1 ether;
    msg.sender.transfer(restValue);

    owner.transfer(ownershipPrice * 1 ether);

    owner = msg.sender;
  }

  function rent() payable returns (bool ok) {
    require(msg.value >= rentPrice);
    require(renters[msg.sender] == 0);

    uint restValue = msg.value - rentPrice * 1 ether;
    msg.sender.transfer(restValue);

    owner.transfer(rentPrice * 1 ether);

    renters[msg.sender] = 1;
  }

  function changeOwnershipPrice(uint price) isOwner {
    ownershipPrice = price;
  }

  function changeRentPrice(uint price) isOwner isOwner {
    rentPrice = price;
  }
}
