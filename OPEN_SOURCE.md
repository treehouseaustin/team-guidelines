# Open Source Policy

The TreeHouse development team will actively use and contribute to existing open source projects in our application development. In fact, we want to run our team and develop each of our projects just like it were an open source project. There's a reason our team guidelines live in a repository in GitHub. Anyone on the team can submit a proposal or amendment to our guidelines through a pull request.

While care should be taken when selecting third-party code to integrate in our codebase, it should always be considered preferential to use an existing tool that does the job rather than re-creating our own. Generally, the following priority should be considered when evaluating the implementation of any new functionality:

1. Use an existing open source library.
  * Does it have a history of being maintained by multiple parties?
  * Are we using the library to it's full capability or only a small portion
    that could be solved by a more purpose-built utility function?
  * Can it's use reduce security or performance to the host application?
2. Implement needed features on a library we already use.
  * Do these features fit within the scope or intended use of the library?
  * Can we reasonably expect favorable response by maintainer(s) to the feature?
3. Implement needed feature in a modular component.
  * Can this functionality be used in other TreeHouse applications?
  * Can this functionality be beneficial to anyone outside of TreeHouse?
  * Release at private namespace and evaluate for public NPM publishing.
4. Implement purpose-built feature in host application.
