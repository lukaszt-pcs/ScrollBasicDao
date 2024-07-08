// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract BasicDAO {
    address public owner;
    uint256 public membershipFee;
    uint256 public proposalCount;

    enum VotingChoice { Yes, No }
    enum ProposalStatus { Pending, Approved, Rejected }

    struct Member {
        bool isMember;
        uint256 joinedAt;
    }

    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 deadline;
        uint256 yesVotes;
        uint256 noVotes;
        ProposalStatus status;
    }

    mapping(address => Member) public members;
    Proposal[] public proposals;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender].isMember, "Not a member");
        _;
    }

    event MemberJoined(address indexed member, uint256 timestamp);
    event ProposalCreated(uint256 indexed proposalId, address indexed proposer, string description, uint256 deadline);
    event Voted(address indexed voter, uint256 indexed proposalId, VotingChoice vote);
    event ProposalStatusChanged(uint256 indexed proposalId, ProposalStatus status);

    constructor(uint256 _membershipFee) {
        owner = msg.sender;
        membershipFee = _membershipFee;
    }

    function join() external payable {
        require(!members[msg.sender].isMember, "Already a member");
        require(msg.value == membershipFee, "Incorrect membership fee");

        members[msg.sender] = Member({ isMember: true, joinedAt: block.timestamp });
        emit MemberJoined(msg.sender, block.timestamp);
    }

    function createProposal(string calldata description, uint256 duration) external onlyMember {
        proposals.push(Proposal({
            id: proposalCount,
            proposer: msg.sender,
            description: description,
            deadline: block.timestamp + duration,
            yesVotes: 0,
            noVotes: 0,
            status: ProposalStatus.Pending
        }));
        emit ProposalCreated(proposalCount, msg.sender, description, block.timestamp + duration);
        proposalCount++;
    }

    function vote(uint256 proposalId, VotingChoice choice) external onlyMember {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp < proposal.deadline, "Voting period has ended");
        require(proposal.status == ProposalStatus.Pending, "Proposal already resolved");

        if (choice == VotingChoice.Yes) {
            proposal.yesVotes++;
        } else {
            proposal.noVotes++;
        }

        emit Voted(msg.sender, proposalId, choice);
    }

    function finalizeProposal(uint256 proposalId) external onlyOwner {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp >= proposal.deadline, "Voting period not yet ended");
        require(proposal.status == ProposalStatus.Pending, "Proposal already resolved");

        if (proposal.yesVotes > proposal.noVotes) {
            proposal.status = ProposalStatus.Approved;
        } else {
            proposal.status = ProposalStatus.Rejected;
        }

        emit ProposalStatusChanged(proposalId, proposal.status);
    }

    function getProposal(uint256 proposalId) external view returns (Proposal memory) {
        return proposals[proposalId];
    }

    function getProposals() external view returns (Proposal[] memory) {
        return proposals;
    }
}
