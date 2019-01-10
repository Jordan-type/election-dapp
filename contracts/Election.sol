pragma solidity ^0.5.0;

contract Election {
    // Store candidate
    // Read candidate
    string public candidate; // state var; accessible inside of contract
    
    // Constructor
    constructor() public {
        candidate = "Candidate 1";
    }
}