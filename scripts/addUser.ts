import { Address, toNano } from '@ton/core';
import { SimpleDatabase } from '../wrappers/SimpleDatabase';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
  const simpleDatabase = provider.open(SimpleDatabase.fromAddress(Address.parse("EQAmvDhkWbXzdMDNWGnj6Vdl3JlVizjoJHCPzfD2LXLHwq7w")))

    await simpleDatabase.send(
        provider.sender(),
        {
            value: toNano('0.02'),
        },
        {
          $$type: "AddUser",
          name: "Casper",
          password: "MyPassword"
        }
    );
}
