#[starknet::contract]
mod HeroToken {
    use openzeppelin::token::erc20::ERC20Component;
    use starknet::ContractAddress;
    use erc20::utils::utils::Utils;

    component!(path: ERC20Component, storage: erc20, event: ERC20Event);

    #[abi(embed_v0)]
    impl ERC20Impl = ERC20Component::ERC20Impl<ContractState>;
    #[abi(embed_v0)]
    impl ERC20CamelOnlyImpl = ERC20Component::ERC20CamelOnlyImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC20MetadataImpl = ERC20Component::ERC20MetadataImpl<ContractState>;
    impl ERC20InternalImpl = ERC20Component::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        erc20: ERC20Component::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC20Event: ERC20Component::Event
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        recipient: ContractAddress
    ) {
        let name: felt252 = 5207659044509010254;
        let symbol: felt252 = 310366914894;
        self.erc20.initializer(name, symbol);
        self.erc20._mint(recipient, 9000000 * Utils::pow(10, 18));
    }
}