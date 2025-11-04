// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    mapping(address => uint) private balances;

    // Deposit funds
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Withdraw funds (with reentrancy protection)
    function withdraw(uint _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // Check balance
    function getBalance() external view returns (uint) {
        return balances[msg.sender];
    }

    // Fallback to receive ETH (updated to inline logic)
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}