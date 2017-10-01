
contract TrackFactory {
    mapping(address => Track) tracks;
    mapping(address => Author) authors;

    function upload(string authorName, string authorDesc, 
                    string trackHash, string trackName, 
                    uint exludePrice) public 
    {
        address owner = msg.sender;
        
        // check is author already exists?
        Author author = authors[owner];
        if (author.name == 0) { // FIXME
            author = new Author(owner, authorName, authorDesc);
            authors[owner] = author;
        }

        tracks[msg.sender] = new Track(trackHash, trackName, author);
    }
}

contract Track is IInformation {
    
    string public hash;
    string public name;
    Author author;
    uint exludePrice;
    uint rentPrice;
    
    
    function Track(string _hash, string _name, Author _author) {
        hash = _hash;
        name = _name;
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
    
    
    struct RentItem {
        uint startRent;
        uint rentPeriod;
        Track track;
        
        // function RentItem(uint _startRent, uint _period, Track track) {
        //     startRent = _startRent;
        //     rentPeriod = _period;
        //     track = _track;
        // }
    }
    
    mapping(string => RentItem) items;
    
    function rent(string _hash, uint _rentPeriod, Track _track) {
        items[_hash] = RentItem({
                startRent: now, 
                rentPeriod: _rentPeriod, 
                track: _track
            });
    }
}
