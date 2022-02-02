# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "rearranged plots")

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here(
  "analysis",
  c(
    "index.Rmd",
    "reoccupation_budgets.Rmd",
    "reoccupation_column_inventories.Rmd",
    "reoccupation_zonal_sections.Rmd",
    "rarefication_budgets.Rmd",
    "rarefication_column_inventories.Rmd",
    "rarefication_zonal_sections.Rmd",
    "basics.Rmd",
    "results_publication.Rmd",
    "classic_budgets.Rmd",
    "classic_column_inventories.Rmd",
    "classic_zonal_sections.Rmd",
    "G19_budgets.Rmd",
    "G19_column_inventories.Rmd",
    "G19_zonal_sections.Rmd",
    "indian_test_budgets.Rmd",
    "indian_test_column_inventories.Rmd",
    "indian_test_zonal_sections.Rmd",
    "MLR_predictor_budgets.Rmd",
    "MLR_predictor_column_inventories.Rmd",
    "MLR_predictor_zonal_sections.Rmd",
    "MLR_target_budgets.Rmd",
    "MLR_target_column_inventories.Rmd",
    "MLR_target_zonal_sections.Rmd",
    "vif_budgets.Rmd",
    "vif_column_inventories.Rmd",
    "vif_zonal_sections.Rmd",
    "gaps_filter_budgets.Rmd",
    "gaps_filter_column_inventories.Rmd",
    "gaps_filter_zonal_sections.Rmd",
    "MLR_predictor_nitrate_budgets.Rmd",
    "MLR_predictor_nitrate_column_inventories.Rmd",
    "MLR_predictor_nitrate_zonal_sections.Rmd"
  )
),
message = "reoccupation filter implemented",
republish = TRUE)


# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here(
  "analysis",
  c(
    "classic_budgets.Rmd",
    "classic_column_inventories.Rmd",
    "classic_zonal_sections.Rmd"
  )
),
message = "rerun with vif_max = 0.95, and layer budgets per MLR_basin")


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
