# This script summarizes the central commands and steps to set-up and organize a R project
# using the Workflowr package.
# For details please refer to:
# https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html


# commit regular changes (locally) and rebuild site
wflow_publish(all = TRUE, message = "SDs vs rarefication threshold")

# commit changes including _site.yml (locally) and rebuild site
wflow_publish(c("analysis/*Rmd"), message = "XXX", republish = TRUE)

# commit changes including _site.yml (locally) and rebuild site in the specified order
wflow_publish(here::here("analysis",
                         c("index.Rmd",
                           "vif_budgets.Rmd",
                           "vif_column_inventories.Rmd",
                           "vif_zonal_sections.Rmd",
                           "vif_slab_inventories.Rmd",
                           "budgets.Rmd",
                           "column_inventories.Rmd",
                           "zonal_sections.Rmd",
                           "slab_inventories.Rmd",
                           "gap_filling_budgets.Rmd",
                           "gap_filling_column_inventories.Rmd",
                           "gap_filling_zonal_sections.Rmd",
                           "gap_filling_slab_inventories.Rmd",
                           "rarefication_budgets.Rmd",
                           "rarefication_column_inventories.Rmd",
                           "rarefication_zonal_sections.Rmd",
                           "rarefication_slab_inventories.Rmd",
                           "tref_zonal_sections.Rmd"
                           )),
              message = "rebuildt with vif analysis",
              republish = TRUE)


# Push latest version to GitHub
wflow_git_push()
jens-daniel-mueller
