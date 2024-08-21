// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PeerReviewIncentives {
    // Token balance mapping
    mapping(address => uint256) public tokenBalance;
    
    // Mapping to store peer review status
    mapping(bytes32 => bool) public peerReviewed;
    
    // Event to log peer review
    event PeerReviewed(address indexed reviewer, address indexed reviewee, bytes32 assignmentHash);

    // Reward amount
    uint256 public rewardAmount = 10;

    // Function to perform a peer review and reward tokens
    function performPeerReview(address reviewee, string memory assignmentID) public {
        bytes32 reviewHash = keccak256(abi.encodePacked(msg.sender, reviewee, assignmentID));
        
        require(!peerReviewed[reviewHash], "This peer review has already been completed.");
        
        // Mark the peer review as completed
        peerReviewed[reviewHash] = true;

        // Reward the reviewer
        tokenBalance[msg.sender] += rewardAmount;

        // Emit event
        emit PeerReviewed(msg.sender, reviewee, reviewHash);
    }

    // Function to check the token balance
    function checkBalance(address account) public view returns (uint256) {
        return tokenBalance[account];
    }
}
