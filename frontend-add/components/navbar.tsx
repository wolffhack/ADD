import { Flex, Image, Button } from "@chakra-ui/react";


export default function NavBar(){
    return(
        <Flex justify={"space-between"} bgColor={"blue.600"} h={"6rem"}>
            <Image src={""}/>
            <Button>
                Connect Wallet
            </Button>
        </Flex>
    )
}