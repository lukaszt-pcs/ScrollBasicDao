# ScrollBasicDao

# Basic DAO on Scroll

## Overview
This project implements a basic DAO on the Scroll blockchain. Members can join by paying a membership fee, create proposals, and vote on them.

## Features
- **Membership**: Join the DAO by paying a membership fee.
- **Proposals**: Create and vote on proposals.
- **Voting**: Determine proposal outcomes based on member votes.

## Contract Address
Deployed on Scroll Sepolia Testnet: `0x9b3FDb2466fFC5302EFF0fBc47afcAFd49DBdE4C`

## Installation and Deployment

### Using Remix

1. **Open Remix IDE**:
   - Navigate to [Remix](https://remix.ethereum.org/).

2. **Set Solidity Compiler Version**:
   - Ensure the compiler version is set to `0.8.25`.

3. **Create a New File**:
   - Name it `BasicDAO.sol` and paste the contract code into the file.

4. **Compile the Contract**:
   - Click on the "Solidity Compiler" tab and click the "Compile BasicDAO.sol" button. Ensure there are no errors.

5. **Deploy the Contract**:
   - Go to the "Deploy & Run Transactions" tab.
   - Select "Injected Web3" to deploy using MetaMask or other Web3 wallets. Ensure you are connected to the Sepolia testnet.
   - In the "Deploy" section, ensure `BasicDAO` is selected.
   - Enter the membership fee (e.g., `10000000000000000` for 0.01 ether) in the `_membershipFee` field.
   - Click the "Deploy" button.
   - Confirm the transaction in your Web3 wallet.

### Usage

1. **Join the DAO**:
   - Call the `join` function and pay the membership fee (0.01 ether).

2. **Create a Proposal**:
   - Call the `createProposal` function with a description and voting duration.

3. **Vote on Proposals**:
   - Call the `vote` function with the proposal ID and your vote (Yes or No).

4. **Finalize Proposals**:
   - Call the `finalizeProposal` function after the voting period ends to determine the proposal outcome.

## Contract Functions

- `join()`: Join the DAO by paying the membership fee.
- `createProposal(string description, uint256 duration)`: Create a new proposal.
- `vote(uint256 proposalId, VotingChoice choice)`: Vote on a proposal.
- `finalizeProposal(uint256 proposalId)`: Finalize the voting and determine the proposal outcome.
- `getProposal(uint256 proposalId)`: Get details of a specific proposal.
- `getProposals()`: Get a list of all proposals.

## Data Structures

- **Member**: Struct to store member information.
  - `bool isMember`: Indicates if the address is a member.
  - `uint256 joinedAt`: Timestamp of when the member joined.

- **Proposal**: Struct to store proposal details.
  - `uint256 id`: Unique ID of the proposal.
  - `address proposer`: Address of the proposer.
  - `string description`: Description of the proposal.
  - `uint256 deadline`: Voting deadline for the proposal.
  - `uint256 yesVotes`: Number of yes votes.
  - `uint256 noVotes`: Number of no votes.
  - `ProposalStatus status`: Current status of the proposal.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)

