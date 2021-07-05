# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "compare gap filled vs regular output")

# commit changes including _site.yml (locally) and rebuild site
wflow_publish(c("analysis/*Rmd"), message = "XXX", republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here(
  "analysis",
  c(
    "index.Rmd",
    "Gruber_2019_comparison.Rmd",
    "column_inventories.Rmd",
    "anomalous_changes.Rmd",
    "observations.Rmd",
    "publication.Rmd"
  )
),
message = "rerun with observations",
republish = TRUE)


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
