
contract SongFactory {
    mapping(address => Track) tracks;
    
    function upload(string trackHash, string trackName) public {
        // save to songs map
        Author author = new Author();
        tracks[msg.sender] = new Track(trackHash, trackName, author);
    }
}

contract Track is IInformation {
    
    string public hash;
    string name;
    Author author;
    Price[] prices;
    
    struct Price {
        uint exludePrice; 
    }
    
    function Track(string hash, string name, Author author) {
        
    }
    
    function setField(int field, bytes vals, uint rId) 
        onlySource(field, vals, rId) returns (bool ok)
    {
        // ??? LAP
    }
    
    function pay() payable {
        // use setField?    
    }
}

contract Author is IIdentity {
    string name;
    string desc;
    mapping(string => Track) tracks;
    
    function add(string hash, Track track) {
        tracks[hash] = track;
    }
    
    function rent(Track track) {
        // rent
    }
    
    function sell(Track track) {
        // sell
        // change author and track owner
        // remove from tracks;
    }
}

contract Renter is IIdentity {
    
}
