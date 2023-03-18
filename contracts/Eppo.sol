// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Eppo {
    address public owner;
    address public professional;
    address public client;
     bool public isApproved;
    event Approved(uint);

    
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

    function approve() external onlyClient {
        uint256 balance = address(this).balance;
        (bool sent, ) = payable(professional).call{value: balance}("");
        require(sent, "Failed to send Ether");
        emit Approved(balance);
        isApproved = true;
    }

    function cancel() external onlyClient {
        uint256 balance = address(this).balance;
        uint256 userAmount = (balance*80)/100;
        uint256 proAmount = balance-userAmount;
        (bool sent, ) = payable(professional).call{value: proAmount}("");
        require(sent, "Failed to send Ether");
        (bool s, ) = payable(client).call{value: userAmount}("");
        require(s, "Failed to send Ether");
    }


    function transfer(address payable _reci) external payable {
        professional = _reci;
        client = msg.sender;
        History[_reci].push(
            Transaction(msg.sender, _reci, msg.value, block.timestamp)
        );
    }

    function getHistory(
        address _address
    ) public view returns (Transaction[] memory) {
        return History[_address];
    }

   

    modifier onlyClient {
        require(msg.sender == client);
        _;
    }
}
// 0xA7CBbA825aC39f3EB7198EC59c228bb042b4450D
