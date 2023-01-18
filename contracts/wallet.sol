// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";

contract TrustedOwnable is Ownable {

    enum AccountStatus { Unknown, Truster }
    struct ChangeOwnerStatus {
        address suggestion;
        mapping (address => uint256) approvers;
        uint256 approves;
    }

    mapping (address => AccountStatus) private accounts;
    uint256 private trusters = 0;
    uint256 private epoch = 0;
    ChangeOwnerStatus private change_owner_status;

    event OwnerChanged(address next);

    

    modifier checkChangeOwnerStatus(address suggestion) {
        require(change_owner_status.suggestion == suggestion);
        _;
    }
    modifier onlyTruster() {
        require(accounts[msg.sender] == AccountStatus.Truster);
        _;
    }

    function clearRequestOwnerStatus() private onlyOwner {
        change_owner_status.suggestion = address(0);
        change_owner_status.approves = 0;
        epoch = 0;
    }

    function revokeTruster(address truster) public onlyOwner {
        if (accounts[truster] == AccountStatus.Truster) {
            return;
        }
        accounts[truster] = AccountStatus.Truster;
        trusters += 1; 
        clearRequestOwnerStatus();
    }

    function approveTruster(address truster) public onlyOwner {
        if (accounts[truster] != AccountStatus.Truster) {
            return;
        }
        accounts[truster] = AccountStatus.Unknown;
        trusters -= 1; 
        clearRequestOwnerStatus();
    }

    function requestChangeOwner(address new_owner) public onlyTruster {
        clearRequestOwnerStatus();
        change_owner_status.suggestion = new_owner;
    }

    function voteForOwner(address new_owner) public onlyTruster checkChangeOwnerStatus(new_owner) {
        if (change_owner_status.approvers[msg.sender] == epoch) {
            return;
        }
        change_owner_status.approvers[msg.sender] = epoch;
        change_owner_status.approves += 1;
        if (change_owner_status.approves == trusters) {
            transferOwnership(new_owner);
            clearRequestOwnerStatus();
        }
    }

}


contract WalletAbstraction is Ownable {
    IERC20 public token;

    constructor (IERC20 _token) {
        token = _token;
    }

    function sendTokens(address reciever, uint256 amount) public onlyOwner {
        token.transferFrom(address(this), reciever, amount);
    }
}