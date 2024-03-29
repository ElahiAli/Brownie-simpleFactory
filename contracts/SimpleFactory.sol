// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract SimpleStorage {

    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    People[] public people;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrive() public view returns (uint256) {
        return favoriteNumber;
    }

    function addperson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

//inheritance
contract StorageFactory is SimpleStorage {
    //an array with it's name.
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //type variable , variable name = new contract with no parameter.
        SimpleStorage simpleStorage = new SimpleStorage();
        //add variable to array.
        simpleStorageArray.push(simpleStorage);
    }

    //first variable is for which contract in our list to intract with(contract index)
    //second variable is for calling the function for example store that gain a number
    function sfstore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        //address taking index of contract in array .
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );
        //calling store function and passing the parameter.
        simpleStorage.store(_simpleStorageNumber);
    }

    //using retrive func to get the int.
    //refactoring the code.
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
                .retrive();
    }
}
