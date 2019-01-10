pragma solidity ^0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters; // maps address <> boolean
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates; // maps id <> Candidate object
    // Store Candidates Count
    uint public candidatesCount;

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0); // instantiate Candidate Object
    }


    // Solidity function can pass extra parameter such as metadata
    function vote(uint _candidateId) public { // external account to be able to access this function
        // require that they haven't voted before
        require(!voters[msg.sender], "This address have voted");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Candidate is not valid");

        // record that voter has voted.
        // rule: keeping track an account has voted (only once)
        voters[msg.sender] = true; // accessing account (address) that is voting

        // Update candidate vote count
        candidates[_candidateId].voteCount++;
    }
}