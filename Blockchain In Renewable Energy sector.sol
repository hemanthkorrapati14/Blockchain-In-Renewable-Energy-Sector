// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
//contract for microgrid registration 

contract microgridregistration{
    struct proconsumers{
        string username;
        uint gridnumber;
        string location;
        uint  production;
        uint  consumption;
        uint excessenergy;
    }
 

    // Mappping 
     mapping(uint=>proconsumers)  public usermap;
    
  
      
    // set Function for adding user details 
     function setsuserdetails
     (
         string memory _username,
         uint _gridnumber,
         string memory _location,
         uint _production,
         uint _consumption
        //uint excessenergy
     ) 
       public 
        { 
        require(keccak256(abi.encodePacked((usermap[_gridnumber].gridnumber))) 
        !=
         keccak256(abi.encodePacked(_gridnumber)));
        usermap[_gridnumber].username = _username ; 
        usermap[_gridnumber].gridnumber = _gridnumber ; 
        usermap[_gridnumber].location = _location ; 
        usermap[_gridnumber].production = _production ; 
        usermap[_gridnumber].consumption = _consumption ;
        usermap[_gridnumber].excessenergy =  usermap[_gridnumber].production-usermap[_gridnumber].consumption;
       
       
        }

     
         function getuserdetails(uint _gridnumber) view public returns(string memory ,uint, string memory, uint,uint,uint)
         {
           return
           (
            usermap[_gridnumber].username, 
            usermap[_gridnumber].gridnumber, 
            usermap[_gridnumber].location,
            usermap[_gridnumber].production,   
            usermap[_gridnumber].consumption, 
            usermap[_gridnumber].excessenergy
            
            ); 
        
          
         }
          function validateUser(uint _gridnumber) view public returns(bool) 
            { 
                 if (keccak256(abi.encodePacked((usermap[_gridnumber].gridnumber))) ==  
                 keccak256(abi.encodePacked(_gridnumber))) 
                 return true ; 
                 else return false ; 
            }

      
             function energyrequest (uint _rechargeamount,uint _source ,uint _destination) public  
             {
            
                if(_rechargeamount<usermap[_source].excessenergy) {
                   usermap[_destination].production=  usermap[_source].excessenergy-_rechargeamount;
                   
                  usermap[_source].excessenergy-=_rechargeamount;
                }
                
             }

           

          
 
}