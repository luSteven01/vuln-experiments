// SPDX‑License‑Identifier: MIT
pragma solidity 0.6.12;

contract SimpleBank {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough");
        (bool ok, ) = msg.sender.call{value: amount}(""); // vulnerable
        require(ok, "Transfer failed");
        balances[msg.sender] -= amount;                  // effect too late
    }
}
