//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

//as a user can deposit for diff values we would have to make a enum for which 
//real life token he has deposited how many tokens 
// and then the total debt pool will be calculated
contract Vault {
    address[] public deposits;
    mapping(address=>uint256) public balances;
    const price = 5;
    uint256 public totalsupply;
    function deposit() public payable{
        balances[msg.sender]+=msg.value;
        totalsupply+=msg.value;
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
                totalsupply-=_amount;
            }
        uint256 withdrawl_amount=address(this).balance * fraction;
        
        // ye saara hii withdraw ho rha , vo check rkna resolve krke
        (bool callsuccess,)=payable(_address).call{value: withdrawl_amount}("");
        require(callsuccess,"failed transaction man");
        //depoist arguement (0x8F26D683822E60d522b58f7DB63D352CB7FAe6e4,1000000000000000)
    }
    // the function for the global debt pool , would have to use an enum alogn with the 
    //price converter here to calcuate the total debt for our case
    //then also would have to mint our tokens back to them , which would follow the price
    //of the real life token , this we have to see how 
    // we can do
    
    function total_value() public  {};
    
    function profit_loss_calculator(address _address) public returns(uint256){
        for(uint256 i;i<deposits.length;i++){
            uint256 totalvalue += balance[_address] * price; 

        }
    }
    
}
}
