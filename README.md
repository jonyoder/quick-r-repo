# Quick R Repos

Quickly spin up an R repository.

## Init

To get started, run `npm install`

## Create packages

Run `npm run make` to create dummy packages. You will be prompted to edit a `DESCRIPTION` file,
which you can populate with a `Package` name, a `Version`, and dependency information. You can also
include a special `Path` field (e.g. `Path: 3.6.0/Recommended`).

## Serve the repo

Run `npm run api` to start a repository. You can access the repo at `http://localhost:3004`.

## Configure R

```r
r <- getOption("repos");
r["CRAN"] <- "http://localhost:3004";
options(repos = r);
```
