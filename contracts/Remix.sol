pragma solidity ^0.4.15;


contract IInformation {

  event FieldChanged(int field, bytes newValue, address sourceAddress, uint requestId);

  modifier onlySource {
    require(true);
    _;
  }

  function setField(int field, bytes value, uint requestId) onlySource returns (bool ok) {}
}


contract IIdentity {
  // author
}


// ==========================


contract Owner {

  address owner;

  modifier isOwner {
    require(msg.sender == owner);
    _;
  }
}


// ==========================


contract TrackFactory {
  string[256] public trackHashes;
  address[256] public tracks;
  uint public trackCount = 0;

  // "0x1459b55e171400dfbf69f834fa6e80232b014ce8", "Early morning", "John Doe", 20, 1
  function addTrack(
    string hash,
    bytes32 name,
    string authorName,
    uint ownershipPrice,
    uint rentPrice
  ) {
    address trackAddress = new Track(msg.sender, hash, name, authorName, ownershipPrice, rentPrice);

    trackHashes[trackCount] = hash;
    tracks[trackCount] = trackAddress;
    trackCount += 1;
  }
}

contract Track is Owner {

  address public owner;

  string public hash;
  bytes32 public name;
  string public authorName;
  uint public ownershipPrice;
  uint public rentPrice;

  // account => 1 - in future add different prices for renters and place here Struct
  mapping(address => uint) renters;

  function Track(
    address _owner,
    string _hash,
    bytes32 _name,
    string _authorName,
    uint _ownershipPrice,
    uint _rentPrice
  ) payable {
    owner = _owner;
    hash = _hash;
    name = _name;
    authorName = _authorName;
    ownershipPrice = _ownershipPrice;
    rentPrice = _rentPrice;
  }

  function () payable {}

  function getName() returns (bytes32) {
    return name;
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
  
  function setField(int field, bytes value, uint requestId) 
    paybable onlySource returns (bool ok)
  {
    // call buy or rent
    // with changing owner or pay for rent.
    
    return true;
  }
}
