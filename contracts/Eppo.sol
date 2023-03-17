// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Eppo {
    address public owner;

    struct Transaction {
        address client;
        address professional;
        uint256 amount;
        uint256 time;
    }

    mapping(address => Transaction[]) internal History;

    constructor() {
        owner = msg.sender;
    }

    function transfer(address payable _reci) external payable {
        History[_reci].push(
            Transaction(msg.sender, _reci, msg.value, block.timestamp)
        );
        (bool s, ) = (_reci).call{value: msg.value}("");
        require(s, "Transaction Failed");
    }

    function getHistory(
        address _address
    ) public view returns (Transaction[] memory) {
        return History[_address];
    }
}
// 0xA7CBbA825aC39f3EB7198EC59c228bb042b4450D
