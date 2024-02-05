//-- NPM Packages
import {expect} from 'chai';

//-- Project Code
import {getInternalModule} from '../src/ts/index.mts';

/**
 * The module under test.
 */
const testModule = getInternalModule();

describe('module:node-glfw', () => {
    describe('.helloWorld()', () => {
        it('should return the string `Hello world!`', () => {
            //-- Given

            //-- When
            const r = testModule.helloWorld();

            //-- Then
            expect(r).to.equal('Hello world!');
        });
    });
});
