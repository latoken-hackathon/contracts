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
  // hash => address
  mapping (string => address) trackHashes;
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
    address trackAddress = new Track(trackCount, msg.sender, hash, name, authorName, ownershipPrice, rentPrice);

    trackHashes[hash] = trackAddress;
    tracks[trackCount] = trackAddress;
    trackCount += 1;
  }

  function checkTrackExist(string hash) returns (bool) {
    if (trackHashes[hash] == 0x0) {
      return false;
    }
    return true;
  }

  function getTrackByHash(string hash) returns (uint index) {
    Track track = Track(trackHashes[hash]);

    return track.getIndex();
  }
}

contract Track is Owner {

  address public owner;

  uint index;
  string public hash;
  bytes32 public name;
  string public authorName;
  uint public ownershipPrice;
  uint public rentPrice;

  // account => 1 - in future add different prices for renters and place here Struct
  mapping(address => uint) renters;

  function Track(
    uint _index,
    address _owner,
    string _hash,
    bytes32 _name,
    string _authorName,
    uint _ownershipPrice,
    uint _rentPrice
  ) payable {
    index = _index;
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

  function getIndex() returns (uint) {
    return index;
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
