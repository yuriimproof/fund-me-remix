// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import { PriceConverter } from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    address[] public funders;
    mapping (address funders => uint256 amount) public funderAddressToAmount;

    address public immutable i_owner;
    uint256 public constant MIN_USD = 5e18;

    constructor() {
        i_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MIN_USD, "Too low ETH. Need greater than 5 USD");

        funders.push(msg.sender);
        funderAddressToAmount[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            funderAddressToAmount[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdrawal failed");
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}