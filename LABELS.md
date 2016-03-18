# Issue labels

Labels are used for basic classification of issues representing areas of the application or large feature-sets. We use [Zenhub](https://www.zenhub.io) to further organize these issues into a task board representing the various areas in our development pipeline including our icebox, backlog, and any QA or review phases in the process. For this reason, labels are typically reserved for the classification of issues alone rather than being heavily used for process.

## General classification

All stories must have a general classification tag which at the highest level simply determine the [story type]([feature guidelines](./README.md#development-guidelines)):

* `type: feature` new functionality that delivers business value to a particular persona
* `type: bug` an issue that must be fixed on existing completed features
* `type: chore` a single piece of work on existing completed features such as small copy or design changes

### Epics

Epics are determined by the project and represent large buckets of functionality or areas of focus that are manifest over multiple stories. The Epic title will be included in the commit message scope and as such should be titled as a brief, one-word descriptor of the grouping.

### Area of focus

The following area of focus tags are primarily used to further classify bug or chores:

* `focus: backend` typically any code targeting Node.js or the API layer.
* `focus: frontend` all user facing code including HTML and CSS as well as front-end MVC work in Angular.
* `focus: performance` improvement to the backend or frontend performance; no new functionality has been added.
* `focus: refactor` typically paying down technical debt; no new functionality has been added.
* `focus: security` anything which affects the security of the product.

As features represent a complete vertical slice of functionality most will include work that crosses multiple areas of focus. In this instance the backend and frontend tags can be skipped since they do not add clarifying value to the story

## Priorities

Priority tags do not influence development order but provide additional context during sprint planning meetings. Unless categorized using a priority tag, all issues are considered of a "normal" priority.

* `P0: hotfix` Represent critical functionality that need to undergo a QA and release process independent of the current sprint plan. Typically reserved for situations where production systems are down, security is at risk, or the business operation is severely impacted with no available workaround.
* `P1: major` Issues that could otherwise be categorized as critical, but workarounds are available. These stories should typically move to the top of a sprint but will undergo a normal QA and deployment procedure following the conclusion of the sprint.
* `P2: high` Production systems are impacted but operating at an acceptable level. These may represent issues that are of stakeholder priority and the elevated priority should be considered in sprint planning but not automatically prioritized above all other work.
* `P3: low` Edge cases or known technical debt that should be considered for prioritization.

## Process

Process labels are identified by the "needs" prefix. These are primarily used to communicate state within various task board swim lanes. The following process labels have been defined:

* `needs: definition` Placeholder stories can be created and added to the icebox pending the completion of all necessary details. These stories are tagged to ensure they are not prioritized for development work until the story Definition of Ready has been met.
* `needs: sizing` The story has been defined but requires a numeric size associated with the relative difficulty of the work associated.
* `needs: clarification` This tag is primarily reserved for stories which have been prioritized or begun work but have since become blocked and need clarification from the business stakeholder or another developer.
* `needs: work` Used during the review phase; this story requires additional work before it can be considered complete.
* `needs: tests` Used during the review phase; additional test coverage is needed before it can be considered complete.
* `needs: rebase` Feature is complete and ready for merge but needs to rebased against the release branch to ensure a fast-forward merge can be initiated with no conflicts.
* `needs: merge` This feature has been completed and is ready for merge into a release branch.
