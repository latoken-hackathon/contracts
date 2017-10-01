pragma solidity ^0.4.15;


contract TrackFactory {
  // hash => address
  mapping (string => address) tracks;

  function upload(
  string hash,
  string name,
  string authorName,
  uint ownershipPrice,
  uint rentPrice
  ) {
    address owner = msg.sender;
    address trackAddress = new Track(owner, hash, name, authorName, ownershipPrice, rentPrice);

    tracks[hash] = trackAddress;
  }

  function checkTrackExist(string hash) returns (bool) {
    if (tracks[hash] == 0x0) {
      return false;
    }
    return true;
  }

  function getTrack(address trackAddress) returns (string) {
    Track memory track = Track(trackAddress);
    return track.name;
  }
}
