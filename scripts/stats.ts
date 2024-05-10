import { Address } from '@ton/core';
import { SimpleDatabase } from '../wrappers/SimpleDatabase';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const simpleDatabase = provider.open(SimpleDatabase.fromAddress(Address.parse("EQAmvDhkWbXzdMDNWGnj6Vdl3JlVizjoJHCPzfD2LXLHwq7w")));

    console.log('Count:', Number(await simpleDatabase.getUsersCount()));
    console.log('Users: ', JSON.stringify((await simpleDatabase.getAllUsers()).map.values().map(user => ({...user, id: Number(user.id)})), undefined, 2))
}
