// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";
error NotOwner ();
contract FundMe{

    using PriceConverter for uint256;
    uint256 public constant MININUM_USD =2e18;

    address[] public funders ;
    mapping (address => uint256 amountFunded) public addressToAmountFunded ;

    address public immutable i_owner ;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable  {
        
         require(msg.value.getConversionRate()>= MININUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
   
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

     function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    modifier onlyOwner {
        //require(msg.sender == i_owner, "Only the contract creator can call this function.");

        if (msg.sender != i_owner){ revert NotOwner();}
        _;
    }
    

}
