import { Box, Heading, Text } from "@chakra-ui/react";
export default function Hero() {
  return (
    <Box
      textAlign={"center"}
      bgColor={"blue.100"}
      h={"10rem"}
      justifyContent={"center"}
    >
  
        <Heading p={"2rem"}>Artworks Data DAO</Heading>
        <Text>Artworks Data DAO on the Filecoin network, creating a decentralized platform for artists, collectors, and enthusiasts to manage, incentivize, and invest in artworks. </Text>
        <Text>The DAO will leverage the benefits of fvm to ensure secure and transparent management of artwork data.</Text>
    </Box>
  );
}
