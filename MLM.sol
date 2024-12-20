// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MLM is AccessControl, ReentrancyGuard, Pausable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    struct User {
        address upline;
        uint256 level;
        uint256 points;
    }

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    mapping(address => User) public users;
    mapping(uint256 => uint256) public levelCommission;
    mapping(address => uint256) public balances;
    address[] public userAddresses;

    uint256 public constant OWNER_PERCENTAGE = 10;
    uint256 public constant BINARY_PERCENTAGE = 40;

    address public ownerWallet;
    address public binaryWallet;

    uint256 public dailyPool;
    uint256 public totalPoints;
    uint256 public lastCalculation;

    event PaymentReceived(address indexed user, uint256 amount, uint256 packageType);
    event CommissionPaid(address indexed user, uint256 amount, uint256 level);
    event PoolDistributed(uint256 totalAmount);
    event ContractPaused(address account);
    event ContractUnpaused(address account);

    constructor(address _admin, address _ownerWallet, address _binaryWallet) {
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
        _grantRole(ADMIN_ROLE, _admin);

        ownerWallet = _ownerWallet;
        binaryWallet = _binaryWallet;

        levelCommission[1] = 10;
        levelCommission[2] = 5;
        levelCommission[3] = 5;
        levelCommission[4] = 5;
        levelCommission[5] = 4;
        levelCommission[6] = 3;
        levelCommission[7] = 2;
        levelCommission[8] = 2;
        levelCommission[9] = 1;
        for (uint256 i = 10; i <= 20; i++) {
            levelCommission[i] = 1;
        }
    }

    modifier onlyNewUser() {
        require(users[msg.sender].upline == address(0), "User already signed up");
        _;
    }

    modifier validPackage(uint256 packageType) {
        require(packageType == 50 || packageType == 100, "Invalid package type");
        _;
    }

    function signup(address upline, uint256 packageType) 
        external 
        payable 
        nonReentrant 
        whenNotPaused 
        onlyNewUser 
        validPackage(packageType) 
    {
        require(msg.value == packageType, "Incorrect payment amount");

        User storage user = users[msg.sender];
        user.upline = upline;
        user.level = 1;
        user.points = packageType.div(100);

        userAddresses.push(msg.sender);

        // Distribute payment
        _distributePayment(msg.value);

        // Update daily pool
        dailyPool = dailyPool.add(msg.value.mul(BINARY_PERCENTAGE).div(100));
        totalPoints = totalPoints.add(user.points);

        emit PaymentReceived(msg.sender, msg.value, packageType);
    }

    function _distributePayment(uint256 amount) private {
        uint256 ownerAmount = amount.mul(OWNER_PERCENTAGE).div(100);

        // Pay owner
        (bool sentToOwner, ) = ownerWallet.call{value: ownerAmount}("");
        require(sentToOwner, "Failed to send Ether to owner wallet");

        (bool sentToBinary, ) = ownerWallet.call{value: ownerAmount.mul(2).div(100)}("");
        require(sentToBinary, "Failed to send Ether to binary wallet");

        // Pay unilevel commissions
        address upline = users[msg.sender].upline;
        for (uint256 i = 1; i <= 20; i++) {
            if (upline == address(0)) break;
            uint256 commission = amount.mul(levelCommission[i]).div(100);
            balances[upline] = balances[upline].add(commission);
            emit CommissionPaid(upline, commission, i);
            upline = users[upline].upline;
        }
    }

    function distributeDailyPool() external onlyRole(ADMIN_ROLE) whenNotPaused {
        require(block.timestamp >= lastCalculation + 1 days, "Distribution already done today");

        uint256 totalPoolAmount = dailyPool;
        uint256 poolPerPoint = totalPoolAmount.div(totalPoints);

        for (uint256 i = 0; i < userAddresses.length; i++) {
            address userAddr = userAddresses[i];
            uint256 userPoints = users[userAddr].points;
            uint256 userPoolShare = userPoints.mul(poolPerPoint);
            balances[userAddr] = balances[userAddr].add(userPoolShare);
        }

        dailyPool = 0;
        totalPoints = 0;
        lastCalculation = block.timestamp;

        emit PoolDistributed(totalPoolAmount);
    }

    function withdraw() external nonReentrant whenNotPaused {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "No balance to withdraw");
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function pause() external onlyRole(ADMIN_ROLE) {
        _pause();
        emit ContractPaused(msg.sender);
    }

    function unpause() external onlyRole(ADMIN_ROLE) {
        _unpause();
        emit ContractUnpaused(msg.sender);
    }

    receive() external payable {}
}
