//-- NPM Packages
import {expect} from 'chai';
import {stub} from 'sinon';

//-- Project Code
import {getInternalModule} from '@src';

/**
 * The module under test.
 */
const testModule = getInternalModule();

describe('module:node-glfw', () => {
    describe('.helloWorld()', () => {
        it('should return the string `Hello world!`', () => {
            //-- Given
            const s = stub(testModule, 'helloWorld');
            s.returns('A test message!');

            //-- When
            const r = testModule.helloWorld();

            //-- Then
            expect(r).to.equal('A test message!');
            expect(s).to.satisfy(() => s.called);
        });
    });
});
