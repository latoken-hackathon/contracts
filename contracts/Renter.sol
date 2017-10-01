pragma solidity ^0.4.15;

import "./IIdentity.sol";


contract Renter is IIdentity {

  address owner;
  string name;
  string desc;

  // TODO: several items instead one;
  mapping (string => RentItem) items;

  struct RentItem {
    uint startRent;
    uint rentPeriod;
    address track;
  }

  function rent(string _hash, uint _rentPeriod, address _track) {
    items[_hash] = RentItem(now, _rentPeriod, _track);
  }
}
