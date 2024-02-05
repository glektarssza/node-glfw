//-- NPM Packages
import bindings from 'bindings';

export interface GLFWBindings {
    helloWorld(): string;
}

const glfw = bindings('node_glfw') as GLFWBindings;

const m = {
    helloWorld(): string {
        return glfw.helloWorld();
    }
};

/**
 * Get the internal module for use in unit tests.
 *
 * @returns The internal module.
 *
 * @internal
 */
export function getInternalModule(): typeof m {
    return m;
}

// eslint-disable-next-line no-empty-pattern, @typescript-eslint/unbound-method
export const {helloWorld} = m;
