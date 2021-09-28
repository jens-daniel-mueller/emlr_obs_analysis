# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "update zonal section plots")

# commit changes including _site.yml (locally) and rebuild site
wflow_publish(c("analysis/*Rmd"), message = "XXX", republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here("analysis",
                         c("index.Rmd",
                           "vif_budgets.Rmd",
                           "vif_column_inventories.Rmd",
                           "vif_zonal_sections.Rmd",
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
                           "rarefication_zonal_sections.Rmd"
                           )),
              message = "rebuildt with vif results",
              republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here("analysis",
                         c("index.Rmd",
                           "classic_budgets.Rmd",
                           "classic_column_inventories.Rmd",
                           "classic_zonal_sections.Rmd"
                           )),
              message = "filter MLR_basins")


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
