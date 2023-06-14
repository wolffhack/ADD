// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title ArtworksDataDAO - Decentralized platform for managing artworks data on the Filecoin network
/// @notice Allows artists, collectors, and enthusiasts to manage, incentivize, and invest in artworks
contract ArtworksDataDAO is Ownable {
    struct Artwork {
        address artist;
        string title;
        string description;
        uint256 price;
    }

    mapping(uint256 => Artwork) public artworks;
    uint256 public totalArtworks;

    event ArtworkAdded(uint256 indexed id, address artist, string title);
    event ArtworkSold(uint256 indexed id, address buyer, uint256 price);

     constructor() 
  
    {

    }

    /// @dev Adds a new artwork to the DAO
    /// @param _title Title of the artwork
    /// @param _description Description of the artwork
    /// @param _price Price of the artwork

    function addArtwork(
        string memory _title,
        string memory _description,
        uint256 _price
        //art
    ) external onlyOwner {
        totalArtworks++;
        artworks[totalArtworks] = Artwork(
            msg.sender,
            _title,
            _description,
            _price
        );
        emit ArtworkAdded(totalArtworks, msg.sender, _title);
    }

    /// @dev Allows a buyer to purchase an artwork
    /// @param _id ID of the artwork to purchase

    function buyArtwork(uint256 _id) external payable {
        require(_id <= totalArtworks, "Invalid artwork ID");
        Artwork storage artwork = artworks[_id];
        require(msg.value >= artwork.price, "Insufficient funds");

        // Transfer funds to the artist
        payable(artwork.artist).transfer(artwork.price);

        // Emit event for the artwork sale
        emit ArtworkSold(_id, msg.sender, artwork.price);
    }

    /// @dev Retrieves the details of an artwork by its ID
    /// @param _id ID of the artwork
    /// @return artist Address of the artist
    /// @return title Title of the artwork
    /// @return description Description of the artwork
    /// @return price Price of the artwork

    function getArtwork(
        uint256 _id
    )
        external
        view
        returns (
            address artist,
            string memory title,
            string memory description,
            uint256 price
        )
    {
        require(_id <= totalArtworks, "Invalid artwork ID");
        Artwork storage artwork = artworks[_id];
        return (
            artwork.artist,
            artwork.title,
            artwork.description,
            artwork.price
        );
    }

    /// @dev Retrieves the total number of artworks stored in the contract
    /// @return totalArtworks Total number of artworks

    function getTotalArtworks() external view returns (uint256) {
        return totalArtworks;
    }
}