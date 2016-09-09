## Contributing guidelines

Any development must have a corresponding story before work has begun on the implementation. This story can take the form of a feature, bug or chore. More information on the [Backlog](./BACKLOG.md) and our feature development life cycle [can be found here](./BACKLOG.md).

### GIT

All code developed for TreeHouse projects must be tracked in version control through GIT. All repositories are stored on GitHub under the [TreeHouse organization](https://github.com/treehouseaustin).

With the exception of generic components that we choose to open source, all repositories will be set to private in our GitHub account. Even so, care should be taken against committing any credentials or potentially sensitive information.

#### Branching

Projects follow the [GIT Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model, with development being performed on named branches. When a feature is complete, a pull request is opened in GitHub for review by another member of the team. Traditional GIT Flow allows for `feature`, `bug`, and `chore` branches. In addition, we encourage the use of any of the following available types which are used when composing the final commit message:

- **feat**: A new feature representing added user functionality
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **chore**: Other changes that don't modify src or test files

Once the feature is complete and marked as Ready to Merge, all commits are squashed into a single commit following our [Commit Message Format guidelines](#commit-message-format). The approved pull request will be merged as a fast-forward commit.

For this reason it is important that work on a feature or bug branch represent a narrow vertical slice of complete functionality. Refactoring neighboring code or fixing bugs should happen on their own branch unless they are directly required for the feature work being performed.

#### Commit message format

We follow [Google's Commit Message Guidelines](https://GitHub.com/angular/angular/blob/master/CONTRIBUTING.md#-commit-message-guidelines) to maintain consistent and more readable commit messages that are easier to follow when looking through the project history.

The scope in the commit header should correspond the feature's Label in the backlog. Epic labels should be used primarily with a generic label used for platform features which don't correspond to a particular Epic.

Work in progress development happening on feature branches do not need to adhere to this commit message format until a pull request is opened and marked as ready for merge. While a feature is in progress it is encouraged to commit often with descriptive messages. All commits representing a single piece of functionality will be squashed upon approval prior to merge.

### Code style

#### Javascript

All server-side Javascript should utilize any available [ECMAScript 2015 (ES6)](https://nodejs.org/en/docs/es6/) features supported by Node that do not require a runtime flag.

The majority of client-side Javascript must be written as standard ES5 Javascript without the use of cross-compilers. The main exception will be Angular2 projects, specifically if they are isomorphic in approach, as these may be written with ES6 features and transpiled to compatible server and client variants.

Code style follows a slightly relaxed Google Javascript style guide and should be linted with ESLint. See the [.eslintrc.js file](./.eslintrc.js) in this repository for the current list of exceptions configured.

#### Angular

In addition to the style guide above, client-side Angular components should conform to [johnpapa's Angular Style Guide](https://GitHub.com/johnpapa/angular-styleguide) with a specific emphasis towards structuring the application using Angular 1.5 `components` in preparation for Angular 2

#### CSS and SASS

Projects with CSS styling should be written in SASS and adhere to code style enforced by `sass-lint`. See the [.sass-lint.yml file](./.sass-lint.yml) and reference [sass-lint docs/rules](https://github.com/sasstools/sass-lint/tree/develop/docs/rules) for individual rule explanations.

#### Linting

Projects can be manually linted with `npm run lint`. If you are using Atom and have run the [environment provisioning scripts](https://github.com/treehouseaustin/environment-setup) your IDE comes configured with AtomLinter which will use all project-specific rules. If you are using a different IDE you should configure it with appropriate linting and not rely on the CI process to catch code style issues.

This repository should be included as a development dependency to ensure the ESLint configuration stays consistent across all projects:

1. `npm install @treehouse/guidelines eslint sass-lint --save-dev`

2. Add the following to `package.json`:
```
"eslintConfig": {
  "extends": [
    "./node_modules/@treehouse/guidelines/.eslintrc.js"
  ]
},
"sasslintConfig": "./node_modules/@treehouse/guidelines/.sass-lint.yml"
```

3. The following set of NPM scripts can be used:
```
"lint": "npm run lint:js && npm run lint:sass",
"lint:js": "./node_modules/.bin/eslint ./",
"lint:sass": "sass-lint 'frontend/**/*.scss' -v -q",
```

4. Additionally, it is recommended to add a `posttest` script aliasing the `npm run lint` function to automatically enforce lint rules in the CI environment.

### Documentation

All classes and server-side code should be documented with [JSDoc style](http://usejsdoc.org) comments, identifying the purpose of the function, arguments, and return values.

Client-side Angular components can be documented with [Docco style](http://jashkenas.github.io/docco/) comments to describe the purpose and intent of the code when it is not obvious by reading the code alone.

Project documentation can be generated with `npm run docs`.

### Testing

All development should be accompanied with a corresponding unit and (if applicable) end-to-end test. Feature work will not be approved for merge without coverage. Similarly, bug fixes will not be approved for merge without a corresponding regression test.

We use the following suite of tools for tests:

* **Mocha** for unit testing server-side code.
* **Karma and Jasmine** for unit testing Angular code.
* **Protractor** for end-to-end browser tests.
* **Istanbul** for code coverage reports.

Coverage reports are generated and stored in the `coverage` directory. These reports are generated in both `html` for developer visualization and `lcov` for reporting purposes.

[TravisCI](https://travis-ci.com) is used for Continuous Integration and will run the entire test suite. End-to-end browser tests are executed using the Firefox browser. All tests must be passing in TravisCI before the feature is approved for merge.
