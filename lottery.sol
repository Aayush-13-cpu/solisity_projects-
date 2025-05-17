//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.11 ;

contract Lottery
{
address public owner ;
address payable[] public player ;
uint public lotteryId ;
mapping(uint => address payable) public lotteryhistory; 

constructor()
{
    owner = msg.sender ;
    lotteryId = 1 ;

}

function getbalance() public view returns(uint)
{
    return  address(this).balance ;
}

function getplayers() public view returns(address payable[] memory )
{
    return player ;
}

function enter() public payable
{   require(msg.value >= 0.01 ether, " you need more than 2 ether ");
    player.push(payable(msg.sender));

}

function getrandomnumber()  public view returns(uint)
{
    return uint(keccak256(abi.encodePacked(owner ,block.timestamp)));
}
function pickwinner() public onlyowner
{     
      uint index = getrandomnumber() % player.length ;
      player[index].transfer(address(this).balance);
      lotteryId +=1 ; // to track the numbers of lottery winners 
      lotteryhistory[lotteryId]=player[index]; // to store the winner in a mapping of address and balance
      player = new address payable[](0);
      
}

  modifier onlyowner()
  {
    require(msg.sender== owner);
    _;
  }

}
