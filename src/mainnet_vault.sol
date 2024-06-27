//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault {
    address[] public deposits;
    IERC20 public immutable token;
    mapping(address=>uint256) public balances;

    constructor(address _tokenaddress){
        token=IERC20(_tokenaddress);
        
    }
    function deposit(uint256 _amount) public payable{        
        require(token.transferFrom(msg.sender,address(this), _amount));
        balances[msg.sender]+=_amount;
        deposits.push(msg.sender);

        //

    } 
    
    function get_deposit_amount(address _address) view public returns (uint256){
        for(uint256 i;i<deposits.length;i++){
            if(_address== deposits[i]){
                return balances[_address];
            }
        }
        
    }

    function withdraw(address _address,uint256 _amount) public {
        uint256 current_balance=get_deposit_amount(_address);
        require(_amount<=current_balance);
        uint256 fraction = _amount/current_balance;
        for(uint256 i;i<deposits.length;i++){
            if(_address==deposits[i]){
                balances[msg.sender]-=_amount;
            }
        uint256 withdrawl_amount=address(this).balance * fraction;
        
        // ye saara hii withdraw ho rha , vo check rkna resolve krke
        (bool callsuccess,)=payable(_address).call{value: withdrawl_amount}("");
        require(callsuccess,"failed transaction man");
        //depoist arguement (0x8F26D683822E60d522b58f7DB63D352CB7FAe6e4,1000000000000000)
    }
}
}
