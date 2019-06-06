# Quick R Repos

Quickly spin up an R repository populated with dummy packages.

## Init

To get started, run `npm install`

## Create packages

Run `npm run make` to create dummy packages. You will be prompted to edit a `DESCRIPTION` file,
which you can populate with a `Package` name, a `Version`, and dependency information. You can also
include a special `Path` field (e.g. `Path: 3.6.0/Recommended`), which will be honored. When you save
and exit the `DESCRIPTION` file, the script creates a dummy R package using the `DESCRIPTION` you 
provided and places it in the `public/src/contrib/` directory. If you included a special `Path` 
in the `DESCRIPTION`, the package will be placed at `public/src/contrib/<path>/`

## Serve the repo

Run `npm run api` to start a server. You can access the repo at `http://localhost:3004`. For example,
http://localhost:3004/src/contrib/PACKAGES.

## Configure R

You can easily configure R to use the service you've configured. If you're running R in a docker
container, replace `localhost` with your IP address or hostname.

```r
r <- getOption("repos");
r["CRAN"] <- "http://localhost:3004";
options(repos = r);
```

## Edit Templates

If you wish to change the `DESCRIPTION` file template, edit `DESCRIPTION_TEMPLATE`. If you wish
to change the R code included in the dummy package, edit `R_TEMPLATE`.
