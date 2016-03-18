## Development environment

A default local development environment can be quickly set up using our [Ansible provisioning scripts](https://github.com/treehouseaustin/environment-setup). This will install the Atom IDE and configure a basic Node environment with the `n` module available to quickly switch between Node versions on your local machine.

Once your development environment is configured, you can customize your toolsets or IDE as you see fit so long as any final pushed code aligns with Treehouse development guidelines and any agreed-upon conventions as determined by your team.

#### Node.js

The LTS (`4.x`) version of node has been selected for application development unless otherwise noted in a specific project.

#### Docker

Docker is being used to run databases locally depending on the specific project requirements. Kitematic is installed as a GUI for managing the running containers.

##### Databases

Databases will be determined by the project and it's specific needs. With that in mind, we will typically use the following databases:

* **MongoDB** for most dynamic models and associations.
* **Postgres** for customer records and Salesforce integration.
* **Redis**  for sessions and sockets along with caching where appropriate.
* **ElasticSearch** for analytics and reporting purposes.

All databases can be installed and run locally in a Docker container using Kitematic.

---

## Development guidelines

Any development must have a corresponding story before work has begun on the implementation. This story can take the form of a feature, bug or chore. More information on the [Backlog](./BACKLOG.md) and our feature development life cycle [can be found here](./BACKLOG.md).

### GIT

All code developed for TreeHouse projects must be tracked in version control through GIT. All repositories are stored on GitHub under the [TreeHouse organization](https://GitHub.com/treehouseaustin).

With the exception of generic components that we choose to open source, all repositories will be set to private in our GitHub account. Even so, care should be taken against committing any credentials or potentially sensitive information.

#### Branching

Projects follow the [GIT Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model, with development being performed on
`feature`, `bug`, or `chore` branches. When a feature is complete, a pull request is opened in GitHub for review by another member of the team.

Once the feature is complete and marked as Ready to Merge, all commits are squashed into a single commit following our [Commit Message Format guidelines](#commit-message-format). The approved pull request will be merged as a fast-forward commit.

For this reason it is important that work on a feature or bug branch represent a narrow vertical slice of complete functionality. Refactoring neighboring code or fixing bugs should happen on their own branch unless they are directly required for the feature work being performed.

### Code style

All server-side Javascript should utilize any available [ECMAScript 2015 (ES6)](https://nodejs.org/en/docs/es6/) features supported by Node that do not require a runtime flag.

The majority of client-side Javascript must be written as standard ES5 Javascript without the use of cross-compilers. The main exception will be Angular2 projects, specifically if they are isomorphic in approach, as these may be written with ES6 features and transpiled to compatible server and client variants.

Code style follows the Google Javascript style guide and should be linted with ESLint using the [Google config](https://github.com/google/eslint-config-google). Projects contain an `.eslintrc.js` which defines the Google configuration and exceptions. See the [.eslintrc.js file](./.eslintrc.js) in this repository for the current list of exceptions configured.

In addition to the style guide above, client-side Angular components should conform to [johnpapa's Angular Style Guide](https://GitHub.com/johnpapa/angular-styleguide) with a specific emphasis towards structuring the application using Angular 1.5 `components` in preparation for Angular 2

Projects can be manually linted with `npm run lint`. If you are using Atom and have run the [environment provisioning scripts](https://github.com/treehouseaustin/environment-setup) your IDE comes configured with AtomLinter which will use all project-specific rules. If you are using a different IDE you should configure it with appropriate linting and not rely on the CI process to catch code style issues.

#### Commit message format

We follow [Google's Commit Message Guidelines](https://GitHub.com/angular/angular/blob/master/CONTRIBUTING.md#-commit-message-guidelines) to maintain consistent and more readable commit messages that are easier to follow when looking through the project history.

The scope in the commit header should correspond the feature's Label in the backlog. Epic labels should be used primarily with a generic label used for platform features which don't correspond to a particular Epic.

Work in progress development happening on feature branches do not need to adhere to this commit message format until a pull request is opened and marked as ready for merge. While a feature is in progress it is encouraged to commit often with descriptive messages.

### Documentation

All classes and server-side code should be documented with [JSDoc style](http://usejsdoc.org) comments, identifying the purpose of the function, arguments,
and return values.

Client-side Angular components can be documented with [Docco style](http://jashkenas.GitHub.io/docco/) comments to describe the purpose and intent of the code when it is not obvious by reading the code alone.

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

---

## Solution architecture

Specific architecture decisions will be documented in their corresponding repositories. With that said, we will generally use the following technologies:

* **Sails and Express** for server-side API and models
* **Angular** for front-end and client-facing UX
* **SASS** for structured styling and responsive CSS

Whenever appropriate, new applications which can be built off the main services API will be structured as independent lightweight front-end applications. In this case, we will use an isomorphic approach with Angular 2, Express and NGINX.

Following best practices, all applications store sensitive configuration in the environment and not the codebase. Local configuration can be managed in `config/local.js` or using project-specific `.env` files to provide environment variables at run-time when developing locally.

#### Logging and metrics

[Winston](http://GitHub.com/winstonjs/winston) is used to declare various levels of verbosity in the log output. In production, only `info` level and above will be sent to [Logentries](https://logentries.com) for storage and aggregation. In development, the logging output can be adjusted for individual debugging needs but defaults to `verbose` and above.

In addition to standard logging, exception tracking in Production on both the server and the client will be reported through [Raygun](https://raygun.io/products/crash-reporting). This will include aggregation of full stack traces along with details on the user and browser when the exception occurred.

[New Relic APM](http://newrelic.com/application-monitoring) is used for storage and aggregation of all metrics from applications running in production. In addition, it will serve as uptime monitor and emergency alerts in the case of an issue in production.

#### Deployment

[Heroku](https://www.heroku.com) is used for all production applications, QA environments, and review apps. Each application will be configured in a [Pipeline](https://devcenter.heroku.com/articles/pipelines). This ensures that all code being reviewed at any stage in the feature development lifecycle is done so on an exact replica of the production environment.

![Heroku Pipeline](https://s3.amazonaws.com/heroku-devcenter-files/article-images/1456225758-Example-Pipeline.png)

[IBM Compose](https://www.compose.io) is used for all databases and provides automated backups and disaster recovery in addition to general database environment optimization and configuration. The only exception will be  data synced with Salesforce using [Heroku Connect](https://www.heroku.com/connect) which is stored using a [Heroku Postgres](https://www.heroku.com/postgres) database.

Due to ephemeral file systems on all production applications, any permanent file storage will utilize [Amazon S3 buckets](https://aws.amazon.com/s3/). When files are uploaded by users, a [CORS upload](https://aws.amazon.com/blogs/aws/amazon-s3-cross-origin-resource-sharing/) will be used to transfer the file directly between the user and S3 without involving the production application.

[Cloudflare](https://www.cloudflare.com) is used as both a CDN and a layer of threat mitigation. If custom proxying is required an additional proxy server may be used which runs [NGINX](http://nginx.org). Generally, all caching should be deferred to either Cloudflare **_or_** NGINX to avoid cache conflicts and prevent deployment complications.
