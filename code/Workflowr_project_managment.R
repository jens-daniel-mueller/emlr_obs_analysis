# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "profiles revised")

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here("analysis",
                         c("index.Rmd",
                           "basics.Rmd",
                           "bottomdepth_budgets.Rmd",
                           "bottomdepth_column_inventories.Rmd",
                           "bottomdepth_zonal_sections.Rmd",
                           "no_p_budgets.Rmd",
                           "no_p_column_inventories.Rmd",
                           "no_p_zonal_sections.Rmd",
                           "no_n_budgets.Rmd",
                           "no_n_column_inventories.Rmd",
                           "no_n_zonal_sections.Rmd",
                           "gaps_filter_budgets.Rmd",
                           "gaps_filter_column_inventories.Rmd",
                           "gaps_filter_zonal_sections.Rmd",
                           "slab_budgets.Rmd",
                           "slab_column_inventories.Rmd",
                           "slab_zonal_sections.Rmd",
                           "classic_budgets.Rmd",
                           "classic_column_inventories.Rmd",
                           "classic_zonal_sections.Rmd",
                           "canyon_b_cleaning_overview.Rmd",
                           "canyon_b_cleaning_budgets.Rmd",
                           "canyon_b_cleaning_column_inventories.Rmd",
                           "canyon_b_cleaning_zonal_sections.Rmd",
                           "global_MLR_cleaning_budgets.Rmd",
                           "global_MLR_cleaning_column_inventories.Rmd",
                           "global_MLR_cleaning_zonal_sections.Rmd",
                           "rarefication_budgets.Rmd",
                           "rarefication_column_inventories.Rmd",
                           "rarefication_zonal_sections.Rmd",
                           "vif_budgets.Rmd",
                           "vif_column_inventories.Rmd",
                           "vif_zonal_sections.Rmd"
                           )),
              message = "add bottomdepth analysis",
              republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here("analysis",
                         c("index.Rmd",
                           "classic_budgets.Rmd",
                           "classic_column_inventories.Rmd",
                           "classic_zonal_sections.Rmd"
                           )),
              message = "profile analysis added")


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
