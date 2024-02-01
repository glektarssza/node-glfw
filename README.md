# node-glfw #

A NodeJS native addon which provides access to the GLFW APIs.

<!-- omit in toc -->
## Table of Contents ##

* [node-glfw](#node-glfw)
    * [Contributing](#contributing)
        * [Setup](#setup)
        * [Code Styling](#code-styling)
        * [Testing](#testing)
    * [License](#license)

## Contributing ##

This project accepts outside contributions. Please see the following sections
for information about how to get setup for contributing.

### Setup ###

Getting setup to develop is fairly straight forward. Follow these steps:

1. Run `npm install` to install required dependencies.

That's about it!

### Code Styling ###

This project uses a combination of [Husky](https://www.npmjs.com/package/husky),
[ESLint](https://www.npmjs.com/package/eslint), and
[Prettier](https://www.npmjs.com/package/prettier) for code styling. To run
ESLint you can use:

```sh
npm run lint
```

To automatically fix any lint issues that can be fixed you can run:

```sh
npm run lint:fix
```

This project is configured with a `pre-commit` hook to run the linting tool and
abort a Git commit if it finds issues. You can bypass this with the
`--no-verify` flag:

```sh
git commit --no-verify
```

Please do not use this unless you only changed non-linted files and there was
already a linting error in the codebase.

All pull requests should not fail linting. The linting rules can be changed with
discussion.

### Testing ###

To run unit tests use:

```sh
npm test
```

All existing tests should pass before you submit a pull request.

## License ##

Copyright (c) 2024 G'lek Tarssza

Licensed under the MIT License.

See [LICENSE.md](LICENSE.md) for the full license.
