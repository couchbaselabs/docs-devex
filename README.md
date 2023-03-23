# docs-devex

This repository contains the Devex documentation shared across Server and Capella.

Right now, that documentation is the new Developer Guides for specific services. 

This repository is the implementation of the striping strategy that the Documentation team discussed at the 2023 Docs Summit. 

## How Does This Work? 

The goal of this repository is to create a consistent experience for shared content across Server and Capella. 

This repository contains branches for the different products and versions you would need to support with devex docs. 

By using an included partial `nav.adoc` file, you can seamlessly include documentation from this repository into the Server and Capella documentation. 

The workflow for developing documentation in this repository should look similar to the following: 

1. Choose your base product for developing the documentation. For example, you could decide to start writing your docs in a new feature branch based on the `release/7.2` branch for Server, or directly on that branch in a new folder under `modules`. 

2. Write your documentation files as normal.

3. Create a ToC in the `partials` folder for those documentation files: 

```
* xref:my-new-module:intro.adoc[]
** xref:my-new-module:new-content.adoc[]
```

4. Copy your new documentation files into the `capella` branch, or a new Capella feature branch based on your Server feature branch. 

5. Make the necessary tweaks for the documentation to apply to Capella. 

6. If you created feature branches for your work, merge them into the `release/7.2` or `capella` branches in this repository. 

7. Go to the `docs-server` and `couchbase-cloud` repositories, as described in [Configure Your Local nav.adoc Files](#configure-your-local-navadoc-files), and add your partials to those nav.adoc files. 

Ta-da, you've created devex documentation!

## How to Build Docs With This Repository

To add the content from the docs-devex repository to your local Antora builds: 

1. [Configure Your local-antora-playbook.yml](#configure-your-local-antora-playbookyml).

2. [Configure Your Local nav.adoc Files](#configure-your-local-navadoc-files).

3. In a terminal, run `antora local-antora-playbook.yml`.  

> **NOTE**: If you run into unexpected behavior when attempting to build (like files not appearing as expected, other errors), add the `--fetch` flag to the end of the `antora local-antora-playbook.yml` command. 

### Configure Your local-antora-playbook.yml

You need to start by including this repository in your `local-antora-playbook.yml` file: 

1. In the `docs-site` repository, open your `local-antora-playbook.yml` file in a text editor.

2. Under the `sources` key, add a new `url` entry for https://github.com/couchbaselabs/docs-devex. 

3. In the `branches` key for the new `url`, add the branches that you want to include in your build. For example, `[capella,release/7.2]` for the Couchbase Capella and Couchbase Server 7.2 branches.

4. Make sure that your `sources` key includes `url` keys for your local copies of the `couchbase-cloud` and `docs-server` repositories. 

> **NOTE**: If you want to create a build using a local copy of two different branches from the `docs-devex` repository, see [Use Worktrees to Create a Fully Local Build](#use-worktrees-to-create-a-fully-local-build).

### Configure Your Local nav.adoc Files

Then, make sure that you include the nav partial files into the navigation for Server and Capella: 

1. In your local copy of the `docs-server` repository, go to **modules** > **ROOT**. 

2. Open the `nav.adoc` file in a text editor. 

3. In the ToC structure, choose where you want to include the navigation for the devex branch. 

4. Add an include for the `nav.adoc` partial from the devex branch: 

```
include::<MODULE_NAME>:partial$nav.adoc[]
```

5. Repeat Steps 2-4 for the `couchbase-cloud` repository's `nav.adoc` file, located in **docs** > **public** > **modules** > **ROOT**. 


### Use Worktrees to Create a Fully Local Build

If you're creating new branches in the docs-devex repository and want to create a fully local build, you'll need to use git worktrees:

1. Open your `docs-devex` repository in a terminal window. 

2. In the terminal, enter `git worktree add <LOCAL_FOLDER_NAME> <BRANCH_NAME>`. It's recommended to give your local folder the same name as the branch. 

3. Repeat Step 2 for all of the branches you need on your local machine. 

4. In the `docs-site` repository, open your `local-antora-playbook.yml` file in a text editor.

5. Change the `url` key for the `docs-devex` branch to point to your local copy of the repository. 

6. Set the `branches` key for the `docs-devex` branch to include the branches you added as worktrees. 

7. Under the `branches` key, add a `worktrees` key set to `true`: 

```
- url: ../docs-devex
  branches: [my-server-branch, my-capella-branch]
  worktrees: true
```

You should be able to build your documentation using the local copies of your branches. 

When you want to make changes, edit the files in the specific worktree folder for your branch. 