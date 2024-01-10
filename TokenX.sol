// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TruckologyToken is ERC20Burnable, Ownable {
    uint256 public constant TOTAL_SUPPLY = 575_000_000 * 10**18;
    uint256 public constant THEO_INITIAL_MINTING = 1_000_000 * 10**18;
    uint256 public constant THEOX_INITIAL_MINTING = 500_000 * 10**18;

    TruckologyToken public theoxToken;

    constructor() ERC20("TruckologyToken", "THEO") {
        // Mint initial THEO tokens
        _mint(msg.sender, THEO_INITIAL_MINTING);

        // Deploy THEOX contract and mint initial THEOX tokens
        theoxToken = new TruckologyToken();
        theoxToken.mint(msg.sender, THEOX_INITIAL_MINTING);

        // Distribute tokens to specified addresses
        distributeTokens();
    }

    function distributeTokens() internal onlyOwner {
        // Distribution percentages
        uint256 teamAndAdvisorsPercentage = 20;
        uint256 strategicSalesPercentage = 7;
        uint256 marketingAirdropsPercentage = 18;
        uint256 liquidityPercentage = 20;
        uint256 reservePercentage = 5;

        uint256 investorsPercentage = 7;
        uint256 rewardsPercentage = 30;
        uint256 appDevelopmentPercentage = 30;
        uint256 maintenancePercentage = 26;
        uint256 communitySelfPercentage = 7;

        // Distribution amounts
        uint256 teamAndAdvisors = (TOTAL_SUPPLY * teamAndAdvisorsPercentage) / 100;
        uint256 strategicSales = (TOTAL_SUPPLY * strategicSalesPercentage) / 100;
        uint256 marketingAirdrops = (TOTAL_SUPPLY * marketingAirdropsPercentage) / 100;
        uint256 liquidity = (TOTAL_SUPPLY * liquidityPercentage) / 100;
        uint256 reserve = (TOTAL_SUPPLY * reservePercentage) / 100;

        uint256 investors = (TOTAL_SUPPLY * investorsPercentage) / 100;
        uint256 rewards = (TOTAL_SUPPLY * rewardsPercentage) / 100;
        uint256 appDevelopment = (TOTAL_SUPPLY * appDevelopmentPercentage) / 100;
        uint256 maintenance = (TOTAL_SUPPLY * maintenancePercentage) / 100;
        uint256 communitySelf = (TOTAL_SUPPLY * communitySelfPercentage) / 100;

        // Transfer THEO tokens to specified addresses
        _transfer(address(this), owner(), teamAndAdvisors + strategicSales + marketingAirdrops + liquidity + reserve);
        _transfer(address(this), owner(), investors + rewards + appDevelopment + maintenance + communitySelf);

        // Transfer THEOX tokens to specified addresses
        theoxToken.transfer(address(this), teamAndAdvisors + strategicSales + marketingAirdrops + liquidity + reserve);
        theoxToken.transfer(address(this), investors + rewards + appDevelopment + maintenance + communitySelf);
    }

    // Function to mint additional THEOX tokens
    function mintTheox(address to, uint256 amount) external onlyOwner {
        theoxToken.mint(to, amount);
    }
}

// THEOX Token Contract
contract TheoxToken is ERC20Burnable, Ownable {
    constructor() ERC20("TheoxToken", "THEOX") {}

    // Function to mint THEOX tokens
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}