pragma solidity ^0.4.15;

import "./IIdentity.sol";


contract Author is IIdentity {

  address public owner;
  string public name;
  string desc;
  mapping (string => address) tracks;

  function Author(address _owner, string _name, string _desc) {
    owner = _owner;
    name = _name;
    desc = _desc;
  }

  function add(string hash, address track) {
    tracks[hash] = track;
  }
}
