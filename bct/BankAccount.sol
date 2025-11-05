// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    mapping(address => uint) private balances;
    uint public total;

    // Deposit funds (requires sending Ether with the transaction)
    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than zero");
        balances[msg.sender] += msg.value;
        total += msg.value;
    }

    // Withdraw funds (with reentrancy protection and user-specific tracking)
    function withdraw(uint _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(address(this).balance >= _amount, "Contract has insufficient funds");

        // Effects before interaction (checks-effects-interactions pattern)
        balances[msg.sender] -= _amount;
        total -= _amount;

        // Transfer Ether using call (recommended way for sending Ether)
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    // Get user's own balance
    function getUserBalance() external view returns (uint) {
        return balances[msg.sender];
    }

    // Get total contract balance
    function getTotalBalance() external view returns (uint) {
        return address(this).balance;
    }

    // Fallback function to receive Ether directly
    receive() external payable {
        balances[msg.sender] += msg.value;
        total += msg.value;
    }
}