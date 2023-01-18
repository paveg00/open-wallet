// SPDX-License-Identifier: MIT
        
pragma solidity >=0.4.22 <0.9.0;


import "truffle/Assert.sol";

contract testSuite {

    function beforeAll() public {
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
    }

    function checkSuccess() public {
        Assert.isTrue(2 == 2, 'should be true');
        Assert.isAbove(uint(2), uint(1), "2 should be greater than to 1");
        Assert.isAtLeast(uint(2), uint(3), "2 should be lesser than to 3");
    }


    /// Custom Transaction Context: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    /// #sender: account-1
    /// #value: 100
    function checkSenderAndValue() public payable {
        // account index varies 0-9, value is in wei
        // Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
        // Assert.equal(msg.value, 100, "Invalid value");
    }
}
    