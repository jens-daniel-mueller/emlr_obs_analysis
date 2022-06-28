# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "GCB emissions ratio included")

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here(
  "analysis",
  c(
    "multi_model_assesment_AIP_budgets.Rmd",
    "multi_model_assesment_AIP_column_inventories.Rmd",
    "multi_model_assesment_AIP_zonal_sections.Rmd",
    "multi_model_assesment_5_budgets.Rmd",
    "multi_model_assesment_5_column_inventories.Rmd",
    "multi_model_assesment_5_zonal_sections.Rmd",
    "data_adjustment_cruise_budgets.Rmd",
    "data_adjustment_cruise_column_inventories.Rmd",
    "data_adjustment_cruise_zonal_sections.Rmd",
    "index.Rmd",
    "results_publication.Rmd",
    "data_adjustment_none_budgets.Rmd",
    "data_adjustment_none_column_inventories.Rmd",
    "data_adjustment_none_zonal_sections.Rmd",
    "MLR_target_budgets.Rmd",
    "MLR_target_column_inventories.Rmd",
    "MLR_target_zonal_sections.Rmd",
    "CN_target_budgets.Rmd",
    "CN_target_column_inventories.Rmd",
    "CN_target_zonal_sections.Rmd",
    "data_adjustment_bulk_budgets.Rmd",
    "data_adjustment_bulk_column_inventories.Rmd",
    "data_adjustment_bulk_zonal_sections.Rmd",
    "data_adjustment_none_budgets.Rmd",
    "data_adjustment_none_column_inventories.Rmd",
    "data_adjustment_none_zonal_sections.Rmd",
    "moving_eras_budgets.Rmd",
    "moving_eras_column_inventories.Rmd",
    "moving_eras_zonal_sections.Rmd",
    "reoccupation_budgets.Rmd",
    "reoccupation_column_inventories.Rmd",
    "reoccupation_zonal_sections.Rmd",
    "rarefication_budgets.Rmd",
    "rarefication_column_inventories.Rmd",
    "rarefication_zonal_sections.Rmd",
    "basics.Rmd",
    "G19_budgets.Rmd",
    "G19_column_inventories.Rmd",
    "G19_zonal_sections.Rmd",
    "indian_test_budgets.Rmd",
    "indian_test_column_inventories.Rmd",
    "indian_test_zonal_sections.Rmd",
    "MLR_predictor_budgets.Rmd",
    "MLR_predictor_column_inventories.Rmd",
    "MLR_predictor_zonal_sections.Rmd",
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
message = "rebuild with additional analysis",
republish = TRUE)


wflow_publish(here::here(
  "analysis",
  c(
    "multi_model_assesment_budgets.Rmd",
    "multi_model_assesment_column_inventories.Rmd",
    "multi_model_assesment_zonal_sections.Rmd",
    "gaps_filter_budgets.Rmd",
    "gaps_filter_column_inventories.Rmd",
    "gaps_filter_zonal_sections.Rmd"
  )
),
message = "rebuild with rerun analysis")



# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller

