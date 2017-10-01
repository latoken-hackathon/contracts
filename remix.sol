//import "LAProt.sol";

// instead of import
// =================

contract IInformation {
    modifier onlySource(int field, bytes vals, uint rId) {
        require(true);
        _;
    }
    
    function setField(int field, bytes vals, uint rId) 
        onlySource(field, vals, rId) returns (bool ok);
}

contract IIdentity {
    // author
}

// ==========================


contract TrackFactory {
    mapping(address => Track) tracks;
    mapping(address => Author) authors;

    function upload(string authorName, string authorDesc, 
                    string trackHash, string trackName, 
                    uint exludePrice, uint rentPrice) public 
    {
        address owner = msg.sender;
        
        // check is author already exists?
        Author author = authors[owner];
        if (author.name == 0) { // FIXME
            author = new Author(owner, authorName, authorDesc);
            authors[owner] = author;
        }

        tracks[msg.sender] = new Track(trackHash, trackName, exludePrice, rentPrice, author);
    }
}

contract Track is IInformation {
    
    string public hash;
    string public name;
    Author author;
    uint ownershipPrice;
    uint usagePrice;
    
    
    function Track(string _hash, string _name, uint _ownershipPrice, uint _usagePrice, 
        Author _author) 
    {
        hash = _hash;
        name = _name;
        ownershipPrice = _ownershipPrice;
        usagePrice = _usagePrice;
        author = _author;
    }
    
    function setField(int field, bytes vals, uint rId) 
        onlySource(field, vals, rId) returns (bool ok)
    {
        // ??? LAP
    }
    
    function buy() payable {
        // 
    }
    
    function rent() payable {
        // rent 
    }
}

contract Author is IIdentity {
    address public owner;
    string public name;
    string desc;
    mapping(string => Track) tracks;


    function Author(address _owner, string _name, string _desc) {
        owner = _owner;
        name = _name;
        desc = _desc;
    }
    
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
    address owner;
    string name;
    string desc;

    // TODO: several items instead one;
    mapping(string => RentItem) items;
    
    
    struct RentItem {
        uint startRent;
        uint rentPeriod;
        Track track;
    }
    
    function rent(string _hash, uint _rentPeriod, Track _track) {
        items[_hash] = RentItem({
                startRent: now, 
                rentPeriod: _rentPeriod, 
                track: _track
            });
    }
}
