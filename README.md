# TreeHouse Team Guidelines

This repository contains all guidelines for the development team. This is meant as a living document and contributions or changes are welcome and can be discussed through the form of a Pull Request to this repository.

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

## Development guidelines

Team development guidelines and agreed-upon conventions should be observed at all times. More information on general team guidelines can be found in [Contributing Guidelines](./CONTRIBUTING.md).

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
