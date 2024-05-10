import { toNano } from '@ton/core';
import { SimpleDatabase } from '../wrappers/SimpleDatabase';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const simpleDatabase = provider.open(await SimpleDatabase.fromInit(BigInt(10_000_000)));

    await simpleDatabase.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(simpleDatabase.address);

    console.log('ID', (await simpleDatabase.getComputeId()).toString());
}
