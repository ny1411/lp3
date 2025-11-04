// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract SimpleBank {

    struct ClientAccount {
        int client_id;                   // Keep Client ID
        address client_address;          // Keep Client Address
        uint client_balance_in_ether;    // Keep Client Ether balance
    }

    ClientAccount[] public clients;      // Array to maintain all client information
    int public clientCounter;
    address payable public manager;      // Manager's payable address

    // Modifier: restrict access to the manager only
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can call this!");
        _;
    }

    // Modifier: restrict access to registered clients only
    modifier onlyClients() {
        bool isClient = false;
        for (uint i = 0; i < clients.length; i++) {
            if (clients[i].client_address == msg.sender) {
                isClient = true;
                break;
            }
        }
        require(isClient, "Only clients can call this!");
        _;
    }

    // Constructor initializes client counter
    constructor() {
        clientCounter = 0;
    }

    // Allow the contract to receive Ether
    receive() external payable {}

    // Set the manager's address
    function setManager(address managerAddress) public returns (string memory) {
        manager = payable(managerAddress);
        return "Manager address set successfully";
    }

    // Join as a new client
    function joinAsClient() public payable returns (string memory) {
        clients.push(ClientAccount(clientCounter++, msg.sender, address(msg.sender).balance));
        return "Client added successfully";
    }

    // Deposit Ether to the contract (only by clients)
    function deposit() public payable onlyClients {
        payable(address(this)).transfer(msg.value);
    }

    // Withdraw Ether from the contract (only by clients)
    function withdraw(uint amount) public payable onlyClients {
        payable(msg.sender).transfer(amount * 1 ether);
    }

    // Manager sends interest to all clients
    function sendInterest() public payable onlyManager {
        for (uint i = 0; i < clients.length; i++) {
            address clientAddress = clients[i].client_address;
            payable(clientAddress).transfer(1 ether);
        }
    }

    // Get the contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
