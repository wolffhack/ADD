// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ArtworkDAO {

     enum Role {
        None, 
        gallery, 
        manager,
        chairman, 
        owner
    }

    address public owner;

    struct Artwork {
        string title;
        address artist;
        bool accepted;
        bool exhibited;
        
        uint256 exhibitRoyalty;
    }

    mapping(address => Role) public roles;
    mapping(address => address) public artistToOwner;
    mapping(uint256 => Artwork) public artworks;
    uint256 public totalArtworks;

    event ArtworkSubmitted(uint256 indexed artworkId, string title, address artist);
    event ArtworkAccepted(uint256 indexed artworkId, address artist);
    event ArtworkExhibited(uint256 indexed artworkId, address gallery);

    event GalleryAdded(address gallery);
    event AccessRemoved(address member);
    event AccessAdded(address manufacturer);
    event ManagerAdded(address manager);

    // modifier onlyOwner() {
    //     require(roles[msg.sender] == Role.chairman, "Only the Chairman can call this function");
    // }

     constructor() {
        // chairman = msg.sender;
        owner = msg.sender;
        roles[msg.sender] = Role.chairman;
    }


    function submitArtwork(string memory _title) public {
        require(roles[msg.sender] != Role.None, "You must be a gallery, member, or owner to submit artwork");

        Artwork memory newArtwork = Artwork({
            title: _title,
            artist: msg.sender,
            accepted: false,
            exhibited: false,
            exhibitRoyalty: 0
        });

        uint256 artworkId = totalArtworks;
        artworks[artworkId] = newArtwork;
        totalArtworks++;

        emit ArtworkSubmitted(artworkId, _title, msg.sender);
    }

    function voteOnArtwork(uint256 _artworkId, bool _accept) public {
        require(roles[msg.sender] != Role.None, "gallery, member, or owner can vote on artwork acceptance");

        Artwork storage artwork = artworks[_artworkId];
        require(!artwork.accepted, "Artwork has already been accepted");

        if (_accept) {
            artwork.accepted = true;
            artwork.owner = artwork.artist;
            artistToOwner[artwork.artist] = artwork.artist;

            emit ArtworkAccepted(_artworkId, artwork.artist);
        }
    }

    function exhibitArtwork(uint256 _artworkId) public {
        require(roles[msg.sender] == Role.Member, "Only members can exhibit artwork");

        Artwork storage artwork = artworks[_artworkId];
        require(artwork.accepted, "Artwork must be accepted before it can be exhibited");

        artwork.exhibited = true;

        emit ArtworkExhibited(_artworkId, msg.sender);
    }

    function shareExhibitRoyalty(uint256 _artworkId, uint256 _royalty) public {
        require(roles[msg.sender] == Role.Member, "Only members can share exhibit royalty");

        Artwork storage artwork = artworks[_artworkId];
        require(artwork.exhibited, "Artwork must be exhibited to share exhibit royalty");

        artwork.exhibitRoyalty += _royalty;
    }


    function delArtworksAccess(address _addr) public owner {
        roles[_addr] = Role.None;
        emit AccessRemoved(_addr);
    }

    function addGallery(address _gallery) public owner {
        roles[_gallery] = Role.gallery;
        emit GalleryAdded(_gallery);
    }

    function addManager(address _addr) public owner {
        roles[_addr] = Role.manager;
        emit Managerdded(_addr);
    }
}