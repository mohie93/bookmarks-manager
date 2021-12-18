# bookmarks-manager
Web App to manage web-bookmarks

## App Documentation

[Google Doc](https://docs.google.com/document/d/1AyST23QVfu4GxHuhXVdViOot31ksvV0K5UUkKUXn8Ro/edit?usp=sharing)

## API Documentation

[Postman Doc](https://documenter.getpostman.com/view/3401137/UVRAHSPg)

## How to run the app locally:

- Make sure you have docker installed and running
- Clone from Github
- CD to the project directory
- Run command `docker-compose build`
- Run command `docker-compose up`
- Wait till the build completed
- Hit API via postman to `http://localhost:4000`

## How to deploy the app:
- Make sure you have heroku on your machine installed
- Get login credentials from your peers
- Login to heroku
- Run command `git remote add staging https://git.heroku.com/staging-bookmark-manager.git` to add remote repo
- Run command `git push heroku main` to build the code

## Todos:
- [ ] Add CI to manage deployment to reduce human errors
- [ ] Apply V2 todos
- [ ] Apply v3 todos

## Contribute:

Please take a moment to review this document in order to make the contribution process easy and effective for everyone involved.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open-source project. In return, they should reciprocate that respect in addressing your issue or assessing patches and features.

## Pull requests:

Good pull requests - patches, improvements, new features - are a fantastic help.
They should remain focused in scope and avoid containing unrelated commits.

Please ask first before embarking on any significant pull request
(e.g. implementing features, refactoring code, porting to a different language), otherwise, you risk spending a lot of time working on something that the project's developers might not want to merge into the project.

Please adhere to the coding conventions used throughout a project (indentation, accurate comments, etc.) and any other requirements (such as test coverage).

Follow this process if you'd like your work considered for inclusion in the project:

Fork the project, clone your fork, and configure the remotes:

## Clone your fork of the repo into the current directory

`git clone https://github.com/<your-username>/<repo-name>`

## Navigate to the newly cloned directory

cd `<repo-name>`

## Assign the original repo to a remote called "upstream"

git remote add upstream `https://github.com/<upstream-owner>/<repo-name>`
If you cloned a while ago, get the latest changes from upstream:

git checkout `<branch>` <br>
git pull upstream `<branch>`

Create a new topic branch (off the main project development branch) to contain your feature, change,
or fix:

git checkout -b `<topic-branch-name>`

Commit your changes in logical chunks.

Please adhere to these git commit message guidelines or your code is unlikely to be merged into the main project.

Use Git's interactive rebase feature to tidy up your commits before making them public.

Locally merge (or rebase) the upstream development branch into your topic branch:

git pull [--rebase] upstream `<dev-branch>`
Push your topic branch up to your fork:

git push origin `<topic-branch-name>`
Open a Pull Request with a clear title and description.

### IMPORTANT:

By submitting a patch, you agree to allow the project owner to license your work under the same license as that used by the project.
