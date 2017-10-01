contract IInformation {
    modifier onlySource(int field, bytes vals, uint rId) {
        require(true);
        _;
    }
    
    function setField(int field, bytes vals, uint rId) 
        onlySource(field, vals, rId) returns (bool ok);
}


contract Song is IInformation {
    
    address owner;
    string songName;
    string authorName;
    Price[] prices;
    
    struct Price {
        uint exludePrice; 
    }
    
    function setField(int field, bytes vals, uint rId) 
        onlySource(field, vals, rId) returns (bool ok)
    {
        // ??? LAP
    }
}

