//SPDX-License-Identifier:Unlicensed
pragma solidity ^0.8.0;
contract DMCgeneration
{
    mapping(address=>bool) public adminList;

    struct studentData{
        string name;
        uint8 rollno;
        string course;
        string institute;
    }

    mapping(string=>studentData) public certificateMapped;

    constructor(){
        adminList[msg.sender]=true;
    }

    event certificateAdded(string indexed _certificateNo);

    modifier onlyAdmin(){
        require(adminList[msg.sender]==true,"NOT ADMIN");
        _;
    }

    function addAdmin(address newAdmin)
    public
    onlyAdmin
    {
        adminList[newAdmin]=true;
    }

    function removeAdmin(address oldAdmin)
    public
    onlyAdmin
    {
        adminList[oldAdmin]=false;
    }

    function createCertificate
    (string calldata _name,uint8 _rollno,string calldata _course,string calldata _institute,string calldata  _certificateNo)
    public
    onlyAdmin
    {
        require(bytes(_name).length>0,"not a valid name");
        require(_rollno>0);
        require(bytes(_course).length>0);
        require(bytes(_institute).length>0,"invalid");
        require(bytes(_certificateNo).length>0);

        certificateMapped[_certificateNo]=studentData(_name,_rollno,_course,_institute);
        emit certificateAdded(_certificateNo);
    }

}