This repository contains three R tibbles and an app.R file to produce a simple Shiny app for exploring the National Levee Database data catalog.

It was built in Posit Cloud and is deployed on shinyapps.io at https://323kwp-alex-karman.shinyapps.io/nld_data_catalog/  .

The next task will be to make a shinylive webR application out of it, but so far the shinylive::export("shiny_app_dir", "site_dir") command fails.

It builds a static website structure with apparently broken javascript.
