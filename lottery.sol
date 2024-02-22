// SPDX-License-Identifier: UNLICENSED
pragma Solidity >=0.5.0 <0.9.0

contract Lottery{
    address payable[] public participants;
    address public manager;

    constructor(){
        manager=msg.sender;
    }

    receive() extrenal payable(){
        require(msg.value>=1 ether,"atleast 1 ehter has tobe passed");
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender==manager,"only manager can check the balnce in the contract");
        return address(this).balance;
    }

    function random() public view returns(uint){
        // dont use this reandom function generator in main net it is dangerous
        return uint(kecca256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public view return(address){
        require(msg.sender==manager,"only manager can  do this");
        require(participants.length>=3);
        address payable winner;


        uint r=random();
        // it will generate the asddress of winner

        uint index=r%participants.length;
        winner=participants[index];

        winner.transfer(getBalance());
        participants=new address payable[](0);
        return winner;
    }
}