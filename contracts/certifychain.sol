// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CertifyChain {
    address public owner;

    struct Certificate {
        string studentName;
        string course;
        string issuedBy;
        uint256 issueDate;
    }

    mapping(bytes32 => Certificate) private certificates;

    event CertificateIssued(bytes32 certHash, string studentName, string course);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function issueCertificate(
        string memory _studentName,
        string memory _course,
        string memory _issuedBy,
        uint256 _issueDate
    ) public onlyOwner returns (bytes32) {
        bytes32 certHash = keccak256(abi.encodePacked(_studentName, _course, _issuedBy, _issueDate));
        certificates[certHash] = Certificate(_studentName, _course, _issuedBy, _issueDate);
        emit CertificateIssued(certHash, _studentName, _course);
        return certHash;
    }

    function verifyCertificate(bytes32 certHash) public view returns (Certificate memory) {
        require(bytes(certificates[certHash].studentName).length != 0, "Certificate not found");
        return certificates[certHash];
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
