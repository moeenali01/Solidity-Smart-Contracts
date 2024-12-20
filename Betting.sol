// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BettingPlatform is Ownable(msg.sender) {
    IERC20 public token;

    struct Match {
        uint256 id;
        string teamA;
        string teamB;
        uint256 oddsA; // Odds for Team A (multiplied by 100)
        uint256 oddsB; // Odds for Team B (multiplied by 100)
        bool isActive;
        bool isResolved;
        string winner;
    }

    struct Bet {
        address user;
        uint256 matchId;
        string team;
        uint256 amount;
        bool claimed;
    }

    uint256 public matchCounter;
    mapping(uint256 => Match) public matches;
    mapping(uint256 => Bet[]) public matchBets; // Bets placed on each match
    mapping(address => uint256) public winnings; // Winnings for each user

    event MatchCreated(uint256 indexed matchId, string teamA, string teamB);
    event BetPlaced(address indexed user, uint256 indexed matchId, string team, uint256 amount);
    event MatchResolved(uint256 indexed matchId, string winner);
    event WinningsWithdrawn(address indexed user, uint256 amount);

    constructor(IERC20 _token) {
        token = _token;
    }

    // Admin Functions
    function createMatch(string memory teamA, string memory teamB, uint256 oddsA, uint256 oddsB) external onlyOwner {
        require(oddsA > 0 && oddsB > 0, "Odds must be greater than 0");
        matches[matchCounter] = Match({
            id: matchCounter,
            teamA: teamA,
            teamB: teamB,
            oddsA: oddsA,
            oddsB: oddsB,
            isActive: true,
            isResolved: false,
            winner: ""
        });
        emit MatchCreated(matchCounter, teamA, teamB);
        matchCounter++;
    }

    function closeMatch(uint256 matchId) external onlyOwner {
        require(matches[matchId].isActive, "Match is not active");
        matches[matchId].isActive = false;
    }

    function resolveMatch(uint256 matchId, string memory winner) external onlyOwner {
        Match storage matchData = matches[matchId];
        require(!matchData.isResolved, "Match already resolved");
        require(keccak256(abi.encodePacked(winner)) == keccak256(abi.encodePacked(matchData.teamA)) ||
                keccak256(abi.encodePacked(winner)) == keccak256(abi.encodePacked(matchData.teamB)), "Invalid winner");

        matchData.isResolved = true;
        matchData.winner = winner;

        // Distribute winnings
        Bet[] storage bets = matchBets[matchId];
        for (uint256 i = 0; i < bets.length; i++) {
            if (keccak256(abi.encodePacked(bets[i].team)) == keccak256(abi.encodePacked(winner))) {
                uint256 winningsAmount = bets[i].amount * (keccak256(abi.encodePacked(winner)) == keccak256(abi.encodePacked(matchData.teamA)) ? matchData.oddsA : matchData.oddsB) / 100;
                winnings[bets[i].user] += winningsAmount;
            }
        }

        emit MatchResolved(matchId, winner);
    }

    // User Functions
    function placeBet(uint256 matchId, string memory team, uint256 amount) external {
        Match storage matchData = matches[matchId];
        require(matchData.isActive, "Match is not active");
        require(keccak256(abi.encodePacked(team)) == keccak256(abi.encodePacked(matchData.teamA)) ||
                keccak256(abi.encodePacked(team)) == keccak256(abi.encodePacked(matchData.teamB)), "Invalid team");

        token.transferFrom(msg.sender, address(this), amount);
        matchBets[matchId].push(Bet({
            user: msg.sender,
            matchId: matchId,
            team: team,
            amount: amount,
            claimed: false
        }));

        emit BetPlaced(msg.sender, matchId, team, amount);
    }

    function withdrawWinnings() external {
        uint256 amount = winnings[msg.sender];
        require(amount > 0, "No winnings to withdraw");
        winnings[msg.sender] = 0;
        token.transfer(msg.sender, amount);

        emit WinningsWithdrawn(msg.sender, amount);
    }

    // Utility Functions
    function getMatchDetails(uint256 matchId) external view returns (Match memory) {
        return matches[matchId];
    }

    function getUserBets(address user) external view returns (Bet[] memory) {
        uint256 totalBets = 0;
        for (uint256 i = 0; i < matchCounter; i++) {
            Bet[] storage bets = matchBets[i];
            for (uint256 j = 0; j < bets.length; j++) {
                if (bets[j].user == user) {
                    totalBets++;
                }
            }
        }

        Bet[] memory userBets = new Bet[](totalBets);
        uint256 index = 0;

        for (uint256 i = 0; i < matchCounter; i++) {
            Bet[] storage bets = matchBets[i];
            for (uint256 j = 0; j < bets.length; j++) {
                if (bets[j].user == user) {
                    userBets[index] = bets[j];
                    index++;
                }
            }
        }

        return userBets;
    }
}
