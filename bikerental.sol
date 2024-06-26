// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Bikerental {

    string public model;
    uint public demand;
    address public renter;
    bool public requiresLicense;

    function available(string memory _model, uint _demand, bool _requiresLicense) public {
        if(bytes(_model).length == 0) {
            revert("please , enter the model");
        }
        if(_demand <= 0) {
            revert("enter your demand price");
        }

        model = _model;
        demand = _demand;
        requiresLicense = _requiresLicense;
    }

    function buyer(string memory model_n, uint price, bool hasLicense) public payable {
        require(price > 0, "please enter your budget");
        if(keccak256(abi.encodePacked(model)) != keccak256(abi.encodePacked(model_n))) {
            revert("this model is not availabe");
        }
        if(price < demand) {
            revert("please increase the price");
        }
        if(requiresLicense && !hasLicense) {
            revert("License is required ");
        }

        renter = msg.sender;
        assert(renter != address(0));  
    }

    function rented(address a) public view returns (string memory) {
        require(a == renter, "Bike as per your specifications is not available");
        string memory accept = "You have successfully rented the bike that you needed";
        return accept;
    }
}

      
