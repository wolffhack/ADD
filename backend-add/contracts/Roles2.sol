// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ArtworksAccess {
    enum AccessLevel {
        None, 
        Gallery, //gallery can access the art for exhibition with Owner and managers' permision 
        Manager,// Ehthuriasts who are passionate to build the community
        Artist,
        Owner //artworks owner
    }


    mapping(address => AccessLevel) public accessLevels;

    event GalleryAdded(address gallery);
    event MemberRemoved(address member);
    event ManagerAdded(address manufacturer);

    address public owner;

    constructor() {
        owner = msg.sender;
        accessLevels[msg.sender] = AccessLevel.Owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function delArtworksAccess(address _member) public onlyOwner {
        accessLevels[_member] = AccessLevel.None;
        emit MemberRemoved(_member);
    }

    function addGallery(address _gallery) public onlyOwner {
        accessLevels[_gallery] = AccessLevel.gallery;
        emit GalleryAdded(_gallery);
    }

    function addManager(address _manager) public onlyOwner {
        accessLevels[_manager] = AccessLevel.manager;
        emit ManagerAdded(_manager);
    }

}