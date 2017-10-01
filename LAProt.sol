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

