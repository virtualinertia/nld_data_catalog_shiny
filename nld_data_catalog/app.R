#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

library(shiny)
library(tibble)
library(dplyr)

# Sample dataframes (replace these with your actual data)
nld_feature_definitions_df <- readRDS("nld_feature_definitions_df.rds")


nld_feature_catalog_df <- readRDS("nld_feature_catalog_df.rds") %>%
  arrange(display_order)


nld_domain_decodes_df <- readRDS("nld_domain_decodes_df.rds") %>%
  mutate(code = as.integer(code))


# UI
ui <- fluidPage(
  titlePanel("NLD Data Catalog"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_feature", "Select a Feature:",
                  choices = nld_feature_definitions_df$feature),
      tableOutput("feature_definitions_table"),
      width = 3
    ),
    mainPanel(
      fluidRow(
        column(
          width = 12,
          tableOutput("feature_catalog_table")
        )
      ),
      fluidRow(
        column(
          width = 12,
          selectInput("selected_domain", "Select a Domain:", choices = NULL),
          tableOutput("domain_decode_table")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  # Render the feature definitions table
  output$feature_definitions_table <- renderTable({
    nld_feature_definitions_df
  })
  
  # Render the filtered feature catalog table based on selected feature
  output$feature_catalog_table <- renderTable({
    selected_feature <- input$selected_feature
    filtered_catalog <- nld_feature_catalog_df %>%
      filter(feature_name == selected_feature)
    
    updateSelectInput(session, "selected_domain", 
                      choices = filtered_catalog$domain)
    
    filtered_catalog
  })
  
  # Render the domain decode table based on the selected domain
  output$domain_decode_table <- renderTable({
    selected_domain <- input$selected_domain
    nld_domain_decodes_df %>%
      filter(domain == selected_domain)
  })
}

# Run the app
shinyApp(ui, server)
