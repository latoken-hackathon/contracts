
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
    string name;
    Author author;
    Price[] prices;
    
    struct Price {
        uint exludePrice;
        uint rentPrice;
    }
    
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
    
    function pay() payable {
        // use setField?    
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
    
}
